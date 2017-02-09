//
//  RSSParserService.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedItem;

@protocol RSSParserServiceDelegate <NSObject>

- (void)handleParsedData:(NSArray <FeedItem *> *)feeds;

@end

@interface RSSParserService : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) id<RSSParserServiceDelegate> delegate;

/// Parses RSS XML data.
- (void)parseData:(NSData *)data;

@end
