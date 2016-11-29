//
//  MISSearchResultCell.h
//  MisotenApp
//
//  Created by 奥寺辰也 on 2016/11/09.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView/HCSStarRatingView.h"

@interface MISSearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingView;

@end
