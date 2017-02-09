//
//  FeedItem.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "FeedItem.h"

@interface FeedItem()

@property (nonatomic, strong, nullable) NSString *title;
@property (nonatomic, strong, nullable) NSString *feedDescription;

@end

@implementation FeedItem

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                      feedDescription:(nullable NSString *)feedDescription {
    self = [super init];

    if (self) {
        _title = title;
        _feedDescription = feedDescription;
    }

    return self;
}

@end
