//
//  MISTouristInformationViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/07.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISTouristInformationViewController.h"
#import "MISSearchDetailViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "MISSearchResultCell.h"
#import "MISTouristInformationDetailViewController.h"

@interface MISTouristInformationViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation MISTouristInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    _titleArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
    self.navigationController.navigationBar.hidden = NO;
    UINib *nib = [UINib nibWithNibName:@"SearchResultCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.title = @"名所案内";
    
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithTitle:@"戻る"
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:nil];
    self.navigationItem.backBarButtonItem = btn;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _itemArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MISSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MISSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.resultImageView.image = [UIImage imageNamed:_itemArray[indexPath.section]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MISTouristInformationDetailViewController *searchDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"touristInformationDetail"];
    
    searchDetailViewController.titleName = _titleArray[indexPath.section];
    searchDetailViewController.image = [UIImage imageNamed:_itemArray[indexPath.section]];
    [self.navigationController pushViewController:searchDetailViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    [view setTintColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    [view setTintColor:[UIColor clearColor]];
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
