//
//  Feed.h
//  AdvancedRssReader
//
//  Created by alex_b on 27/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSMutableArray *publications;

+ (Feed *)feedWithTitle:(NSString *)title
                    url:(NSURL *)url
            description:(NSString *)description
               imageUrl:(NSURL *)imageUrl;

@end
