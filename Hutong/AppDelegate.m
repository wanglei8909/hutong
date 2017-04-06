//
//  AppDelegate.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    DATAManager;
    
    UINavigationController *nCtrl = [[UINavigationController alloc] initWithRootViewController:[[MapViewController alloc] init]];
    self.window.rootViewController = nCtrl;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    NSLog(@"%@, %@",session.availableModes,session.mode);
//    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
//    NSLog(@"Category Error: %@",[error localizedDescription]);
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"Category Error: %@",[error localizedDescription]);
    }
    if (![session setActive:YES error:&error]) {
        NSLog(@"Activation Error: %@",[error localizedDescription]);
    }
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    return YES;
}

//响应远程音乐播放控制消息
- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [AUDIOManager pause];
                NSLog(@"RemoteControlEvents: pause");
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                //[AUDIOManager playModeNext];
                NSLog(@"RemoteControlEvents: playModeNext");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                //[AUDIOManager playPrev];
                NSLog(@"RemoteControlEvents: playPrev");
                break;
            default:
                break;
        }
    }
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
