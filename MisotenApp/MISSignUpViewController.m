//
//  MISSignUpViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/12.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISSignUpViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "MISLoginViewController.h"
@import Firebase;
@import FirebaseAuth;

@interface MISSignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, assign, getter=isMailError) BOOL mailError;
@property (nonatomic, assign, getter=isPasswordError) BOOL passwordError;

@end

@implementation MISSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)signUp:(id)sender {
    if(_mailAddressTextField.text.length == 0) {
        NSLog(@"メールアドレスを入力してください");
        _mailError = YES;
    } else {
        _mailError = NO;
    }
    if(_passwordTextField.text.length == 0) {
        NSLog(@"パスワードを入力してください");
        _passwordError = YES;
    } else {
        _passwordError = NO;
    }
    
    if(!_mailError && !_passwordError) {
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [self performSelector:@selector(segueLoginViewController) withObject:nil afterDelay:2.0f];
    }
}

- (void)segueLoginViewController {
    [[FIRAuth auth] createUserWithEmail:_mailAddressTextField.text password:_passwordTextField.text completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
        if(!error) {
            [SVProgressHUD showSuccessWithStatus:@"アカウントが作成されました"];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"Root"];
            [self presentViewController: navigationController animated:YES completion: nil];
        } else {
            [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
            [SVProgressHUD showErrorWithStatus:@"ERROR"];
        }
    }];
    
    
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
