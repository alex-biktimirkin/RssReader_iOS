//
//  Publication.m
//  RssReader
//
//  Created by alex_b on 05/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Publication.h"

@implementation Publication

+ (Publication *)publicationWithTitle:(NSString *)title
                               author:(NSString *)author
                          description:(NSString *)description
                                  url:(NSURL *)url
                                 date:(NSDate *)date
                                 feed:(Feed *)feed
{
    Publication *item = [Publication new];
    item.title = title;
    item.author = author;
    item.desc = description;
    item.url = url;
    item.date = date;
    item.feed = feed;
    item.isSeen = false;
    return item;
}

@end
