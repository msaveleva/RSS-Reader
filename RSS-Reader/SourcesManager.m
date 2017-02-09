//
//  SourcesManager.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "SourcesManager.h"
#import "FeedItem.h"
#import "ConnectionSerivce.h"
#import "RSSParserService.h"
#import "Constants.h"

@interface SourcesManager() <RSSParserServiceDelegate>

@property (nonatomic, strong, nullable) ConnectionSerivce *connectionService;
@property (nonatomic, strong, nullable) RSSParserService *parserService;
@property (nonatomic, strong, nullable) NSArray <FeedItem *> *feeds;

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


#pragma mark - Public methods

- (void)fetchFeedItemsForSource:(NSString *)rssSource {
    NSURL *url = [NSURL URLWithString:rssSource];
    [self.connectionService loadDataWithURL:url completion:^(NSData * _Nullable resultData, NSError * _Nullable error) {
        if (resultData != nil && error == nil) {
            //TODO: fix to weakself
            [self.parserService parseData:resultData];
        }
    }];
}


#pragma mark - Private methods

- (ConnectionSerivce *)connectionService {
    if (_connectionService == nil) {
        _connectionService = [ConnectionSerivce new];
    }

    return _connectionService;
}

- (RSSParserService *)parserService {
    if (_parserService == nil) {
        _parserService = [RSSParserService new];
        _parserService.delegate = self;
    }

    return _parserService;
}


#pragma mark - RSSParserServiceDelegate methods

- (void)handleParsedData:(NSArray<FeedItem *> *)feeds {
    self.feeds = feeds;

    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRSSDataReceived
                                                        object:nil];
}

@end
