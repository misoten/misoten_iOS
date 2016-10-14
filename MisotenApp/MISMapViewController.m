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
#import <CoreLocation/CoreLocation.h>
@import GoogleMaps;

@interface MISMapViewController () <GMSMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) RESideMenu *sideMenuViewController;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

@end

@implementation MISMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    }
    
    MISLeftMenuViewController *leftMenuViewController = [[MISLeftMenuViewController alloc] init];
    _sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:self.tabBarController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];
    _sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    _sideMenuViewController.bouncesHorizontally = NO;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = _sideMenuViewController;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:16];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    _mapView.delegate = self;
    self.view = _mapView;
    self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.height);
    
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
//    marker.title = @"Test";
//    marker.snippet = @"hoge";
//    marker.map = _mapView;
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
}


- (IBAction)menuOpen:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
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
