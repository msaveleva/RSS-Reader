//
//  RSSParserService.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedItem;
@class FeedSource;
@class RSSParserService;

@protocol RSSParserServiceDelegate <NSObject>

- (void)handleParsedData:(NSArray <FeedItem *> *)feeds
           forFeedSource:(FeedSource *)feedSource
                  parser:(RSSParserService *)parserService;

@end

@interface RSSParserService : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) id<RSSParserServiceDelegate> delegate;

/// Parses RSS XML data for a given feed source.
- (void)parseData:(NSData *)data forFeedSource:(FeedSource *)feedSource;

@end
