//
//  ZCGAppDelegate.h
//  ZCGService
//
//  Created by wukai on 13-9-4.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@class DDMenuController;
@interface ZCGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) BMKMapManager* mapManager;
@end
