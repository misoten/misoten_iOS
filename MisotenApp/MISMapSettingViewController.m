//
//  MISMapSettingViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/16.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISMapSettingViewController.h"
#import "ActionSheetPicker.h"
#import "MISMapSettingModel.h"

@interface MISMapSettingViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mapTypeTextField;
@property (nonatomic, strong)  MISMapSettingModel *settingModel;

@end

@implementation MISMapSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //_settingModel = [[MISMapSettingModel alloc] init];
    _mapTypeTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSArray *items = @[@"標準", @"ハイブリッド", @"航空写真", @"地形図"];
    __block int index=0;
    
    ActionSheetStringPicker *actionSheetPicker
    = [[ActionSheetStringPicker alloc] initWithTitle:@"マップタイプ"
                                                rows:items
                                    initialSelection:index
                                           doneBlock: ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               _mapTypeTextField.text = selectedValue;
                                               index = (int)selectedIndex;
                                           } cancelBlock:^(ActionSheetStringPicker *picker) {
                                               NSLog(@"Cancel Selected");
                                           } origin:textField];
    [actionSheetPicker showActionSheetPicker];

    return NO;
}
- (IBAction)hierarchySwitch:(id)sender {
    //_settingModel.hierarchy = NO;
}
- (IBAction)compassSwitch:(id)sender {
    //_settingModel.compass = NO;
}
- (IBAction)closeSettingView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
