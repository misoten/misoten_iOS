//
//  MISMapSettingView.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/11/01.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISMapSettingView.h"
#import "MISMapViewController.h"
#import "FrameAccessor.h"

typedef NS_ENUM(NSInteger, GMSMapType) {
    GMSTypeNormal = 0,
    GMSTypeHybrid = 1,
    GMSTypeSatellite = 2
};

@import GoogleMaps;

@interface MISMapSettingView()


@end

@implementation MISMapSettingView

+(instancetype)initSettingView:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10.0f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.alpha = 0.75;
        self.backgroundColor = [UIColor blackColor];
        [self initalizeSubviews];
    }
    return self;
}

-(void) initalizeSubviews {
    NSArray *arr = [NSArray arrayWithObjects:@"標準", @"ハイブリッド", @"航空写真", nil];
    _mapTypeSegment = [[UISegmentedControl alloc] initWithItems:arr];
    _mapTypeSegment.selectedSegmentIndex = 0;
    [_mapTypeSegment addTarget:self action:@selector(changeMap:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_mapTypeSegment];
}

-(void)layoutSubviews {
    _mapTypeSegment.frame = CGRectMake(20, 50, self.width-40, 30);
    
}

- (void)show {
    if (self.superview != nil) {
        return;
    }
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [UIView animateWithDuration:0.75 animations:^{
        [window addSubview:self];
    }];
    _open = YES;
}

-(void)dismiss {
    if (self.superview == nil) {
        return;
    }
    [UIView animateWithDuration:0.75 animations:^{
        [self removeFromSuperview];
    }];
    _open = NO;
}

-(void)changeMap:(UISegmentedControl*)seg{
    
    switch (seg.selectedSegmentIndex) {
        case GMSTypeNormal:
            break;
        case 1:
            break;
            
        case 2:
            
            break;
            
        case 3:
            
            break;
            
        default:
            break;
    }
}

@end
