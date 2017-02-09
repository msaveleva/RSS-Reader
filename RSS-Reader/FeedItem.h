//
//  FeedItem.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject

- (nullable NSString *)title;
- (nullable NSString *)feedDescription;

/// Creates an instance of FeedItem with title and feedDescription.
- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                      feedDescription:(nullable NSString *)feedDescription;

@end
