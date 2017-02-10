//
//  FeedSource.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 10/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedSource : NSObject

- (NSString *)srcTitle;
- (NSString *)srcUrlString;

- (instancetype)initWithTitle:(NSString *)title urlString:(NSString *)urlString;

@end
