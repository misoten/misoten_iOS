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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.alertImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height/2, [[UIScreen mainScreen] bounds].size.width/2, 300)];
    appDelegate.alertImageView.image = [UIImage imageNamed:@"kaede"];
    appDelegate.alertImageView.contentMode = UIViewContentModeScaleToFill;
    appDelegate.alertImageView.alpha = 1;
    [self addSubview:appDelegate.alertImageView];
    
    appDelegate.fukidashiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(appDelegate.alertImageView.width, self.height/2-150, appDelegate.alertImageView.width-30, 300)];
    appDelegate.fukidashiImageView.image = [UIImage imageNamed:@"fukidashi-1"];
    appDelegate.fukidashiImageView.contentMode = UIViewContentModeScaleToFill;
    appDelegate.fukidashiImageView.alpha = 1;
    [self addSubview:appDelegate.fukidashiImageView];
    
    _notificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(appDelegate.fukidashiImageView.width/2-50, 30, 100, 200)];
    _notificationLabel.numberOfLines = 5;
    [appDelegate.fukidashiImageView addSubview:_notificationLabel];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGesture];
}

-(void)tapped:(UITapGestureRecognizer *)sender{
    if(self.alpha == 1) {
        self.alpha = 0;
    }
}

@end
