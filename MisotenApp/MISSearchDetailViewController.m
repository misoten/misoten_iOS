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

@interface MISSearchDetailViewController () <UIScrollViewDelegate>

//@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSMutableArray *slideShowImages;
@property (nonatomic, strong) NSMutableArray<NSURL *> *imageUrl;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MISSearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bottom, self.view.width, 250)];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.frame = _scrollView.frame;
    [_scrollView addSubview:_imageView];
    
    

    [SVProgressHUD show];
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",_place_id];
    //NSLog(@"%@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             // json取得に成功した場合の処理
             NSDictionary *response = responseObject[@"result"];
             MISPlaceSearchResult *result = [[MISPlaceSearchResult alloc] initWithDictionary:response];
             NSArray *photos = result.photos;
             _slideShowImages = [NSMutableArray array];
             for(int i=0; i<photos.count; i++) {
                 Photo *photo = photos[i];
                 NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",photo.photoReference];
                 NSURL *imageUrl = [NSURL URLWithString:url];
                 [_slideShowImages addObject:imageUrl];
             }
             
             [_imageView sd_setImageWithURL:_slideShowImages[([_slideShowImages count]-1)] placeholderImage:[UIImage imageNamed:@"noimage"]];
             
             //ループさせる画像
             for (int i=0; i<_slideShowImages.count; i++) {
                 UIImageView *imageView = [[UIImageView alloc] init];
                 [imageView sd_setImageWithURL:_slideShowImages[i] placeholderImage:[UIImage imageNamed:@"noimage"]];
                 imageView.frame = CGRectMake((self.view.frame.size.width * i) + self.view.frame.size.width,0, self.view.frame.size.width, _scrollView.height);
                 [_scrollView addSubview:imageView];
             }
             
             //最初の画像を最後のページに置く
             _imageView = [[UIImageView alloc] init];
             [_imageView sd_setImageWithURL:_slideShowImages[0] placeholderImage:[UIImage imageNamed:@"noimage"]];
             _imageView.frame = CGRectMake((self.view.frame.size.width * ([_slideShowImages count] + 1)),0, self.view.frame.size.width, _scrollView.height);
             [_scrollView addSubview:_imageView];
             
             //ScrollViewの領域をループさせる画像＋２の幅にする
             [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width * ([_slideShowImages count] + 2), _scrollView.height)];
             
             //初期位置を2ページ目にする
             [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
             [self.view addSubview:_scrollView];
             self.title = result.name;


            [SVProgressHUD dismiss];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             // エラーの場合の処理
             if(error) {
                 [SVProgressHUD showWithStatus:@"エラーが発生しました"];
             }
         }
     ];
}

//スクロールが終わったとき
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //ページ数の取得
    int currentPage = scrollView.contentOffset.x /self.view.frame.size.width;
    
    //最初のページに行った時ループさせる最後の画像のページに移動
    if (currentPage == 0) {
        [scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width * [_slideShowImages count],0,self.view.frame.size.width,_scrollView.height) animated:NO];
    }
    //最後のページに行った時ループさせる最初の画像のページに移動
    else if (currentPage==([_slideShowImages count]+1)) {
        [scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width,0,self.view.frame.size.width,_scrollView.height) animated:NO];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
