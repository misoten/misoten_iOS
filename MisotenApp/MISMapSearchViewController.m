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
#import "MISTouristInformationViewController.h"

typedef NS_ENUM(NSInteger, searchType) {
    MUSEUM,
    RESTAURANT,
    AMUSEMENT_PARK,
    BAR,
    CAFE,
    LODGING,
    CLOTHING_STORE,
    PARK,
    TouristInformation
};


@interface MISMapSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *searchMenuCollectionView;
@property (nonatomic, strong) MISMapSearchItemCollectionViewCell *cell;
@property (weak, nonatomic) IBOutlet UIView *blurView;

@end

@implementation MISMapSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _searchMenuCollectionView.showsVerticalScrollIndicator = NO;
    //ブラースタイルの決定
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //VisualEffectViewにVisualEffectを設定
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //VisualEffectViewを_blurViewと同じサイズに設定
    CGRect frame = self.blurView.frame;
    frame.size.width = self.view.frame.size.width;
    effectView.frame = frame;
    //self.blurViewにVisualEffectViewを追加
    self.blurView.layer.cornerRadius = 10.0;
    self.blurView.clipsToBounds = YES;
    [self.blurView addSubview:effectView];
}

-(void)viewWillAppear:(BOOL)animated {
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
    if([_cell.itemLabel.text isEqualToString: @"ミュージアム"]) {
        _cell.itemLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    
    if([_cell.itemLabel.text isEqualToString: @"アミューズ\nメントパーク"]) {
        _cell.itemLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    
    return _cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _cell = (MISMapSearchItemCollectionViewCell *)[_searchMenuCollectionView cellForItemAtIndexPath:indexPath];
    
    MISSearchTableViewController *searchTableViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"SearchView"];
    
    MISTouristInformationViewController *touristInformationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"touristInformation"];
    
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
            
        case TouristInformation:
            [self.navigationController pushViewController:touristInformationViewController
                                                 animated:YES];
            return;
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
