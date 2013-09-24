
//  MainViewController.m
//  DDMenuController
//
//  Created by wukai on 13-9-4.
//
//

#import "MainViewController.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "IntroViewController.h"
#import "ListViewController.h"
#import "TableViewController.h"
#import "ZCGMapViewController.h"

@interface MainViewController () 
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *buttomLabel;

@end


@implementation MainViewController
{
	NSArray *menuInfo;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @" 坐禅谷旅游";
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
		NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
		menuInfo = [[NSArray alloc] initWithArray:[dict objectForKey:@"menu"]];
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[self createMenuButtons];


}

- (void)createMenuButtons
{
	self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.scrollView.backgroundColor = [UIColor whiteColor];
	
//	NSString *menuContent = [[NSString alloc] init];
	int menuid = 0;
	NSInteger tagg = 1;
	//creat button
	for (int n = 0; n < 5; n++) {
		for (int row = 0; row < 2; row++) {
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			button.backgroundColor = [UIColor colorWithPatternImage:[UIImage
																	 imageNamed:@"iconbg.png"]];
			button.frame = CGRectMake((30+row*140), (20+128*n), 122, 108);
			NSString *menuContent = [menuInfo objectAtIndex:menuid];
			
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
			//label大小自适应
			UIFont *font = [UIFont systemFontOfSize:15];
			label.lineBreakMode = NSLineBreakByWordWrapping;
			label.text = menuContent;
			label.textColor = [UIColor whiteColor];
			label.backgroundColor = [UIColor clearColor];
			label.font = font;
			label.textAlignment = NSTextAlignmentCenter;
			CGSize minisize = CGSizeMake(MAXFLOAT, MAXFLOAT);
			
			CGSize labeTextSize = [menuContent sizeWithFont:font
										  constrainedToSize:minisize
											  lineBreakMode:label.lineBreakMode];
			CGRect labelRect = CGRectMake((122 - labeTextSize.width)/2,
										  65,
										  labeTextSize.width,
										  labeTextSize.height);
			label.frame = labelRect;
			
			
			[button addSubview:label];
			[self.scrollView addSubview:button];
			button.tag = tagg;
			tagg++;
			[button addTarget:self
					   action:@selector(tapButton:)
			 forControlEvents:UIControlEventTouchUpInside];
			
			menuid++;
		}
	}
	self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 700);
	
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:self.scrollView];

}



- (void)tapButton:(id)sender
{
	UIButton *button = sender;
	if (button.tag == 1) {
		IntroViewController *introController = [[IntroViewController alloc] init];
		[self.navigationController
		 pushViewController:introController animated:YES];
	}
	if (button.tag == 2) {

		ListViewController *listController = [[ListViewController alloc] init];
		self.valueDelegate = listController;
		[self.valueDelegate setValue:@"keyInfo"];
	//	listController.key = [NSString stringWithFormat:@"listInfo"];
		[self.navigationController pushViewController:listController animated:YES];
	}
	if (button.tag == 3) {

		ListViewController *listController = [[ListViewController alloc] init];
		self.valueDelegate = listController;
		[self.valueDelegate setValue:@"keyFood"];
		[self.navigationController pushViewController:listController animated:YES];
	}
	if (button.tag == 4) {
		
		ZCGMapViewController *mapViewController = [[ZCGMapViewController alloc]init];
		
		[self.navigationController pushViewController:mapViewController animated:YES];
	}
	if (button.tag == 5) {

		ListViewController *listController = [[ListViewController alloc] init];
		self.valueDelegate = listController;
		[self.valueDelegate setValue:@"keyHotel"];
		[self.navigationController pushViewController:listController animated:YES];
	}
	if (button.tag == 6) {
		TableViewController *tableController = [[TableViewController alloc] init];
		self.valueDelegate = tableController;
		[self.valueDelegate setValue:@"traffic"];
		[self.navigationController pushViewController:tableController animated:YES];
	}
	if (button.tag == 7) {
		TableViewController *tableController = [[TableViewController alloc] init];
		self.valueDelegate = tableController;
		[self.valueDelegate setValue:@"recommendation"];
		[self.navigationController pushViewController:tableController animated:YES];
	}
	if (button.tag == 8) {

		ListViewController *listController = [[ListViewController alloc] init];
		self.valueDelegate = listController;
		[self.valueDelegate setValue:@"keyInfo"];
		[self.navigationController pushViewController:listController animated:YES];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
