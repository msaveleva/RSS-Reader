//
//  ConnectionSerivce.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "ConnectionSerivce.h"

@implementation ConnectionSerivce

- (void)loadDataWithURL:(NSURL *)rssURL
             completion:(nullable void (^)(NSData * _Nullable resultData, NSError * _Nullable error))completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session dataTaskWithURL:rssURL
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion) {
            completion(data, error);
        }
    }];

    [downloadTask resume];
}

@end
