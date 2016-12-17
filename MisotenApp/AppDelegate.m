//
//  AppDelegate.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/12.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "AppDelegate.h"
#import "SRWebSocket.h"
@import GoogleMaps;
@import GooglePlaces;
@import Firebase;


@interface AppDelegate () <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *web_socket;

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
    _web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.179.3:3000/"]]];
    [_web_socket setDelegate:self];
    [_web_socket open];
}

-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    #warning debug バイブのデバッグ
    if([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    _notificationView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [UIView animateWithDuration:0.75 animations:^{
//        _alertImageView.alpha = 1;
//        _fukidashiImageView.alpha = 1;
        _notificationView.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dissmiss) withObject:nil afterDelay:5.0];
    }];
}

-(void)dissmiss {
//    _alertImageView.alpha = 0;
//    _fukidashiImageView.alpha = 0;
    _notificationView.alpha = 0;
}

-(void)webSocketDidOpen:(SRWebSocket *)webSocket {
    [_web_socket send:@"1001"];
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
