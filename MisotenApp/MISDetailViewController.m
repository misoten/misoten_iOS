//
//  MISDetailViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/28.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISDetailViewController.h"

@interface MISDetailViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;

@end

@implementation MISDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 44)];
    _textField.backgroundColor = [UIColor grayColor];
    _textField.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:_textField];
    
    [self.textField.text addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 30)];
    [self.view addSubview:_label];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"aaa");
    // 変化した値がなにかを判別
    if ([keyPath isEqualToString:@"text"]) {
        NSLog(@"%@", change);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
