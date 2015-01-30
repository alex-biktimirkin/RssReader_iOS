//
//  PublicationsViewController.h
//  AdvancedRssReader
//
//  Created by alex_b on 21/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

@interface PublicationsViewController : UITableViewController

@property (strong, nonatomic) Feed *feed;

@end