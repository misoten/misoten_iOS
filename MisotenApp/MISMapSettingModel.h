//
//  mapSettingModel.h
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/17.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMaps;

@interface MISMapSettingModel : NSObject

@property (nonatomic, assign) BOOL hierarchy;
@property (nonatomic, assign) BOOL compass;
@property (nonatomic, assign) GMSMapViewType mapType;

//+(instancetype) setting;

@end
