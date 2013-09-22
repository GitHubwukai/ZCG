//
//  DetailInfoViewController.m
//  ZCGService
//
//  Created by wukai on 13-9-10.
//  Copyright (c) 2013年 wukai. All rights reserved.
//


#import "DetailInfoViewController.h"
#import "MapViewController.h"


@interface DetailInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DetailInfoViewController
{
	UIImageView *imageView_;
	UITableView *tablesView_;
	UITextView *textView_;
	UIScrollView *scrollView_;
	
	NSArray *allInfoArray_;
	
	NSString *title;
	NSArray *imageArray_;
	NSArray *infoArray_;
	NSArray *textArray_;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setValue:(NSString *)value
{
	_detailValue = value;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"detailInfo" ofType:@"plist"];
	NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
	
	allInfoArray_ = [[NSArray alloc]initWithArray:[dictionary objectForKey:_detailValue]];
	
	title = [NSString stringWithString:[allInfoArray_ objectAtIndex:0]];
	imageArray_ = [[NSArray alloc] initWithArray:
				   [allInfoArray_ objectAtIndex:1]];
	infoArray_ = [[NSArray alloc] initWithArray:
				  [allInfoArray_ objectAtIndex:2]];
	textArray_ = [[NSArray alloc] initWithArray:
				  [allInfoArray_ objectAtIndex:3]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	scrollView_ = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	
	//image
	UIImage *image = [UIImage imageNamed:@"1.jpg"];
	imageView_ = [[UIImageView alloc] initWithImage:image];
	imageView_.frame = CGRectMake(0, 0, 320, 160);
	[scrollView_ addSubview:imageView_];
	//table view
	tablesView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 163, 320, 132) style:UITableViewStylePlain];
	tablesView_.delegate = self;
	tablesView_.dataSource = self;
	[scrollView_ addSubview:tablesView_];
//	textView_
	textView_ = [[UITextView alloc] initWithFrame:CGRectMake(0, 295, 320, 305)];
	textView_.backgroundColor = [UIColor orangeColor];
	[scrollView_ addSubview:textView_];
	
	scrollView_.contentSize = CGSizeMake(320, 600);
	[self.view addSubview:scrollView_];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"identifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
		
	cell.textLabel.text = [infoArray_ objectAtIndex:indexPath.row];
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 1) {
	//map
		MapViewController *mapController = [[MapViewController alloc] init];
		[self.navigationController pushViewController:mapController animated:YES];
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
