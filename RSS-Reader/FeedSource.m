//
//  FeedSource.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 10/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "FeedSource.h"

@interface FeedSource ()

@property (nonatomic, strong) NSString *srcTitle;
@property (nonatomic, strong) NSString *srcUrlString;

@end

@implementation FeedSource

- (instancetype)initWithTitle:(NSString *)title urlString:(NSString *)urlString {
    self = [super init];

    if (self) {
        _srcTitle = title;
        _srcUrlString = urlString;
    }

    return self;
}

@end
