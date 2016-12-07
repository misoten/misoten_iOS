//
//  MISMapSearchViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/19.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISMapSearchViewController.h"
#import "MISMapSearchItemCollectionViewCell.h"
#import "MISMapSearchItem.h"
#import "MISMapViewController.h"

#import "MISSearchTableViewController.h"

typedef NS_ENUM(NSInteger, searchType) {
    MUSEUM,
    RESTAURANT,
    AMUSEMENT_PARK,
    BAR,
    CAFE,
    LODGING,
    CLOTHING_STORE,
    PARK,
    DEPARTMENT_STORE
};


@interface MISMapSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *searchMenuCollectionView;
@property (nonatomic, strong) MISMapSearchItemCollectionViewCell *cell;

@end

@implementation MISMapSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _searchMenuCollectionView.showsVerticalScrollIndicator = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *iconArray = [MISMapSearchItem searchItemIconArray];
    NSArray *stringArray = [MISMapSearchItem searchItemStringArray];
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    _cell.tag = indexPath.row;
    _cell.layer.cornerRadius = 10.0f;
    _cell.iconImageView.image = [UIImage imageNamed:iconArray[indexPath.row]];
    _cell.itemLabel.text = stringArray[indexPath.row];
    CGFloat r = (arc4random_uniform(255) + 1) / 255.0;
    CGFloat g = (arc4random_uniform(255) + 1) / 255.0;
    CGFloat b = (arc4random_uniform(255) + 1) / 255.0;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    _cell.backgroundColor = color;
    return _cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _cell = (MISMapSearchItemCollectionViewCell *)[_searchMenuCollectionView cellForItemAtIndexPath:indexPath];
    
    MISSearchTableViewController *searchTableViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"SearchView"];
    
    switch (indexPath.row) {
        case MUSEUM:
            searchTableViewController.searchType = @"museum";
            break;
        case RESTAURANT:
            searchTableViewController.searchType = @"restaurant";
            break;
            
        case AMUSEMENT_PARK:
            searchTableViewController.searchType = @"amusement_park";
            break;
            
        case BAR:
            searchTableViewController.searchType = @"bar";
            break;
            
        case CAFE:
            searchTableViewController.searchType = @"cafe";
            break;
        
        case LODGING:
            searchTableViewController.searchType = @"lodging";
            break;
            
        case CLOTHING_STORE:
            searchTableViewController.searchType = @"clothing_store";
            break;
            
        case PARK:
            searchTableViewController.searchType = @"park";
            break;
            
        case DEPARTMENT_STORE:
            searchTableViewController.searchType = @"department_store";
            break;
    }
    
    
    [self.navigationController pushViewController:searchTableViewController animated:YES];

}
- (IBAction)closeSearchMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
