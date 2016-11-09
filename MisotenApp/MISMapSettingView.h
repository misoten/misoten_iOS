//
//  MISMapSettingView.h
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/11/01.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MISMapSettingView : UIView

@property (nonatomic, assign, getter=isOpen) BOOL open;
@property(nonatomic, strong) UISegmentedControl *mapTypeSegment;


+(instancetype)initSettingView:(CGRect)frame;
- (void)show;
-(void)dismiss;

@end
