//
//  MapViewController.m
//  ZCGService
//
//  Created by wukai on 13-9-15.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "MapViewController.h"
#import "BMapKit.h"
#import "BMKAnnotation.h"

@interface MapViewController () <BMKMapViewDelegate>

@end

@implementation MapViewController
{
	BMKMapView *mapView;
	BMKPointAnnotation *annotation;
	BMKAnnotationView *annoationView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	mapView =[[BMKMapView alloc] initWithFrame:self.view.bounds];
	
	self.view = mapView;
	mapView.showsUserLocation = YES;
	//111.413427,32.92282
	CLLocationCoordinate2D coordinate; //设定经纬度
	coordinate.latitude =32.92282; //纬度
	coordinate.longitude =111.413427; //经度

	annotation = [[BMKPointAnnotation alloc]init];
	annotation.coordinate = coordinate;
	annotation.title = @"test";
	annotation.subtitle = @"testtest";


	[mapView addAnnotation:annotation];
	mapView.zoomEnabled = YES;
	mapView.zoomLevel = 12.0;
	mapView.showMapScaleBar = YES;
	
	[self Region];
	
}
- (void)Region
{
	//111.413427,32.92282
	CLLocationCoordinate2D coordinate; //设定经纬度
	coordinate.latitude =32.92282; //纬度
	coordinate.longitude =111.413427; //经度
	//将经纬度坐标转换为百度地图坐标
	NSDictionary *tip = BMKBaiduCoorForWgs84(coordinate);
	//百度地图经纬度
	CLLocationCoordinate2D coor1 = BMKCoorDictionaryDecode(tip);
	//一个经纬度区域
	BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor1,
															 BMKCoordinateSpanMake(0.05, 0.05));
	//根据viewRegion传入的数据返回合适的大小
	BMKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
	[mapView setRegion:adjustedRegion animated:YES];
	
}
/**
 *  选中一个坐标点时
 *
 *  @param mapView 传入的mapview
 *  @param view    该坐标点
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
	NSLog(@"选中一个annotationviews:%f, %f",
		  view.annotation.coordinate.latitude, view.annotation.coordinate.longitude);
}
/**
 *  取消选中的点
 *
 *  @param mapView 传入的mapview
 *  @param view   该点的坐标
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
	NSLog(@"取消选中的点");
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
	NSLog(@"加入坐标点");
}

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
	NSLog(@"点击弹出了泡泡");
}

/**
 *  拖动annotationview时view的变化
 *
 *  @param animated <#animated description#>
 */
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState fromOldState:(BMKAnnotationViewDragState)oldState
{
	NSLog(@"拖动annoationview");
}


- (void)viewWillAppear:(BOOL)animated
{
	mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[mapView viewWillDisappear];
	mapView.delegate = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
