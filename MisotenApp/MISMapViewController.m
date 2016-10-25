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
#import "MISMapSearchViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface MISMapViewController () <GMSMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) RESideMenu *sideMenuViewController;
@property (nonatomic, assign, getter=isFollow) BOOL follow;

@end

@implementation MISMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    self.navigationController.navigationBar.alpha = 0.7;
    self.navigationController.navigationBar.translucent  = YES;

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

- (IBAction)openSearchMenu:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MISMapSearchViewController *mapSearchViewController = [storyboard instantiateViewControllerWithIdentifier:@"mapSearchVC"];
    
    [UIView animateWithDuration:0.75 animations:^{
        [self presentViewController: mapSearchViewController animated:YES completion: nil];
    }];
    
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
