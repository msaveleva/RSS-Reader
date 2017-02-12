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

@property (nonatomic, strong, nullable) UIAlertController *alertController;
@property (nonatomic, strong, nullable) UITextField *sourceTitleTextField;
@property (nonatomic, strong, nullable) UITextField *sourceURLTextField;

@end

@implementation SourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark - Actions

- (IBAction)addRSSSource:(id)sender {
    [self presentViewController:self.alertController animated:YES completion:nil];
}

#pragma mark - Private methods

- (UIAlertController *)alertController {
    if (_alertController == nil) {
        //alert controller
        _alertController = [UIAlertController alertControllerWithTitle:@"Add RSS source"
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleAlert];

        //textfields
        __weak typeof(self) weakSelf = self;
        [_alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            weakSelf.sourceTitleTextField = textField;
            textField.placeholder = @"Source title";
        }];

        [_alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            weakSelf.sourceURLTextField = textField;
            textField.placeholder = @"Enter URL";
        }];

        //actions
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {}];
        [_alertController addAction:cancelAction];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            BOOL isValidTitle = [weakSelf isValidTitle:weakSelf.sourceTitleTextField.text];
            BOOL isValidURL = [weakSelf isValidLink:weakSelf.sourceURLTextField.text];
            if (isValidTitle && isValidURL) {
                //TODO: update data
            } else {
                if (!isValidTitle) {
                    NSLog(@"Error: invalid title");
                }
                if (!isValidURL) {
                    NSLog(@"Error: invalid URL");
                }
            }
        }];
        [_alertController addAction:okAction];
    }

    return _alertController;
}

- (BOOL)isValidTitle:(NSString *)title {
    return title.length == 0 ? NO : YES;
}

- (BOOL)isValidLink:(NSString *)link {
    NSURL *urlString = [NSURL URLWithString:link];

    if (urlString != nil && urlString.scheme != nil && urlString.host != nil) {
        return YES;
    } else {
        return NO;
    }
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
