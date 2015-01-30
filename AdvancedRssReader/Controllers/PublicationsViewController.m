//
//  PublicationsViewController.m
//  AdvancedRssReader
//
//  Created by alex_b on 21/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import "PublicationsViewController.h"
#import "PublicationViewController.h"
#import "FeedParser.h"
#import "Publication.h"

@interface PublicationsViewController ()

@property (strong, nonatomic) NSMutableArray *publications;

@end

@implementation PublicationsViewController

- (void)clearPublications {
    if (self.publications == nil)
        self.publications = [NSMutableArray new];
    else
        [self.publications removeAllObjects];
    [self.tableView reloadData];
}

- (void)refreshFeed {
    if (self.feed == nil)
        return;
    
    id publicationFoundHandler = ^(Publication *item) {
        [self.publications addObject:item];
        int index = (int)self.publications.count-1;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        });
    };
    
    id sessionCompletionHandler = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode != 200)
            return;
        
        [self clearPublications];
        
        FeedParser *parser = [FeedParser new];
        [parser parseFeedFromXml:data publicationFoundHandler:publicationFoundHandler];
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:self.feed.url completionHandler:sessionCompletionHandler] resume];
}

- (IBAction)refresh:(id)sender {
    [self refreshFeed];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (![segue.identifier isEqualToString:@"showPublication"])
        return;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Publication *publication = self.publications[indexPath.row];
    PublicationViewController *controller = (PublicationViewController *)[[segue destinationViewController] topViewController];
    controller.publication = publication;
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.publications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"DetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    Publication *item = self.publications[indexPath.row];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *articleDateString = [dateFormatter stringFromDate:item.date];
    
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", articleDateString, item.author];
    
    return cell;
}

@end
