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
    self.layer.cornerRadius = 10.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor darkGrayColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
