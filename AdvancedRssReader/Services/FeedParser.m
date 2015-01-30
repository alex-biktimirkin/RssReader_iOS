//
//  FeedParser.m
//  AdvancedRssReader
//
//  Created by alex_b on 27/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import "FeedParser.h"
#import "Publication.h"

@interface FeedParser ()<NSXMLParserDelegate>

@property (strong, nonatomic) Publication *publication;
@property (strong, nonatomic) NSString *currentKey;
@property (strong, nonatomic) NSString *currentValue;
@property (nonatomic, copy) void (^publicationFoundHandler)(Publication *);

@end

@implementation FeedParser

- (void)parseFeedFromXml:(NSData *)xml publicationFoundHandler:(void (^)(Publication *))publicationFoundHandler;
{
    self.publicationFoundHandler = publicationFoundHandler;
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xml];
    xmlParser.delegate = self;
    
    if (![xmlParser parse])
        NSLog(@"XML parser failed: %@", [xmlParser.parserError description]);
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"item"])
        self.publication = [Publication new];
    else if (self.publication != nil)
        self.currentKey = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.publication != nil && self.currentKey != nil)
        self.currentValue = string;
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    if (self.publication != nil && self.currentKey != nil)
        self.currentValue = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if (self.publication != nil)
    {
        if ([elementName isEqualToString:@"item"])
        {
            self.publicationFoundHandler(self.publication);
            self.publication = nil;
        }
        else if ([elementName isEqualToString:@"title"])
        {
            self.publication.title = self.currentValue;
            self.currentKey = nil;
        }
        else if ([elementName isEqualToString:@"author"])
        {
            self.publication.author = self.currentValue;
            self.currentKey = nil;
        }
        else if ([elementName isEqualToString:@"link"])
        {
            self.publication.url = [NSURL URLWithString:self.currentValue];
            self.currentKey = nil;
        }
        else if ([elementName isEqualToString:@"description"])
        {
            self.publication.desc = self.currentValue;
            self.currentKey = nil;
        }
        else if ([elementName isEqualToString:@"pubDate"])
        {
            static NSString *dateFormat = @"ccc, d LLL yyyy HH:mm:ss zzz";
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:dateFormat];
            self.publication.date = [formatter dateFromString:self.currentValue];
            self.currentKey = nil;
        }
    }
}

@end