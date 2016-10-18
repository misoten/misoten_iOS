//
//  MISMapSearchView.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/15.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISMapSearchView.h"

@interface MISMapSearchView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *searchMenuView;

@end

@implementation MISMapSearchView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3.0f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor clearColor] CGColor];
        self.backgroundColor = [UIColor whiteColor];
        [self initializeSubViews];
    }
    return self;
}

-(void)initializeSubViews {
}


-(void)layoutSubviews {
    
}

@end
