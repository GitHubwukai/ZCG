//
//  turingViewController.m
//  MapDemo
//
//  Created by wukai on 13-9-21.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "RWStation.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface MapViewController () <MKMapViewDelegate>{
	NSMutableArray *_stations;
}

typedef NS_ENUM(NSInteger, RWMapMode) {
    RWMapModeNormal = 0,
    RWMapModeLoading,
    RWMapModeDirections,
};

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, assign) RWMapMode mapMode;

@end

@implementation MapViewController


- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"地图模式";
    }
    return self;
}
 -(void)loadData
{
	NSData *data = [NSData dataWithContentsOfFile:
					[[NSBundle mainBundle]
					 pathForResource:@"victoria_line"
					 ofType:@"json"]];
	NSArray *stationData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	
	NSUInteger stationCount = stationData.count;
	
	_stations = [[NSMutableArray alloc] initWithCapacity:stationCount];
	for (NSDictionary *stationDictionary in stationData) {
		CLLocationDegrees latitude = [[stationDictionary objectForKey:@"latitude"] doubleValue];
		CLLocationDegrees longitude = [[stationDictionary objectForKey:@"longitude"] doubleValue];
		
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
		
		RWStation *station = [[RWStation alloc] init];
		station.title = [stationDictionary objectForKey:@"name"];
		station.coordinate = coordinate;
		[_stations addObject:station];
	}
	
}

- (void)setMapMode:(RWMapMode)mapMode {
    _mapMode = mapMode;
    
    switch (mapMode) {
        case RWMapModeNormal: {
			[self.mapView addAnnotations:_stations];
        }
            break;
        case RWMapModeLoading: {
            self.title = @"Loading...";
        }
            break;
        case RWMapModeDirections: {
            self.title = @"Directions";
        }
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.mapView];
	
	[self loadData];
	self.mapMode = RWMapModeNormal;
	
//	CLLocationCoordinate2D center = CLLocationCoordinate2DMake(51.525635, -0.081985);
	CLLocationCoordinate2D center = CLLocationCoordinate2DMake(32.778561,111.489499);
	MKCoordinateSpan span = MKCoordinateSpanMake(0.12649, 0.12405);
	MKCoordinateRegion regionToDisplay = MKCoordinateRegionMake(center, span);
	[self.mapView setRegion:regionToDisplay animated:NO];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RWStation class]]) {
		static NSString *const kPinIdentifier = @"RWStation";
		MKPinAnnotationView *view = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:kPinIdentifier];
		if (!view) {
			view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPinIdentifier];
			view.canShowCallout = YES;
			view.calloutOffset = CGPointMake(-5, 5);
			view.animatesDrop = NO;
		}
		
		view.pinColor = MKPinAnnotationColorGreen;
		return view;
	}
	return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
