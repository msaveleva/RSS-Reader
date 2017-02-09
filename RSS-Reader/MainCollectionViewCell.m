//
//  MainCollectionViewCell.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 09/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "MainCollectionViewCell.h"

@interface MainCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end


@implementation MainCollectionViewCell

#pragma mark - Public methods

- (void)configureCellWith:(NSString *)title description:(NSString *)description {
    self.titleLabel.text = title;
    self.descriptionLabel.text = description;
}

@end
