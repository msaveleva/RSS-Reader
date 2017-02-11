//
//  FeedViewController.h
//  RSS-Reader
//
//  Created by MariaSaveleva on 11/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedItem;

@interface FeedViewController : UIViewController

- (void)configureWithFeed:(FeedItem *)feedItem;

@end
