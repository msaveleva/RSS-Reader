//
//  ConnectionSerivce.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConnectionSerivce : NSObject

/// Load NSData from given URL.
- (void)loadDataWithURL:(NSURL *)rssURL
             completion:(nullable void (^)(NSData * _Nullable resultData, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
