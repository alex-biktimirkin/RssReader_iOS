//
//  FeedsViewController.h
//  AdvancedRssReader
//
//  Created by alex_b on 21/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class PublicationsViewController;

@interface FeedsViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

