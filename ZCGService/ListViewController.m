//
//  ListViewController.m
//  ZCGService
//
//  Created by wukai on 13-9-8.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "ListViewController.h"
#import "DetailInfoViewController.h"
#import "PageIntroViewController.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ListViewController
{
	NSDictionary *dict_;
	NSArray *keysArray_;
	NSArray *introductArray_;
	NSArray *listArray_;
	NSString *key_;
}
/******************************************************************************/
/**
 *	@brief	dict字典保存所有的信息
 *	keysArray 保存key的信息与dict中的key对应，防止从dict中读取顺序发生改变
 *	introductArray保存第一个section中的信息
 *	listArray保存section2中的所有信息
 */
/******************************************************************************/
- (void)setValue:(NSString *)value
{
	key_ = value;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
	NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
	dict_ = [[NSDictionary alloc] initWithDictionary:[dictionary objectForKey:key_]];
	//获取keys
	NSString *keysPath = [[NSBundle mainBundle] pathForResource:key_ ofType:@"plist"];
	keysArray_ = [[NSArray alloc] initWithContentsOfFile:keysPath];
	
	
	introductArray_ = [[NSArray alloc]initWithArray:
					   [dict_ objectForKey:[keysArray_ objectAtIndex:0]]];
	//		NSLog(@"intro %@", introductArray_);
	listArray_ = [[NSArray alloc]initWithArray:
				  [dict_ objectForKey:[keysArray_ objectAtIndex:1]]];
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
	[self.view addSubview:self.tableView];
}


#pragma mark - dataSource delegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 1;
	}
	return [listArray_ count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return [keysArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier = @"identifier";
	static NSString * introIdentifier = @"introIdentifier";
	
//	NSString *temstring = [listArray_ objectAtIndex:indexPath.section];
	//介绍cell
	if (indexPath.section == 0) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:introIdentifier];
		
		if (nil == cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introIdentifier];
		}
		//cell内容
		NSString *tempName = [introductArray_ objectAtIndex:0];
		NSString *tempContentName = [introductArray_ objectAtIndex:1];
		
		//介绍
		UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		UIFont *nameLabelFont = [UIFont fontWithName:@"Arial" size:18];
		nameLabel.backgroundColor = [UIColor clearColor];
		CGSize nameLabelSize = [tempName sizeWithFont:nameLabelFont];
		nameLabel.font = nameLabelFont;
		nameLabel.text = tempName;
		nameLabel.frame = CGRectMake(8, 8, nameLabelSize.width, nameLabelSize.height);
		
		[cell.contentView addSubview:nameLabel];
		
		//详细介绍
		UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		introLabel.tag = 2;
		introLabel.numberOfLines = 0;
		introLabel.backgroundColor = [UIColor clearColor];
		introLabel.lineBreakMode = NSLineBreakByCharWrapping;
		introLabel.text = tempContentName;
//		NSLog(@"%@", tempContentName);
		UIFont *introLabelFont = [UIFont fontWithName:@"Arial" size:14];
		introLabel.font = introLabelFont;
		CGSize introLabelSize = [tempContentName sizeWithFont:introLabelFont
											constrainedToSize:CGSizeMake(290, MAXFLOAT)
												lineBreakMode:NSLineBreakByCharWrapping];
		introLabel.frame = CGRectMake(8, nameLabelSize.height+10, introLabelSize.width, introLabelSize.height);
		
		[cell.contentView addSubview:introLabel];
		
		CGSize size = CGSizeMake(320, nameLabelSize.height + introLabelSize.height+15);
		cell.frame = CGRectMake(0, 0, 320, size.height);
		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
	}
	
	
	//景点cell
	UITableViewCell *cell = nil;
	cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:identifier];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;	
	UIImageView *scenicImage = [[UIImageView alloc]init];
	
	UILabel *scenicNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	//set frame
	CGRect sceniceImageFrame = CGRectMake(10, 16, 80, 60);
	scenicImage.frame = sceniceImageFrame;
	
	CGRect scenicNameLabelFrame = CGRectMake(100, 16, 200, 18);
	scenicNameLabel.frame = scenicNameLabelFrame;
	scenicNameLabel.font = [UIFont fontWithName:@"Arial" size:16];
	
	CGRect infoLabelFrame = CGRectMake(100, 35, 50, 15);
	infoLabel.frame = infoLabelFrame;
	infoLabel.font = [UIFont fontWithName:@"Arial" size:12];
	
	CGRect introduceLabelFrame = CGRectMake(100, 52, 200, 40);
	introduceLabel.frame = introduceLabelFrame;
	introduceLabel.font = [UIFont fontWithName:@"Arial" size:10];
	introduceLabel.numberOfLines = 0;
	introduceLabel.lineBreakMode = NSLineBreakByWordWrapping;
	
	//set content
	NSArray *infoArray = [listArray_ objectAtIndex:indexPath.row];
	NSString *name = nil;
	name = [NSString stringWithString:[infoArray objectAtIndex:0]];
	UIImage *image = nil;
	image = [UIImage imageNamed:name];
	scenicImage.image = nil;
	[scenicImage setImage:image];
	
	
	scenicNameLabel.text = [NSString stringWithString:[infoArray objectAtIndex:1]];
	infoLabel.text = [infoArray objectAtIndex:2];
	introduceLabel.text = [infoArray objectAtIndex:3];
	//添加到cell
	[cell.contentView addSubview:scenicImage];
	[cell.contentView addSubview:scenicNameLabel];
	[cell.contentView addSubview:infoLabel];
	[cell.contentView addSubview:introduceLabel];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}



#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
	UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	return cell.frame.size.height;
	}
	else
		return 92;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 12;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] init];
	view.backgroundColor = [UIColor clearColor];
	return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UILabel *label = [[UILabel alloc] init];
	label.frame = CGRectMake(10, 50, self.view.bounds.size.width, 30);
	label.font = [UIFont fontWithName:@"Kailasa" size:20];
	label.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
//	label.backgroundColor = [UIColor orangeColor];
	NSString *headerString = [NSString stringWithString:[keysArray_ objectAtIndex:section ]];
	//label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	label.text = headerString;
	
	return label;
}

 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		return;
	}
	else if ([[listArray_ objectAtIndex:indexPath.row] count] == 4) {
		NSLog(@"点这里");
		PageIntroViewController *pageIntroController = [[PageIntroViewController alloc] init];
		[self.navigationController pushViewController:pageIntroController animated:YES];
	}
	else
	{
		NSString *temp = [NSString stringWithString:[[listArray_ objectAtIndex:indexPath.row]objectAtIndex:4]];
		DetailInfoViewController *detail = [[DetailInfoViewController alloc]init];
		self.detailDelegate = detail;
		[self.detailDelegate setValue:temp];
		[self.navigationController pushViewController:detail animated:YES];
	}
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
