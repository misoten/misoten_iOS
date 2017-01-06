//
//  LUNBackgroundPatternedView.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/5/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNBackgroundPatternedView.h"

@implementation LUNBackgroundPatternedView

#pragma mark - initialization

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadViewFromXib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self loadViewFromXib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)loadViewFromXib {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
}

#pragma mark - private

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.subviews[0].backgroundColor = backgroundColor;
}

@end
