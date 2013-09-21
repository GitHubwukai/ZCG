//
//  ZCGAppDelegate.m
//  ZCGService
//
//  Created by wukai on 13-9-4.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "ZCGAppDelegate.h"
#import "DDMenuController.h"
#import "LeftController.h"
#import "MainViewController.h"
@implementation ZCGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.mapManager = [[BMKMapManager alloc] init];
	
	BOOL ret = [self.mapManager start:@"B3a632f1834d237a53b3b3855847432a" generalDelegate:nil];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
	//主页面视图控制器
	MainViewController *mainController = [[MainViewController alloc] init ];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainController];
	[navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
	//根控制器
	DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navController];
	self.menuController = rootController;
	//左侧视图控制器
	LeftController *leftController = [[LeftController alloc] init];
	rootController.leftViewController = leftController;
	
	self.window.rootViewController = rootController;
	
    self.window.backgroundColor = [UIColor whiteColor];
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
