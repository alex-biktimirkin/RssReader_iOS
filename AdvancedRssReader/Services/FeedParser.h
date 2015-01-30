//
//  FeedParser.h
//  AdvancedRssReader
//
//  Created by alex_b on 27/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Publication.h"

@interface FeedParser : NSObject

- (void)parseFeedFromXml:(NSData *)xml publicationFoundHandler:(void (^)(Publication *))publicationFoundHandler;

@end