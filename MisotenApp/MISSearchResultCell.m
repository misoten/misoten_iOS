//
//  MISSearchResultCell.m
//  MisotenApp
//
//  Created by 奥寺辰也 on 2016/11/09.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISSearchResultCell.h"

@implementation MISSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    self.layer.shadowPath = (__bridge CGPathRef)([UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:5.0f]);
    self.layer.shadowColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    self.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    self.layer.shadowOpacity = 0.5;
    
    self.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    self.ratingView.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
