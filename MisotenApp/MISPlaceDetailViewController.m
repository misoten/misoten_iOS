//
//  TestTableViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/17.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISPlaceDetailViewController.h"
#import "ZYBannerView.h"
#import "HCSStarRatingView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "MISPlaceSearchResult.h"
#import "Photo.h"
#import "FrameAccessor.h"
#import "FCAlertView.h"
#import "AppDelegate.h"
#import "MISRateDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MISMapViewController.h"
#import "OpeningHour.h"
@import GoogleMaps;

typedef NS_ENUM(NSInteger, weekDay) {
    Sunday = 1,
    Monday = 2,
    Tuesday = 3,
    Wednesday = 4,
    Thursday = 5,
    Friday = 6,
    Saturday = 7
};

@interface MISPlaceDetailViewController () <ZYBannerViewDelegate, ZYBannerViewDataSource, GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet ZYBannerView *bannerView;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic, strong) NSMutableArray<UIImage*> *imageArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet HCSStarRatingView *ratingView;
@property (nonatomic, weak) IBOutlet UIImageView *open;
@property (nonatomic, weak) IBOutlet UILabel *openDay;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSMutableArray *slideShowImages;
@property (nonatomic, strong) NSMutableArray<NSURL *> *imageUrl;
@property (nonatomic, strong) UIBarButtonItem *favorite;
@property (nonatomic, strong) UIBarButtonItem *cancelFavorite;
@property (nonatomic, strong) MISPlaceSearchResult *result;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSUserDefaults *userDefaultsKey;
@property (nonatomic, strong) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UIView *rateView;

//@property (weak, nonatomic) IBOutlet UIButton *goButton;


@end

@implementation MISPlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _userDefaults = [NSUserDefaults standardUserDefaults];
    _userDefaultsKey = [NSUserDefaults standardUserDefaults];
    _delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self initLayout];
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",_place_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             // json取得に成功した場合の処理
             NSDictionary *response = responseObject[@"result"];
             _result = [[MISPlaceSearchResult alloc] initWithDictionary:response];
             NSArray *photos = _result.photos;
             _slideShowImages = [NSMutableArray array];
             _imageArray = [NSMutableArray<UIImage*> array];
             for(int i=0; i<photos.count; i++) {
                 Photo *photo = photos[i];
                 NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",photo.photoReference];
                 NSURL *imageUrl = [NSURL URLWithString:url];
                 [_slideShowImages addObject:imageUrl];
             }
             
             [self initilizeBannerView];
             
             [self setupGoogleMap:_result.geometry.location.lat longitude:_result.geometry.location.lng setTitle:_result.name setAddress:_result.vicinity];
             
             _titleLabel.text = _result.name;
             _ratingView.value = _result.rating;
             if(_result.openingHours.openNow) {
                 _open.image = [UIImage imageNamed:@"Open"];
             } else {
                 _open.image = [UIImage imageNamed:@"Close"];
             }
             
             NSDate *date = [NSDate date];
             NSCalendar *calendar = [NSCalendar currentCalendar];
             NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
             NSInteger weekday = [components weekday];
             if(_result.openingHours.openNow) {
             switch (weekday) {
                 case Sunday:
                     _openDay.text = _result.openingHours.weekdayText[7];
                     break;
                 case Monday:
                     _openDay.text = _result.openingHours.weekdayText[0];
                     break;
                 case Tuesday:
                     _openDay.text = _result.openingHours.weekdayText[1];
                     break;
                 case Wednesday:
                     _openDay.text = _result.openingHours.weekdayText[2];
                     break;
                 case Thursday:
                     _openDay.text = _result.openingHours.weekdayText[3];
                     break;
                 case Friday:
                     _openDay.text = _result.openingHours.weekdayText[4];
                     break;
                 case Saturday:
                     _openDay.text = _result.openingHours.weekdayText[5];
                 default:
                     break;
             }
             } else {_openDay.text = @"本日の営業は終了しています";}
             _ratingLabel.text = [NSString stringWithFormat:@"レビュー(%lu件のレビュー)", (unsigned long)_result.reviews.count];
             [SVProgressHUD dismiss];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             // エラーの場合の処理
             if(error) {
                 [SVProgressHUD showWithStatus:@"エラーが発生しました"];
                 [SVProgressHUD dismiss];
             }
         }
     ];

}

