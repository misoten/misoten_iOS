//
//  MISMainViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/12.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISMapViewController.h"
#import "RESideMenu.h"
#import "MISLeftMenuViewController.h"
#import "FrameAccessor.h"
#import "MISMapSearchView.h"
#import "MISMapSearchItem.h"
#import "MISMapSearchItemCollectionViewCell.h"
#import "MISMapSettingModel.h"
#import <CoreLocation/CoreLocation.h>


@interface MISMapViewController () <GMSMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) RESideMenu *sideMenuViewController;
@property (nonatomic, assign, getter=isFollow) BOOL follow;
@property (nonatomic, strong) MISMapSearchView * searchView;
@property (weak, nonatomic) IBOutlet UICollectionView *searchMenuCollectionView;
@property (nonatomic, strong) MISMapSearchItemCollectionViewCell *cell;
@property (nonatomic, strong) MISMapSettingModel *settings;
@end

@implementation MISMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    self.navigationController.navigationBar.alpha = 0.7;
    self.navigationController.navigationBar.translucent  = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _searchMenuCollectionView.showsVerticalScrollIndicator = NO;
    _searchMenuCollectionView.alpha = 0;
    [self initializeSideMenu];
    
    if(self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self setupGoogleMap];
    }
}

-(void)initializeSideMenu {
    MISLeftMenuViewController *leftMenuViewController = [[MISLeftMenuViewController alloc] init];
    _sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:self.tabBarController
                                                         leftMenuViewController:leftMenuViewController
                                                        rightMenuViewController:nil];
    _sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    _sideMenuViewController.bouncesHorizontally = NO;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = _sideMenuViewController;
}

-(void)setupGoogleMap {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                            longitude:0
                                                                 zoom:18];
    _mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-self.tabBarController.tabBar.height) camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.compassButton = YES;
    _mapView.settings.myLocationButton = YES;
    _mapView.delegate = self;
    _follow = YES;
    [self.view addSubview:_mapView];
    
    [_mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _mapView.myLocationEnabled = YES;
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqual:@"myLocation"] && _follow == YES){
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        [_mapView animateToLocation:location.coordinate];
    }
    _follow = NO;
}

- (IBAction)menuOpen:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (IBAction)showSearchView:(id)sender {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    [UIView animateWithDuration:0.25f animations:^{
        _searchMenuCollectionView.alpha = 1.0;
        _mapView.alpha = 0;
        
    }];
}
- (IBAction)closeSearchView:(id)sender {
    [UIView animateWithDuration:0.25f animations:^{
        _searchMenuCollectionView.alpha = 0;
        _mapView.alpha = 1.0;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = NO;
    }];
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
    return _cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _cell = (MISMapSearchItemCollectionViewCell *)[_searchMenuCollectionView cellForItemAtIndexPath:indexPath];
    CGFloat r = (arc4random_uniform(255) + 1) / 255.0;
    CGFloat g = (arc4random_uniform(255) + 1) / 255.0;
    CGFloat b = (arc4random_uniform(255) + 1) / 255.0;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    _cell.backgroundColor = color;
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
