//
//  MainViewController.h
//  DDMenuController
//
//  Created by wukai on 13-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ZCGValueDelegate.h"
@interface MainViewController : UIViewController 
@property (nonatomic, strong) id<ZCGValueDelegate> valueDelegate;
@end
