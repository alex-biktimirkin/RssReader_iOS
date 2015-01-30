//
//  StringManager.m
//  AdvancedRssReader
//
//  Created by alex_b on 28/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import "StringManager.h"

@implementation StringManager

+ (BOOL)isNilOrEmptyString:(NSString *)string
{
    return string == nil || [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0;
}

+ (NSURL *)getUrlFromString:(NSString *)string
{
    if ([StringManager isNilOrEmptyString:string])
        return nil;
    
    NSString *stringWithSchema = string;
    if (![stringWithSchema containsString:@"://"])
        stringWithSchema = [NSString stringWithFormat:@"http://%@", string];
        
    NSString *formattedUrlString = [stringWithSchema stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:formattedUrlString];
}

@end
