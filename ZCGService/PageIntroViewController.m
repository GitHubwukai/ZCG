//
//  PageIntroViewController.m
//  ZCGService
//
//  Created by wukai on 13-9-21.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "PageIntroViewController.h"
#import "IntroControll.h"

@interface PageIntroViewController ()
{
	NSArray *allThings_;
	NSArray *imageName_;
	NSArray *titleContent_;
}
@end

@implementation PageIntroViewController

- (id)init
{
    self = [super init];
    self.wantsFullScreenLayout = YES;
	self.modalPresentationStyle = UIModalPresentationFullScreen;
	
    return self;
}

- (void)setValue:(NSString *)value
{
	_detailValue = value;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"pageViewData" ofType:@"plist"];
	NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
	
	allThings_ = [[NSArray alloc] initWithArray:[dictionary objectForKey:_detailValue]];
	imageName_ = [[NSArray alloc] initWithArray: [allThings_ objectAtIndex:0]];
	titleContent_ = [[NSArray alloc] initWithArray:[allThings_ objectAtIndex:1]];
	
}
- (void) loadView
{
	[super loadView];
	IntroModel *model1 = [[IntroModel alloc] initWithTitle:[titleContent_ objectAtIndex:0] description:[titleContent_ objectAtIndex:0] image:[imageName_ objectAtIndex:0]];
    
    IntroModel *model2 = [[IntroModel alloc] initWithTitle:[titleContent_ objectAtIndex:1] description:[titleContent_ objectAtIndex:1] image:[imageName_ objectAtIndex:1]];
	IntroModel *model3 = [[IntroModel alloc] initWithTitle:[titleContent_ objectAtIndex:2] description:[titleContent_ objectAtIndex:2] image:[imageName_ objectAtIndex:2]];
    
    self.view = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:@[model1, model2, model3]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
