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
#import "JSON.h"

@interface LeftController ()<NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
	NSString *outString;
	NSString *city;
	NSString *date;
	NSMutableArray *tpArray;
	NSMutableArray *weatherArray;
	NSString *temp;
	NSString *weather;
	NSMutableArray *weekArray;
}
@end
@implementation LeftController
{
	NSArray *sectionArray;
	NSArray *section1Info;
	NSArray *sectionTools;
	id controller;
}
@synthesize tableView=_tableView;

- (id)init {
    if ((self = [super init])) {
		sectionArray = [[NSArray alloc] initWithObjects:@"   坐禅谷欢迎你",@"   淅川天气预报",@"  工具",nil];
		section1Info = [[NSArray alloc] initWithObjects:@"坐禅谷旅游", @"地图模式", nil];
		sectionTools= [[NSArray alloc] initWithObjects:@"关于",@"给此应用程序打分",nil];
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
	
	//网络连接
	NSString *pathURL = @"http://m.weather.com.cn/data/101180708.html";
	NSURL *url = [NSURL URLWithString:pathURL];
	
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	
	NSURLConnection *connection = [[NSURLConnection alloc]
								   initWithRequest:request delegate:self];

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
		return 6;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
		cell.textLabel.text = [section1Info objectAtIndex:indexPath.row];
		cell.textLabel.textColor = [UIColor blueColor];
		cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
	else if (indexPath.section == 2)
		{
			cell.textLabel.text = [sectionTools objectAtIndex:indexPath.row];
			UIFont *font = [UIFont fontWithName:@"Arial" size:15];
			cell.textLabel.font = font;
		
		}
	else
		{
		UIFont *font = [UIFont fontWithName:@"Arial" size:15];
		UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
		dataLabel.font = font;
		UILabel *weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 80, 30)];
		weatherLabel.font =font;
		UILabel *tpLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 60, 30)];
		tpLabel.font = font;
		
		NSInteger num = [self GetRecord];
		
		dataLabel.text = [weekArray objectAtIndex:(indexPath.row+num)%7];
		weatherLabel.text = [weatherArray objectAtIndex:indexPath.row];
		tpLabel.text = [tpArray objectAtIndex:indexPath.row];
		
		[cell.contentView addSubview:dataLabel];
		[cell.contentView addSubview:weatherLabel];
		[cell.contentView addSubview:tpLabel];
		}

    return cell;
    
}



#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return nil;
	}
	else
	{
		NSString *string = [NSString stringWithString:[sectionArray objectAtIndex:section]];
		UILabel * sectionLabel = [self costumLabel:string
										   andFont:@"Helvetica-Bold"
										  andSizeL:13];
		
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
    
    if (indexPath.section == 0 || indexPath.section == 2) {

		DDMenuController *menuController = (DDMenuController*)((ZCGAppDelegate*)
															   [[UIApplication sharedApplication] delegate]).menuController;

		
		if ((indexPath.section == 0) && (indexPath.row == 0)) {
			controller = [[MainViewController alloc] init];
		}
		else if((indexPath.section ==0) && (indexPath.row == 1))
		{
		controller = [[MapViewController alloc] init];
		}
		
		
		//controller.title = [NSString stringWithString:[section1Info objectAtIndex:indexPath.row]];
		UINavigationController *navController = [[UINavigationController alloc]
												 initWithRootViewController:controller];
		[navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
		[menuController setRootController:navController animated:YES];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}else{
	
	}
    
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

//json解析

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	outString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"failed");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSMutableDictionary *jsonDic = [outString JSONValue];
	NSMutableDictionary *jsonSubDic = [jsonDic objectForKey:@"weatherinfo"];
	
	city = [[NSString alloc] initWithFormat:@"%@",[jsonSubDic objectForKey:@"city"] ];
	date = [[NSString alloc] initWithFormat:@"%@", [jsonSubDic objectForKey:@"date_y"]];
	//	temp = [[NSString alloc] initWithFormat:@"%@", [jsonSubDic objectForKey:@"temp1"] ];
	NSString * tempJsonName = [[NSString alloc] initWithFormat:@"temp"];
	NSString * weathertempName = [[NSString alloc] initWithFormat:@"weather"];
	weatherArray = [[NSMutableArray alloc] initWithCapacity:6];
	tpArray = [[NSMutableArray alloc] initWithCapacity:6];
	
	NSString *tempName = [[NSString alloc] init];
	NSString *weatherName = [[NSString alloc] init];
	for (int i = 1; i <=6; i++) {
		tempName = [tempJsonName stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
		//NSLog(@"%@", tempName);
		weatherName = [weathertempName stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
		
		
		weather = [[NSString alloc] initWithFormat:@"%@", [jsonSubDic objectForKey:weatherName]];
		temp = [[NSString alloc] initWithFormat:@"%@", [jsonSubDic objectForKey:tempName] ];
		NSLog(@"%@", weather);
		[tpArray addObject:temp];
		[weatherArray addObject:weather];
	}
	NSLog(@"%@\n%@\n", city, date);
	[self.tableView reloadData];
	[self GetRecord];
}

//返回星期

-(NSInteger )GetRecord         //这一部分是用于点击END按钮后在小画板上显示的
{
    weekArray = [[NSMutableArray alloc]initWithCapacity:7];
    [weekArray addObject:@"星期日"];
    [weekArray addObject:@"星期一"];
    [weekArray addObject:@"星期二"];
    [weekArray addObject:@"星期三"];
    [weekArray addObject:@"星期四"];
    [weekArray addObject:@"星期五"];
    [weekArray addObject:@"星期六"];
    //创建日历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	//获取当前时间
	NSDate *now;
	
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
	NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
	//获取时间
	//   NSInteger year = [comps year];
	//   NSInteger month = [comps month];
	//   NSInteger day = [comps day];
    NSInteger week = [comps weekday]-1;
	//   NSInteger hour = [comps hour];
	//   NSInteger min = [comps minute];
	return week;
	
}


@end
