//
//  MISSearchDetailViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/11/27.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISSearchDetailViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "MISPlaceSearchResult.h"
#import "Photo.h"
#import "FrameAccessor.h"
#import "UIImageView+WebCache.h"
#import "ZYBannerView.h"
#import "HCSStarRatingView.h"
@import GoogleMaps;

@interface MISSearchDetailViewController () <UIScrollViewDelegate, ZYBannerViewDelegate, ZYBannerViewDataSource, GMSMapViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSMutableArray *slideShowImages;
@property (nonatomic, strong) NSMutableArray<NSURL *> *imageUrl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZYBannerView *bannerView;
@property (nonatomic, strong) NSMutableArray<UIImage*> *imageArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) HCSStarRatingView *ratingView;

@property (nonatomic, strong) GMSMapView *mapView;

@end

@implementation MISSearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initLayout];
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",_place_id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             // json取得に成功した場合の処理
             NSDictionary *response = responseObject[@"result"];
             MISPlaceSearchResult *result = [[MISPlaceSearchResult alloc] initWithDictionary:response];
             NSArray *photos = result.photos;
             _slideShowImages = [NSMutableArray array];
             _imageArray = [NSMutableArray<UIImage*> array];
             for(int i=0; i<photos.count; i++) {
                 Photo *photo = photos[i];
                 NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",photo.photoReference];
                 NSURL *imageUrl = [NSURL URLWithString:url];
                 [_slideShowImages addObject:imageUrl];
             }
             
             [self initilizeBannerView];
             
             [self setupGoogleMap:result.geometry.location.lat longitude:result.geometry.location.lng setTitle:result.name setAddress:result.vicinity];

             _titleLabel.text = result.name;
             _ratingView.value = result.rating;
             NSLog(@"%@", result.formattedAddress);
             NSLog(@"%@", result.vicinity);
             NSLog(@"%@", result.website);
            
            [SVProgressHUD dismiss];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             // エラーの場合の処理
             if(error) {
                 [SVProgressHUD showWithStatus:@"エラーが発生しました"];
             }
         }
     ];
}

-(void) initLayout {
    
    //UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:];
    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.opaque = NO;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 22)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:_titleLabel];
    
    _ratingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 25, 100, 13)];
    _ratingView.backgroundColor = [UIColor clearColor];
    _ratingView.allowsHalfStars = YES;
    _ratingView.accurateHalfStars = YES;
    _ratingView.userInteractionEnabled = NO;
    _ratingView.tintColor = [UIColor colorWithRed:1.00 green:0.70 blue:0.14 alpha:1.0];
    [titleView addSubview:_ratingView];
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"画像名"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(tap:)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)setupGoogleMap:(float)latitude longitude:(float)longitude setTitle:(NSString *)title setAddress:(NSString *)address {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:18];
    _mapView = [GMSMapView mapWithFrame:CGRectMake(0, _bannerView.bottom, self.view.width, self.view.height-_bannerView.height-self.tabBarController.tabBar.height) camera:camera];
    _mapView.settings.scrollGestures = NO;
    _mapView.settings.indoorPicker = NO;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = title;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.snippet = address;
    marker.map = _mapView;

}

-(void)initilizeBannerView {
    _bannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 220)];
    _bannerView.dataSource = self;
    _bannerView.delegate = self;
    _bannerView.scrollInterval = 3.0f;
    _bannerView.autoScroll = YES;
    _bannerView.shouldLoop = YES;
    [self.view addSubview:_bannerView];
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

-(void)tap:(UINavigationItem *)sender {
    NSLog(@"お気に入り保存");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
