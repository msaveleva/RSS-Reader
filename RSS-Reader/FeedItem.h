//
//  FeedItem.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedItem : NSObject

- (nullable NSString *)title;
- (nullable NSString *)feedDescription;
- (nullable NSString *)link;

- (instancetype)initWithTitle:(nullable NSString *)title
              feedDescription:(nullable NSString *)feedDescription
                         link:(nullable NSString *)link;

@end

NS_ASSUME_NONNULL_END
