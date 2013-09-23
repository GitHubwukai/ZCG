//
//  PageIntroViewController.h
//  ZCGService
//
//  Created by wukai on 13-9-21.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCGValueDelegate.h"

@interface PageIntroViewController : UIViewController<ZCGValueDelegate>
{
	NSString *_detailValue;
}

- (void)setValue:(NSString *)value;

@end
