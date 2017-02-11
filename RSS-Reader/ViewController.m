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
#import "FeedSource.h"
#import "Feed.h"
#import "MainTableViewCell.h"
#import "Constants.h"
#import "FeedViewController.h"

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
    FeedSource *source = [[FeedSource alloc] initWithTitle:@"Apple's news"
                                                 urlString:kRSSTestString];

    [[SourcesManager sharedInstance] fetchFeedItemsForSource:source];
}

- (void)configureUI {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140.0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kFeedControllerSegueId]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Feed *feed = [SourcesManager sharedInstance].feeds[indexPath.section];
        FeedItem *item = feed.feedItems[indexPath.row];

        FeedViewController *destinationController = segue.destinationViewController;
        [destinationController configureWithFeed:item];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


#pragma mark - Notification handling

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark - UITableViewDataSource methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Feed *feed = [SourcesManager sharedInstance].feeds[section];

    return feed.source.srcTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [SourcesManager sharedInstance].feeds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Feed *feed = [SourcesManager sharedInstance].feeds[section];

    return feed.feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];

    if ([SourcesManager sharedInstance].feeds.count - 1 >= indexPath.section) {
        Feed *currentFeed = [SourcesManager sharedInstance].feeds[indexPath.section];

        if (currentFeed.feedItems.count - 1 >= indexPath.row) {
            FeedItem *feed = currentFeed.feedItems[indexPath.row];
            [cell configureCellWith:feed.title description:feed.feedDescription];
        }
    }

    return cell;
}

@end
