//
//  SourcesManager.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "SourcesManager.h"
#import "FeedItem.h"
#import "FeedSource.h"
#import "Feed.h"
#import "ConnectionSerivce.h"
#import "RSSParserService.h"
#import "Constants.h"

@interface SourcesManager() <RSSParserServiceDelegate>

@property (nonatomic, strong, nullable) ConnectionSerivce *connectionService;
@property (nonatomic, strong) NSMutableArray <RSSParserService *> *parserServices;

@property (nonatomic, strong) NSMutableArray <Feed *> *feeds;
@property (nonatomic, strong) NSMutableArray <FeedSource *> *feedSources;

@end


@implementation SourcesManager

+ (instancetype)sharedInstance {
    static SourcesManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        _feeds = [NSMutableArray new];
        _feedSources = [NSMutableArray new];
        _parserServices = [NSMutableArray new];
    }

    return self;
}


#pragma mark - Public methods

- (void)fetchFeedItemsForSource:(FeedSource *)rssSource {
    NSURL *url = [NSURL URLWithString:rssSource.srcUrlString];

    __weak typeof(self) weakSelf = self;
    [self.connectionService loadDataWithURL:url
                                 completion:^(NSData * _Nullable resultData, NSError * _Nullable error) {
        if (resultData != nil && error == nil) {
            RSSParserService *parserService = [RSSParserService new];
            parserService.delegate = self;
            [parserService parseData:resultData forFeedSource:rssSource];
            [weakSelf.parserServices addObject:parserService];
        }
    }];
}

- (NSArray<Feed *> *)feeds {
    return [_feeds copy];
}

- (NSArray <FeedSource *> *)feedSources {
    return [_feedSources copy];
}

- (void)addFeedSource:(FeedSource *)feedSource {
    [_feedSources addObject:feedSource];
    [self fetchFeedItemsForSource:feedSource];
}

- (void)removeFeedSource:(FeedSource *)feedSource {
    [_feedSources removeObject:feedSource];

    for (Feed *feed in self.feeds) {
        if ([feed.source.srcTitle isEqualToString:feedSource.srcTitle] &&
            [feed.source.srcUrlString isEqualToString:feedSource.srcUrlString]) {
            [_feeds removeObject:feed];
            break;
        }
    }

    [self postUpdateNotification];
}


#pragma mark - Private methods

- (ConnectionSerivce *)connectionService {
    if (_connectionService == nil) {
        _connectionService = [ConnectionSerivce new];
    }

    return _connectionService;
}

- (void)postUpdateNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRSSDataUpdated
                                                        object:nil];
}


#pragma mark - RSSParserServiceDelegate methods

- (void)handleParsedData:(NSArray<FeedItem *> *)feeds
           forFeedSource:(FeedSource *)feedSource
                  parser:(RSSParserService *)parserService {
    Feed *feed = [[Feed alloc] initWithSource:feedSource feedItems:feeds];
    [_feeds addObject:feed];
    [self.parserServices removeObject:parserService];

    [self postUpdateNotification];
}

@end
