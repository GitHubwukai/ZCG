//
//  IntroViewController.m
//  ZCGService
//
//  Created by wukai on 13-9-6.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "IntroViewController.h"


static NSString * const introWord = @"在丹江水库西岸、香严寺东北方1公里的秀山密林里，有一处神秘的山水峡谷——坐禅谷，因唐朝慧忠国师常带领弟子在此静坐参禅而得名。她东依象鼻山，西靠青龙山，谷长40余里，两山夹峙，山势险峻，五步一景，十步一潭，为中原地区不可多得的山水峡谷景观，是国家AAA级旅游景区。\n"" 谷中移步换景，美不胜收，惹人醉不思归。有著名景点40余处，河南省最大的涌泉——龙王泉，罕见的大型水锈石群——千佛崖、面壁崖，中原第一古山寨——楚国古寨，豫西南最大的原始森林——木家沟原始森林，以垂钓、游娱为主的大型休闲区——聚龙湖，还有白布朝阳、古栈道、佛光瀑、水帘洞、通天洞等。是一处以自然山水景观为主，融佛文化、山水文化、古山寨文化为一炉，集休闲、探险、科普考察为一体，是游人赏景、写诗、作画、聚会、宴客、进香、祈福、放生、参禅、悟首、探险、考古等的理想之地。千百年来，佛家、兵家、皇家在这里留下了许多惊心动魄的历史传说，神秘百态的山水风光吸引了无数文人墨客前来观光游览，并留下了无数光辉的篇章。目前，坐禅谷景区正在为创建国家5A级风景区而努力！";

@interface IntroViewController ()
@property (nonatomic, strong) UITextView *introText;
@end

@implementation IntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @"简介";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.introText = [[UITextView alloc] init];
	self.introText.frame = self.view.bounds;
	//自适应宽、高
	self.introText.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.introText.editable = NO;
	self.introText.textAlignment = NSTextAlignmentCenter;
	UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:15];
	//参数
	//段落间距
	NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
	paragraph.alignment = NSTextAlignmentJustified;
	paragraph.firstLineHeadIndent = 20.0;
	paragraph.paragraphSpacingBefore = 16.0;
	NSDictionary *attributes = @{
		NSForegroundColorAttributeName : [UIColor darkTextColor],
		NSFontAttributeName:font,
  NSParagraphStyleAttributeName: paragraph
		
	};
	
	NSAttributedString *aString = [[NSAttributedString alloc]
								   initWithString:introWord
								   attributes:attributes];
	
	self.introText.attributedText = aString;
	self.introText.contentInset = UIEdgeInsetsZero;
	
	[self.view addSubview:self.introText];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
