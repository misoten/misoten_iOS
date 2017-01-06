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

#import "MISMapSettingView.h"
#import "AppDelegate.h"
#import "MISNotificationView.h"

#import "EAIntroView.h"
#import "EAIntroPage.h"

#import "MISForgetItemsTableView.h"

@import GooglePlaces;

@interface MISMapViewController () <GMSMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, EAIntroDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) RESideMenu *sideMenuViewController;
@property (nonatomic, assign, getter=isFollow) BOOL follow;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) GMSPlacesClient *placesClient;
@property (nonatomic, strong) NSMutableArray *searchResultArray;
@property (nonatomic, strong) UISearchController *placeSearchController;
@property (nonatomic, strong) MISMapSettingView *settingView;

@property (nonatomic, strong) CLLocation *myLocation;

@end

@implementation MISMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self showIntroWithCrossDissolve];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    self.navigationController.navigationBar.alpha = 0.7;
    self.navigationController.navigationBar.translucent  = YES;
    [self setupSearchBar];
    
    _searchResultArray = [NSMutableArray array];
    
    if(self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self setupGoogleMap];
        [self initializeKeywordSearchView];
    }
    
    _settingView = [MISMapSettingView initSettingView:CGRectMake(0, self.navigationController.navigationBar.bottom, self.view.width, self.view.height-self.tabBarController.tabBar.height-self.navigationController.navigationBar.bottom)];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//
//    appDelegate.alertImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 330, [[UIScreen mainScreen] bounds].size.width/2, 300)];
//    appDelegate.alertImageView.image = [UIImage imageNamed:@"kaede"];
//    appDelegate.alertImageView.contentMode = UIViewContentModeScaleToFill;
//    appDelegate.alertImageView.alpha = 0;
    
    appDelegate.notificationView = [[MISNotificationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//CGRectMake(0, 330, self.view.width, 330)];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview: appDelegate.notificationView];
}

-(void)setupSearchBar {
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.tintColor = [UIColor darkGrayColor];
    _searchBar.placeholder = @"検索";
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    self.navigationItem.titleView.frame = CGRectMake(0, 0, 320, 44);
}

//not use
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
    //コンパスとメニューボタンがかぶる
    //_mapView.settings.compassButton = YES;
    _mapView.settings.myLocationButton = YES;
    _mapView.delegate = self;

    NSURL *retroURL = [[NSBundle mainBundle] URLForResource:@"mapstyle-retro"
                                              withExtension:@"json"];
    GMSMapStyle *retroStyle = [GMSMapStyle styleWithContentsOfFileURL:retroURL error:NULL];
    _mapView.mapStyle = retroStyle;
    
    [self.view addSubview:_mapView];
    
    [_mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _mapView.myLocationEnabled = YES;
    });
}

- (void)updateTableSize:(UITableView *)tableView
{
    tableView.frame =
    CGRectMake(tableView.frame.origin.x,
               tableView.frame.origin.y,
               tableView.contentSize.width,
               MIN(tableView.contentSize.height,
                   tableView.bounds.size.height));
}

-(void)dealloc {
    [_mapView removeObserver:self forKeyPath:@"myLocation" context:NULL];
}

- (void)initializeKeywordSearchView {
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height+[[UIApplication sharedApplication] statusBarFrame].size.height, self.view.width, 0)];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    [self.view addSubview:_searchTableView];
    _searchTableView.alpha = 0;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tapGesture.delegate = self;
    [_searchTableView addGestureRecognizer:tapGesture];
    [self.view addSubview:_searchTableView];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqual:@"myLocation"] && !_follow){
        _follow = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        //[_mapView animateToLocation:location.coordinate];
        _mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:18];
        
        _myLocation = location;
        NSLog(@"latitude:%f, longitude:%f", _myLocation.coordinate.latitude, _myLocation.coordinate.longitude);
    }
}

- (IBAction)menuOpen:(id)sender {
//    [self.sideMenuViewController presentLeftMenuViewController];
//    NSLog(@"%lu", (unsigned long)_searchResultArray.count);
}

- (IBAction)openSearchMenu:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MISMapSearchViewController *mapSearchViewController = [storyboard instantiateViewControllerWithIdentifier:@"mapSearchVC"];
    [UIView animateWithDuration:0.75 animations:^{
        mapSearchViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController: mapSearchViewController animated:YES completion: nil];
    }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    _searchTableView.alpha = 1.0f;
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    _searchTableView.alpha = 0;
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    _placesClient = [[GMSPlacesClient alloc] init];
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    
    NSString *searchText;
    
    if(_searchBar.text.length != 0) {
        searchText = [_searchBar.text stringByAppendingString:text];
    } else {
        searchText = text;
    }
    
    [_placesClient autocompleteQuery:searchText
                              bounds:nil
                              filter:filter
                            callback:^(NSArray *results, NSError *error) {
                                if (error != nil) {
                                    NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                    return;
                                }
                                
                                [_searchResultArray removeAllObjects];
                                
                                for (GMSAutocompletePrediction *result in results) {
                                    [_searchResultArray addObject:result.attributedFullText.string];
                                    NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                                }
                                [_searchTableView reloadData];
                            }];
    return YES;
}

- (void)tapped:(UITapGestureRecognizer *)sender {
    _searchBar.text = @"";
    _searchTableView.alpha = 0;
    [_searchBar resignFirstResponder];
}

//- (void)mapView:(GMSMapView *)mapView
//didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
//    _searchBar.text = @"";
//    [_searchBar resignFirstResponder];
//}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger rowCount = _searchResultArray.count;
    _searchTableView.height = _searchTableView.contentSize.height;
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.height = 80;
    
    cell.textLabel.text = _searchResultArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)showSettingView:(id)sender {
    if(_settingView.open) {
        [_settingView dismiss];
    } else {
        [_settingView show];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"title2"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"This is page 4";
    page4.desc = @"Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit.";
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    intro.skipButton.backgroundColor = [UIColor grayColor];
    intro.swipeToExit = NO;
    [intro setDelegate:self];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [intro showInView:window animateDuration:0.3];
    
}

-(void) getRoute:(NSString *)place_id {
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=place_id:%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI", _myLocation.coordinate.latitude, _myLocation.coordinate.longitude, place_id];
    NSLog(@"%@", url);
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
