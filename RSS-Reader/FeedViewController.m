//
//  FeedViewController.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 11/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedItem.h"

@interface FeedViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic, nullable) FeedItem *feedItem;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark - Public methods

- (void)configureWithFeed:(FeedItem *)feedItem {
    self.feedItem = feedItem;

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.feedItem.link]];
    [self.webView loadRequest:request];
}

@end
