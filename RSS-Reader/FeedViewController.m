//
//  FeedViewController.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 11/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedItem.h"

@interface FeedViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic, nullable) FeedItem *feedItem;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSString *encodedLink =
    [self.feedItem.link stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:encodedLink]];
    [self.webView loadRequest:request];
}


#pragma mark - Public methods

- (void)configureWithFeed:(FeedItem *)feedItem {
    self.feedItem = feedItem;
}


#pragma mark - UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error during loading page: %@", error.description); 
}

@end
