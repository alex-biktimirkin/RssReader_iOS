//
//  Feed.m
//  AdvancedRssReader
//
//  Created by alex_b on 27/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import "Feed.h"

@implementation Feed

+ (Feed *)feedWithTitle:(NSString *)title
                    url:(NSURL *)url
            description:(NSString *)description
               imageUrl:(NSURL *)imageUrl
{
    Feed *newFeed = [Feed new];
    newFeed.title = title;
    newFeed.url = url;
    newFeed.desc = description;
    newFeed.imageUrl = imageUrl;
    newFeed.publications = [NSMutableArray new];
    return newFeed;
}

@end
