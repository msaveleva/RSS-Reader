//
//  RSSParserService.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedItem;

@interface RSSParserService : NSObject <NSXMLParserDelegate>

- (void)parseData:(NSData *)data;

@end
