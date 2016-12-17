//
//  TestTableViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/17.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "TestTableViewController.h"
#import "ZYBannerView.h"
#import "HCSStarRatingView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "MISPlaceSearchResult.h"
#import "Photo.h"
#import "FrameAccessor.h"
#import ""
@import GoogleMaps;

@interface TestTableViewController () <ZYBannerViewDelegate, ZYBannerViewDataSource, GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet ZYBannerView *bannerView;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic, strong) NSMutableArray<UIImage*> *imageArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet HCSStarRatingView *ratingView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSMutableArray *slideShowImages;
@property (nonatomic, strong) NSMutableArray<NSURL *> *imageUrl;
@property (nonatomic, strong) UIBarButtonItem *favorite;
@property (nonatomic, strong) UIBarButtonItem *cancelFavorite;


@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",_place_id];
    NSLog(@"%@", url);
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
             _ratingLabel.text = [NSString stringWithFormat:@"レビュー(%lu件のレビュー)", (unsigned long)result.reviews.count];
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
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.opaque = NO;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 2;
    [titleView addSubview:_titleLabel];
    
//    _ratingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 25, 100, 13)];
//    _ratingView.backgroundColor = [UIColor clearColor];
//    _ratingView.allowsHalfStars = YES;
//    _ratingView.accurateHalfStars = YES;
    _ratingView.userInteractionEnabled = NO;
//    _ratingView.tintColor = [UIColor colorWithRed:1.00 green:0.70 blue:0.14 alpha:1.0];
    //[titleView addSubview:_ratingView];
    self.navigationItem.titleView = titleView;
    
    _favorite = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Hearts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(favorite:)];
    
    _cancelFavorite = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"HeartsFilled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(favorite:)];
    self.navigationItem.rightBarButtonItem = _favorite;
}

-(void)setupGoogleMap:(float)latitude longitude:(float)longitude setTitle:(NSString *)title setAddress:(NSString *)address {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:18];
    _mapView.camera = camera;
    _mapView.settings.scrollGestures = NO;
    _mapView.settings.indoorPicker = NO;
    _mapView.delegate = self;
//    [self.view addSubview:_mapView];
    
    
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
//    [self.view addSubview:_bannerView];
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
    
}

-(void) cancelFavorite:(UINavigationItem *)sender {
    self.navigationItem.rightBarButtonItem = _favorite;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
