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

/// Handle all model changes. Posts kNotificationRSSDataUpdated when data changes.
@interface SourcesManager : NSObject

+ (instancetype)sharedInstance;

/// Returnes fetched and parsed feed items.
- (NSArray <Feed *> *)feeds;

///Returns all feed sources.
- (NSArray <FeedSource *> *)feedSources;

/// Add new feed source and load feeds for it.
- (void)addFeedSource:(FeedSource *)feedSource;

/// Remove feed source and feeds for it. 
- (void)removeFeedSource:(FeedSource *)feedSource; 

@end

NS_ASSUME_NONNULL_END
