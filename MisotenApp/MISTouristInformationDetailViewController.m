//
//  MISTouristInformationDetailViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/07.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISTouristInformationDetailViewController.h"
#import "FrameAccessor.h"
#import "ZYBannerView.h"
#import "HCSStarRatingView.h"

@interface MISTouristInformationDetailViewController () <ZYBannerViewDelegate, ZYBannerViewDataSource>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ZYBannerView *bannerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) HCSStarRatingView *ratingView;

@end

@implementation MISTouristInformationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _titleName;
    
    [self initLayout];
    [self initilizeBannerView];
}


-(void) initLayout {

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.opaque = NO;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 22)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _titleName;
    [titleView addSubview:_titleLabel];
    
    _ratingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 25, 100, 13)];
    _ratingView.backgroundColor = [UIColor clearColor];
    _ratingView.allowsHalfStars = YES;
    _ratingView.accurateHalfStars = YES;
    _ratingView.userInteractionEnabled = NO;
    _ratingView.tintColor = [UIColor colorWithRed:1.00 green:0.70 blue:0.14 alpha:1.0];
    [titleView addSubview:_ratingView];
    self.navigationItem.titleView = titleView;
    
    UIImageView *mapImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, _bannerView.height, self.view.width, self.view.height-_bannerView.height-self.tabBarController.tabBar.height)];
    mapImage.image = [UIImage imageNamed:@"5"];
    [self.view addSubview:mapImage];
}

-(void)initilizeBannerView {
    _bannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 350)];
    _bannerView.dataSource = self;
    _bannerView.delegate = self;
    _bannerView.scrollInterval = 3.0f;
    _bannerView.autoScroll = YES;
    _bannerView.shouldLoop = YES;
    [self.view addSubview:_bannerView];
}

- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return 1;
}


- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    
    _imageView = [[UIImageView alloc] initWithFrame:_bannerView.frame];
    _imageView.image = _image;
    return _imageView;
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
