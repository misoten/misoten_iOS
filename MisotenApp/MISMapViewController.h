//
//  MISMainViewController.h
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/12.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface MISMapViewController : UIViewController

@property (nonatomic, strong) GMSMapView *mapView;

-(void) getRoute:(NSString *)place_id;

+(MISMapViewController *)getInstance;

@end
