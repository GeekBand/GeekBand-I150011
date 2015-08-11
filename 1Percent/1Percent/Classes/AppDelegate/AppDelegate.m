//
//  AppDelegate.m
//  1Percent
//
//  Created by 黄纪银163 on 15/8/10.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//

#import "AppDelegate.h"
#import "ZOPMainViewController.h"
#import "ZOPHomeNavigationController.h"
#import "ZOPSettingViewController.h"
#import "ZOPIntroduceViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark - Private Methods
- (void) loadMainViewController
{
    // Home
    UIStoryboard *homeSb = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    ZOPHomeNavigationController *homeNavC = homeSb.instantiateInitialViewController;
    
    // left
    UIStoryboard *settingSb = [UIStoryboard storyboardWithName:@"Setting" bundle:[NSBundle mainBundle]];
    ZOPSettingViewController *settingVC = settingSb.instantiateInitialViewController;
    
    // right
    UIStoryboard *introduceSb = [UIStoryboard storyboardWithName:@"Introduce" bundle:[NSBundle mainBundle]];
    ZOPIntroduceViewController *introduceVC = introduceSb.instantiateInitialViewController;
    
    // menu
    ZOPMainViewController *mainViewController =
    [ZOPMainViewController sideMenuControllerWithHomeVC:homeNavC
                                                 leftVC:settingVC
                                                rightVC:introduceVC
                                            animateType:ZOPSideMenuAnimateTypeZoom];
    
    // 根控制器
    self.window.rootViewController = mainViewController;
    
}

#pragma mark - Application Status Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self loadMainViewController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
