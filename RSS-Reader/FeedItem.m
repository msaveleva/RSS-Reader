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
@property (nonatomic, strong, nullable) NSString *link;

@end

@implementation FeedItem

- (instancetype)initWithTitle:(nullable NSString *)title
              feedDescription:(nullable NSString *)feedDescription
                         link:(nullable NSString *)link {
    self = [super init];

    if (self) {
        _title = title;
        _feedDescription = feedDescription;
        _link = link;
    }

    return self;
}

@end
