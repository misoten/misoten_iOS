//
//  MISReviewCell.h
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2017/01/06.
//  Copyright © 2017年 Masataka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView/HCSStarRatingView.h"

@interface MISReviewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *review_text;
@property (nonatomic, weak) IBOutlet UILabel *review_auther;
@property (nonatomic, weak) IBOutlet HCSStarRatingView *review_rating;

@end