-(void) initLayout {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.opaque = NO;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 2;
    [titleView addSubview:_titleLabel];
    
//    _goButton.layer.cornerRadius = 10.0f;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [_rateView addGestureRecognizer:tapGesture];
    

    _ratingView.userInteractionEnabled = NO;
    self.navigationItem.titleView = titleView;
    
    //お気に入り登録用
    _favorite = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Hearts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(favorite:)];
    
    //お気に入り解除用
    _cancelFavorite = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"HeartsFilled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(cancelFavorite:)];
    
    
    
    NSData *data = [_userDefaults dataForKey:_place_id];
    MISPlaceSearchResult *result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if(result) {
        self.navigationItem.rightBarButtonItem = _cancelFavorite;
    } else {
        self.navigationItem.rightBarButtonItem = _favorite;
    }

}

-(void)setupGoogleMap:(float)latitude longitude:(float)longitude setTitle:(NSString *)title setAddress:(NSString *)address {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:18];
    _mapView.camera = camera;
    _mapView.settings.scrollGestures = NO;
    _mapView.settings.indoorPicker = NO;
    _mapView.delegate = self;
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = title;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.snippet = address;
    marker.map = _mapView;
    
}

-(void)initilizeBannerView {
    _bannerView.dataSource = self;
    _bannerView.delegate = self;
    _bannerView.scrollInterval = 3.0f;
    _bannerView.autoScroll = YES;
    _bannerView.shouldLoop = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 4;
}


- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return _slideShowImages.count;
}


- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    _imageView = [[UIImageView alloc] init];
    [_imageView sd_setImageWithURL:_slideShowImages[index] placeholderImage:[UIImage imageNamed:@"loading"]];
    return _imageView;
}

-(void) favorite:(UINavigationItem *)sender {
    self.navigationItem.rightBarButtonItem = _cancelFavorite;
    
    //UserDefultsに保存
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_result];
    [_userDefaults setObject:data forKey:_place_id];
    [_userDefaults synchronize];
    
    [_delegate.userDefaultsKeyArray addObject:_place_id];
    NSData *favoList = [NSKeyedArchiver archivedDataWithRootObject:_delegate.userDefaultsKeyArray];
    [_userDefaultsKey setObject:favoList forKey:@"favoriteKeys"];
    [_userDefaultsKey synchronize];
    
    FCAlertView *alertView = [[FCAlertView alloc] init];
    alertView.cornerRadius = 15;
    alertView.hideSeparatorLineView = YES;
    //alertView.bounceAnimations = YES;
    alertView.colorScheme = alertView.flatOrange;
    [alertView showAlertInView:self withTitle:@"お気に入り" withSubtitle:@"お気に入りに追加しました。" withCustomImage:[UIImage imageNamed:@"HeartsFilled"] withDoneButtonTitle:@"OK" andButtons:nil];
}

-(void)tapped:(UITapGestureRecognizer *)sender {
    MISRateDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"RateDetail"];
    detailView.reviews = _result.reviews;
    [self.navigationController pushViewController:detailView animated:YES];
}

-(void) cancelFavorite:(UINavigationItem *)sender {
    self.navigationItem.rightBarButtonItem = _favorite;
    [_userDefaults removeObjectForKey:_place_id];
    [_userDefaults synchronize];
}

- (IBAction)goTo:(id)sender {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.notificationView.notificationLabel.text = @"出発でござる！";
    
    //サーバーにplace_idを投げる
    //[delegate.web_socket send:[NSString stringWithFormat:@"%@", _place_id]];
    
    
    [UIView animateWithDuration:0.75f animations:^{
        delegate.notificationView.alpha = 1;
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } completion:^(BOOL finished) {
        
    }];
}

@end
