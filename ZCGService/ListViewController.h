//
//  ListViewController.h
//  ZCGService
//
//  Created by wukai on 13-9-8.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCGValueDelegate.h"
@interface ListViewController : UIViewController <ZCGValueDelegate>
{
	NSString *_value;
}

@property (nonatomic, strong) id<ZCGValueDelegate> detailDelegate;
- (void) setValue:(NSString *)value;

@end
