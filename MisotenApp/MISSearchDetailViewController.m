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

@interface MISSearchDetailViewController ()

@end

@implementation MISSearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD show];    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI",_place_id];
    NSLog(@"%@", url);
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager GET:url parameters:nil progress:nil
//         success:^(NSURLSessionTask *task, id responseObject) {
//             // json取得に成功した場合の処理
//             for (int i =0; i<results.count; i++) {
//                 NSDictionary *result = results[i];
//                 MISMap *map = [[MISMap alloc] initWithDictionary:result];
//                 [_mapObjects addObject:map];
//                 [_tableView reloadData];
//             }
//             [SVProgressHUD dismiss];
//         } failure:^(NSURLSessionTask *operation, NSError *error) {
//             // エラーの場合の処理
//             if(error) {
//                 [SVProgressHUD showWithStatus:@"エラーが発生しました"];
//             }
//         }
//     ];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
