//
//  Feed.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 10/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "Feed.h"
#import "FeedItem.h"
#import "FeedSource.h"

@interface Feed ()

@property (nonatomic, strong) FeedSource *source;
@property (nonatomic, strong) NSArray <FeedItem *> *feedItems;

@end

@implementation Feed

- (instancetype)initWithSource:(FeedSource *)source feedItems:(NSArray <FeedItem *> *)feedItems {
    self = [super init];

    if (self) {
        _source = source;
        _feedItems = feedItems;
    }

    return self;
}

@end
