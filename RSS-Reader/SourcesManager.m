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

@interface SourcesManager()

@property (nonatomic, strong, nullable) ConnectionSerivce *connectionService;
@property (nonatomic, strong, nullable) RSSParserService *parserService;

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

- (void)fetchFeedItemsForSource:(NSString *)rssSource completion:(nullable void (^)(NSArray<FeedItem *> *items))completion {
    NSURL *url = [NSURL URLWithString:rssSource];
    [self.connectionService loadDataWithURL:url completion:^(NSData * _Nullable resultData, NSError * _Nullable error) {
        NSLog(@"%@", resultData);

        if (resultData != nil && error == nil) {
            //TODO: fix to weakself
            [self.parserService parseData:resultData];
        }
    }];

    //TODO: parse data with parsing service
}


#pragma mark Private methods

- (ConnectionSerivce *)connectionService {
    if (_connectionService == nil) {
        _connectionService = [ConnectionSerivce new];
    }

    return _connectionService;
}

- (RSSParserService *)parserService {
    if (_parserService == nil) {
        _parserService = [RSSParserService new];
    }

    return _parserService;
}

@end
