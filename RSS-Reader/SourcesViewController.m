//
//  SourcesViewController.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 11/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "SourcesViewController.h"

static NSString * const kSrouceCellId = @"SrouceCellId";

@interface SourcesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIAlertController *addAlertController;

@end

@implementation SourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark - Actions

- (IBAction)addRSSSource:(id)sender {

}

#pragma mark - Private methods

- (UIAlertController *)addAlertController {
    if (_addAlertController == nil) {
        _addAlertController = [UIAlertController alertControllerWithTitle:@"Add RSS source"
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
            //do nothing
        }];
        [_addAlertController addAction:cancelAction];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //TODO: implement
        }];
        [_addAlertController addAction:okAction];
    }

    return _addAlertController;
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSrouceCellId];

    return cell;
}

@end
