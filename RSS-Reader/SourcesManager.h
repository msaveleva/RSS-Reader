//
//  SourcesManager.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedItem;

NS_ASSUME_NONNULL_BEGIN

@interface SourcesManager : NSObject

+ (instancetype)sharedInstance;

/// Start fetching an array of feed items for rss source.
- (void)fetchFeedItemsForSource:(NSString *)rssSource;

/// Returnes fetched and parsed feed items. Available after kNotificationRSSDataReceived notification received. 
- (nullable NSArray <FeedItem *> *)feeds;

@end

NS_ASSUME_NONNULL_END
