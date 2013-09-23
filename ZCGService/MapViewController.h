//
//  turingViewController.h
//  MapDemo
//
//  Created by wukai on 13-9-21.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ZCGValueDelegate.h"
@interface MapViewController : UIViewController <ZCGValueDelegate>
{
	NSString *title;
	NSString *_value;
}

- (void)setValue:(NSString *)value;
@end
