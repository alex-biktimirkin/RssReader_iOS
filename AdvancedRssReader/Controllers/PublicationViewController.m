//
//  PublicationViewController.m
//  AdvancedRssReader
//
//  Created by alex_b on 29/01/15.
//  Copyright (c) 2015 alex_b. All rights reserved.
//

#import "PublicationViewController.h"

@interface PublicationViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PublicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.publication != nil)
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.publication.url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [super viewWillDisappear:animated];
}

@end
