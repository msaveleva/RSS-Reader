//
//  SourcesManager.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedItem;
@class FeedSource;
@class Feed;

NS_ASSUME_NONNULL_BEGIN

@interface SourcesManager : NSObject

+ (instancetype)sharedInstance;

/// Returnes fetched and parsed feed items. Available after kNotificationRSSDataReceived notification received. 
- (NSArray <Feed *> *)feeds;

///Returns all feed sources.
- (NSArray <FeedSource *> *)feedSources;
- (void)addFeedSource:(FeedSource *)feedSource;
- (void)removeFeedSource:(FeedSource *)feedSource; 

@end

NS_ASSUME_NONNULL_END
