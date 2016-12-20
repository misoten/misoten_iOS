//
//  MISTouristInformationDetailViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/19.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISTouristInformationDetailViewController.h"
#import "ZYBannerView.h"
#import "HCSStarRatingView.h"
#import "MISRateDetailViewController.h"
#import "MISNotificationView.h"
#import "SRWebSocket.h"
#import "AppDelegate.h"


@interface MISTouristInformationDetailViewController () <ZYBannerViewDelegate, ZYBannerViewDataSource>

@property (weak, nonatomic) IBOutlet ZYBannerView *bannerView;
@property (nonatomic, strong) NSMutableArray<UIImage*> *imageArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet HCSStarRatingView *ratingView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSMutableArray *slideShowImages;
@property (nonatomic, strong) UIBarButtonItem *favorite;
@property (nonatomic, strong) UIBarButtonItem *cancelFavorite;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, weak) IBOutlet UIImageView *mapImageView;
@property (nonatomic, weak) IBOutlet UIView *rateView;
@property (weak, nonatomic) IBOutlet UIButton *goButton;

@end

@implementation MISTouristInformationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];
    [self initilizeBannerView];
    
}

-(void) initLayout {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.opaque = NO;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 2;
    _titleLabel.text = _titleName;

    [titleView addSubview:_titleLabel];
    _mapImageView.image = _mapImage;
    
    _goButton.clipsToBounds = YES;
    _goButton.layer.cornerRadius = 10.0;
    
    
    
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
    
    self.navigationItem.rightBarButtonItem = _favorite;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(void)initilizeBannerView {
    _bannerView.dataSource = self;
    _bannerView.delegate = self;
    _bannerView.scrollInterval = 3.0f;
    _bannerView.autoScroll = YES;
    _bannerView.shouldLoop = YES;
}

- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {
    return 1;
}

- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    _imageView = [[UIImageView alloc] init];
    _imageView.image = _image;
    return _imageView;
}

-(void)tapped:(UITapGestureRecognizer *)sender {
    MISRateDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"RateDetail"];
    //detailView.reviews = _result.reviews;
    [self.navigationController pushViewController:detailView animated:YES];
}

- (IBAction)goTo:(id)sender {
//    MISNotificationView *view = [[MISNotificationView alloc] initWithFrame:self.view.frame];
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window addSubview:view];
    
    
    NSLog(@"aaa");
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.web_socket send:_sendMessage];

    
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
