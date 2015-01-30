//
//  Publication.h
//  RssReader
//
//  Created by alex_b on 05/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

@interface Publication : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isSeen;
@property (strong, nonatomic) Feed *feed;

+ (Publication *)publicationWithTitle:(NSString *)title
                               author:(NSString *)author
                          description:(NSString *)description
                                  url:(NSURL *)url
                                 date:(NSDate *)date
                                 feed:(Feed *)feed;

@end
