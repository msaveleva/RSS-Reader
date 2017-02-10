//
//  FeedViewController.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 11/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.ru"]];
    [self.webView loadRequest:request];
}

@end
