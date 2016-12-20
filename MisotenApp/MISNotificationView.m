//
//  MISNotificationView.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/14.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISNotificationView.h"
#import "AppDelegate.h"
#import "FrameAccessor.h"

@interface MISNotificationView()

@end

@implementation MISNotificationView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initializeSubViews];
    }
    return self;
}

-(void)initializeSubViews {
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
    
    _alertImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height/2, [[UIScreen mainScreen] bounds].size.width/2, 300)];
    _alertImageView.image = [UIImage imageNamed:@"kaede"];
    _alertImageView.contentMode = UIViewContentModeScaleToFill;
    _alertImageView.alpha = 1;
    [self addSubview:_alertImageView];
    
    _fukidashiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_alertImageView.width, self.height/2-150, _alertImageView.width-30, 300)];
    _fukidashiImageView.image = [UIImage imageNamed:@"fukidashi-1"];
    _fukidashiImageView.contentMode = UIViewContentModeScaleToFill;
    _fukidashiImageView.alpha = 1;
    [self addSubview:_fukidashiImageView];
    
    _notificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(_fukidashiImageView.width/2-70, 30, 140, 200)];
    _notificationLabel.textAlignment = NSTextAlignmentCenter;
    _notificationLabel.numberOfLines = 5;
    [_fukidashiImageView addSubview:_notificationLabel];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGesture];
}

-(void)tapped:(UITapGestureRecognizer *)sender{
    if(self.alpha == 1) {
        self.alpha = 0;
    }
}

@end
