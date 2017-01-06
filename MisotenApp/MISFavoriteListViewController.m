//
//  MISFavoriteListViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/17.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISFavoriteListViewController.h"
#import "MISSearchResultCell.h"
#import "MISPlaceSearchResult.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "MISPlaceDetailViewController.h"

@interface MISFavoriteListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *favoriteKeyArray;
@property (nonatomic, strong) NSMutableArray *favoriteArray;
@property (nonatomic, strong) MISPlaceSearchResult *result;

@end

@implementation MISFavoriteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"SearchResultCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor clearColor];
    self.title = @"お気に入り";
    
    _favoriteArray = [NSMutableArray array];
    _favoriteKeyArray = [NSMutableArray array];
    
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSLog(@"%lu", (unsigned long)delegate.userDefaultsKeyArray.count);
//    for(int i=0; i<delegate.userDefaultsKeyArray.count; i++) {
//        NSData *data = [userDefaults objectForKey:delegate.userDefaultsKeyArray[i]];
//        MISPlaceSearchResult *result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        NSLog(@"%@", result.name);
//    }
    
    
    
    
//    _dictionary = [userDefaults dictionaryRepresentation];
//    NSLog(@"defualts:%@", _dictionary);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_favoriteArray removeAllObjects];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *favoList = [userDefaults objectForKey:@"favoriteKeys"];
    _favoriteKeyArray = [NSKeyedUnarchiver unarchiveObjectWithData:favoList];
    
    for (NSString *key in _favoriteKeyArray) {
        NSData *data = [userDefaults objectForKey:key];
        [_favoriteArray addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%lu", (unsigned long)_favoriteArray.count);
    return _favoriteArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MISSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MISSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    _result = _favoriteArray[indexPath.section];
    Photo *photo = _result.photos[0];
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",photo.photoReference];
    NSURL *imageUrl = [NSURL URLWithString:url];
    [cell.resultImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"noimage"]];
    cell.nameLabel.text = _result.name;
    //cell.addressLabel.text = _result.vicinity;
    cell.ratingView.value = _result.rating;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MISPlaceDetailViewController *searchDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"test"];
    _result = _favoriteArray[indexPath.section];
    searchDetailViewController.place_id = _result.placeId;
    
    [self.navigationController pushViewController:searchDetailViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    [view setTintColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    [view setTintColor:[UIColor clearColor]];
}
@end
