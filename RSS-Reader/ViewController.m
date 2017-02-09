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
#import "MainCollectionViewCell.h"
#import "Constants.h"

static NSString * const kCellId = @"MainCollectionViewCellId";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //TODO: remove
    [self testLoadingFeeds];
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


#pragma mark - Notification handling

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1; //TODO: change
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [SourcesManager sharedInstance].feeds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId
                                                                             forIndexPath:indexPath];
    if (([SourcesManager sharedInstance].feeds.count - 1) >= indexPath.row) {
        FeedItem *feed = [SourcesManager sharedInstance].feeds[indexPath.row];
        [cell configureCellWith:feed.title description:feed.feedDescription];
    }

    return cell;
}

@end
