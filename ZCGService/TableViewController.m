//
//  TableViewController.m
//  ZCGService
//
//  Created by wukai on 13-9-16.
//  Copyright (c) 2013年 wukai. All rights reserved.
//


#import "TableViewController.h"



@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewController
{
	CGFloat cellHeight_;
	NSArray *allInfoArray;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @"交通";
		NSString *path = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
		NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
		allInfoArray = [[NSArray alloc] initWithArray:[dictionary objectForKey:@"traffic"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.tableFooterView = [[UIView alloc]init];
	[self.view addSubview:self.tableView];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [allInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"identifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	NSArray *trafficInfo = [allInfoArray objectAtIndex:indexPath.row];
	NSString *title = [NSString stringWithString:[trafficInfo objectAtIndex:0]];
	NSString *content = [NSString stringWithString:[trafficInfo objectAtIndex:1]];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	titleLabel.text = title;
	UIFont  *titleFont = [UIFont fontWithName:@"Arial" size:18];
	titleLabel.font = titleFont;
	titleLabel.textColor = [UIColor blueColor];
	titleLabel.numberOfLines = 0;
	titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	
	CGSize titleSize = [titleLabel.text sizeWithFont:titleFont constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
	titleLabel.frame = CGRectMake(10, 10, titleSize.width, titleSize.height);
	
	
	UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	contentLabel.text = content;
	contentLabel.numberOfLines = 0;
	UIFont *contentFont = [UIFont fontWithName:@"Arial" size:15];
	contentLabel.font = contentFont;
	titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	
	CGSize contentSize = [contentLabel.text sizeWithFont:contentFont constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
	contentLabel.frame = CGRectMake(10,titleSize.height+15, contentSize.width, contentSize.height);
	
	[cell sizeToFit];
	
	[cell.contentView addSubview:titleLabel];
	[cell.contentView addSubview:contentLabel];
	
	cellHeight_ = titleSize.height + contentSize.height + 25;
	cell.frame = CGRectMake(0, 0, 320, cellHeight_);
	return cell;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	return cell.frame.size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
