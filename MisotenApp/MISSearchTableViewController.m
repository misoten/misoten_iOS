//
//  MISSearchTableViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/11/16.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISSearchTableViewController.h"
#import "MISSearchResultCell.h"
#import "AFNetworking.h"
#import "MISPlaceSearchResult.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "Photo.h"
#import "UIImageView+WebCache.h"
#import "MISSearchDetailViewController.h"

@interface MISSearchTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *imageCache;
@property (nonatomic, strong) NSMutableDictionary *downloaderManager;
@property (nonatomic, strong) NSData *data;

@property (nonatomic, strong) NSMutableArray<MISPlaceSearchResult *> *mapObjects;

@end

@implementation MISSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"SearchResultCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [SVProgressHUD show];
    
    
    _mapObjects = [NSMutableArray array];
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=35.691864,139.696931&radius=500&types=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",_searchType];
    NSLog(@"%@", url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
             // json取得に成功した場合の処理
             NSArray *results = responseObject[@"results"];
             for (int i =0; i<results.count; i++) {
                 NSDictionary *result = results[i];
                 MISPlaceSearchResult *searchResult = [[MISPlaceSearchResult alloc] initWithDictionary:result];
                 [_mapObjects addObject:searchResult];
                 [_tableView reloadData];
             }
             [SVProgressHUD dismiss];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             // エラーの場合の処理
             if(error) {
                 [SVProgressHUD showWithStatus:@"エラーが発生しました"];
             }
         }
     ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mapObjects.count;
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
    
    Photo *photo = _mapObjects[indexPath.section].photos[0];
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",photo.photoReference];
    NSURL *imageUrl = [NSURL URLWithString:url];
    [cell.resultImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"noimage"]];
    cell.nameLabel.text = _mapObjects[indexPath.section].name;
    cell.addressLabel.text = _mapObjects[indexPath.section].vicinity;
    cell.ratingView.value = _mapObjects[indexPath.section].rating;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MISSearchDetailViewController *searchDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    searchDetailViewController.place_id = _mapObjects[indexPath.section].placeId;
    
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


@end
