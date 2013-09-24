//
//  TableViewController.h
//  ZCGService
//
//  Created by wukai on 13-9-16.
//  Copyright (c) 2013年 wukai. All rights reserved.
//
/**
 *  交通 推荐路线
 */
#import <UIKit/UIKit.h>
#import "ZCGValueDelegate.h"

@interface TableViewController : UIViewController<ZCGValueDelegate>
{
	NSString *_value;
}

@property (nonatomic, strong) id<ZCGValueDelegate> detailDelegate;
- (void) setValue:(NSString *)value;

@end
