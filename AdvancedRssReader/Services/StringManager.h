//
//  StringManager.h
//  AdvancedRssReader
//
//  Created by alex_b on 28/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringManager : NSObject

+ (BOOL)isNilOrEmptyString:(NSString *)string;
+ (NSURL *)getUrlFromString:(NSString *)string;

@end
