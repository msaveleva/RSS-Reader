//
//  SourcesManager.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "SourcesManager.h"
#import "AFNetworking.h"
#import "FeedItem.h"

@interface SourcesManager ()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

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

- (void)fetchFeedItemsForSource:(NSString *)rssSource
                     completion:(nullable void (^)(NSArray<FeedItem *> *items))completion {
    NSURLRequest *rssRequest = [self createRequestFor:rssSource];
    NSURLSessionDownloadTask *downloadTask = [self.sessionManager downloadTaskWithRequest:rssRequest progress:nil destination:nil completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //TODO: handle downloaded data or error
    }];

    [downloadTask resume];
}


#pragma mark Private methods

- (AFURLSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }

    return _sessionManager;
}

- (NSURLRequest *)createRequestFor:(NSString *)rssSource {
    NSURL *url = [NSURL URLWithString:rssSource];

    return [NSURLRequest requestWithURL:url];
}

@end
