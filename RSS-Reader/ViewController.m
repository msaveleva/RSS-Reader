//
//  ViewController.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "ViewController.h"
#import "SourcesManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testLoadingFeeds];
}


- (void)testLoadingFeeds {
    NSString *kRSSTestString = @"http://images.apple.com/main/rss/hotnews/hotnews.rss";
    [[SourcesManager sharedInstance] fetchFeedItemsForSource:kRSSTestString completion:^(NSArray<FeedItem *> * _Nonnull items) {
        //check data
    }];
}


@end
