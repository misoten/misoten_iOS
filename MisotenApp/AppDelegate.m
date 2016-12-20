//
//  AppDelegate.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/12.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "AppDelegate.h"
@import GoogleMaps;
@import GooglePlaces;
@import Firebase;


@interface AppDelegate () <SRWebSocketDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    [GMSServices provideAPIKey:@"AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyBif3Pp8ik8v9KwOLSvUuOgAuz-J4kzXBI"];
    [self initWebSocket];
    [self setupNavigationBarStyle];
    [self setupTabbarStyle];
    return YES;
}

-(void)setupNavigationBarStyle {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [UIImage new];
    navigationBar.tintColor = [UIColor darkGrayColor];
    navigationBar.translucent = NO;
    //navigationBar.barTintColor = [UIColor orangeColor];
    //navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor textBlackColor]};
}

-(void)setupTabbarStyle {
    //UITabBar *tabbar = [UITabBar appearance];
    //tabbar.barTintColor = [UIColor orangeColor];
}

-(void)initWebSocket {
    _web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.179.5:3000/"]]];
    [_web_socket setDelegate:self];
    [_web_socket open];
}

-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
    NSLog(@"%@", message);
    NSLog(@"aaaaa");
    
    if(message) {
        
        if([message isEqualToString:@"1001"] || [message isEqualToString:@"1002"] || [message isEqualToString:@"1003"] || [message isEqualToString:@"1004"]) {
            
        } else {
            _notificationView.notificationLabel.text = message;
            if([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
            [UIView animateWithDuration:0.75 animations:^{
                _notificationView.alpha = 1;
            } completion:^(BOOL finished) {
                [self performSelector:@selector(dissmiss) withObject:nil afterDelay:5.0];
            }];
        }
    }
    
    
}

-(void)dissmiss {
//    _alertImageView.alpha = 0;
//    _fukidashiImageView.alpha = 0;
    _notificationView.alpha = 0;
}

-(void)webSocketDidOpen:(SRWebSocket *)webSocket {
    //[_web_socket send:@"1001"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
