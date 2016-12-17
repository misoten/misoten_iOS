//
//  AppDelegate.h
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/12.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MISNotificationView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UIImageView *alertImageView;
@property (nonatomic, strong) UIImageView *fukidashiImageView;
@property (nonatomic, strong) MISNotificationView *notificationView;


@end

