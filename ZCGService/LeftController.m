//
//  LeftController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LeftController.h"
#import "FeedController.h"
#import "DDMenuController.h"
#import "MainViewController.h"
#import "MapViewController.h"

@implementation LeftController
{
	NSArray *sectionArray;
	NSArray *section1Info;
	id controller;
}
@synthesize tableView=_tableView;

- (id)init {
    if ((self = [super init])) {
		sectionArray = [[NSArray alloc] initWithObjects:@"   坐禅谷欢迎你",@"   淅川天气",@"  给点反馈",nil];
		section1Info = [[NSArray alloc] initWithObjects:@" ",@"坐禅谷旅游", @"地图模式", nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
		return [section1Info count];
	}
	else if(section == 1)
		return 5;
	else
		return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
	return [sectionArray count];;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    /* 
     * Content in this cell should be inset the size of kMenuOverlayWidth
     */
	cell.contentView.backgroundColor = [UIColor redColor];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
	cell.frame = CGRectMake(0, cell.frame.origin.y, 320, cell.frame.size.height);
    if (indexPath.section == 0) {
		cell.textLabel.text = [section1Info objectAtIndex:indexPath.row];
		cell.textLabel.textColor = [UIColor blueColor];
		cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
	else if (indexPath.section == 2)
		{
			cell.textLabel.text = @"给我评价哦";
		
		}
	else
		cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
    
}

//- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
//	
//    NSString *string = [[NSString alloc]init];
//	string = [sectionArray objectAtIndex:section];
//	return string;
//}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return nil;
	}
	else
	{
		UILabel *sectionLabel = [[UILabel alloc] init];
		NSString *string = [[NSString alloc] init];
		string = [sectionArray objectAtIndex:section];
		
		sectionLabel = [self costumLabel:string andFont:@"Helvetica-Bold" andSizeL:15];
		
		CGRect frame = sectionLabel.frame;
		sectionLabel.frame = CGRectMake(12, 8, frame.size.width, frame.size.height);
		return sectionLabel;
	}
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return 0;
	}
	return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	if (section == 2) {
		return 1;
	}
	else
	{
		return 0;
	}
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	if (section == 2) {
		UIView *view = [UIView new];
		view.backgroundColor = [UIColor clearColor];
		return view;
	}
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // set the root controller
    DDMenuController *menuController = (DDMenuController*)((ZCGAppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;

	
	if ((indexPath.section == 0) && (indexPath.row == 1)) {
		controller = [[MainViewController alloc] init];
	}
	else if((indexPath.section ==0) && (indexPath.row == 2))
	{
	controller = [[MapViewController alloc] init];
	}
	
	
    //controller.title = [NSString stringWithString:[section1Info objectAtIndex:indexPath.row]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];

    [menuController setRootController:navController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - custom label
- (UILabel *)costumLabel:(NSString *)labelText
				 andFont:(NSString *)textFont andSizeL:(CGFloat)textSize
{
	UILabel *label = [[UILabel alloc] init];
	UIFont *font2 = [UIFont systemFontOfSize:textSize];
	//UIFont *font = [UIFont fontWithName:textFont size:textSize];
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	label.text = labelText;
	label.backgroundColor = [UIColor clearColor];
	label.font = font2;
	
	CGSize minisize = CGSizeMake(300.0f, MAXFLOAT);
	//返回字体区域大小
	CGSize labelTextSize = [labelText sizeWithFont:font2
											  constrainedToSize:minisize
												  lineBreakMode:label.lineBreakMode];
	CGRect labelRect = CGRectMake(10, 8, 300.0f, labelTextSize.height);
	label.frame = labelRect;
	
	return label;
}


@end
