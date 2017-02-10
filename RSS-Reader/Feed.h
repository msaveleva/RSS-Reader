//
//  Feed.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 10/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedItem;
@class FeedSource;

NS_ASSUME_NONNULL_BEGIN

@interface Feed : NSObject

- (nullable NSArray <FeedItem *> *)feedItems;
- (FeedSource *)source;

- (instancetype)initWithSource:(FeedSource *)source feedItems:(NSArray <FeedItem *> *)feedItems;

@end

NS_ASSUME_NONNULL_END
