//
//  ViewController.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "ViewController.h"
#import "SourcesManager.h"
#import "FeedItem.h"
#import "MainTableViewCell.h"
#import "Constants.h"

static NSString * const kCellId = @"MainTableViewCellId";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //TODO: remove
    [self testLoadingFeeds];
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:kNotificationRSSDataReceived
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//TODO: remove
- (void)testLoadingFeeds {
    NSString *kRSSTestString = @"http://images.apple.com/main/rss/hotnews/hotnews.rss";
    [[SourcesManager sharedInstance] fetchFeedItemsForSource:kRSSTestString];
}

- (void)configureUI {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140.0;
}


#pragma mark - Notification handling

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; //TODO: change
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SourcesManager sharedInstance].feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (([SourcesManager sharedInstance].feeds.count - 1) >= indexPath.row) {
        FeedItem *feed = [SourcesManager sharedInstance].feeds[indexPath.row];
        [cell configureCellWith:feed.title description:feed.feedDescription];
    }

    return cell;
}

@end
