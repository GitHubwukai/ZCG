//
//  ZCGMapViewController.m
//  ZCGService
//
//  Created by wukai on 13-9-24.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "ZCGMapViewController.h"
#import "NAMapView.h"
#import "NAAnnotation.h"
@interface ZCGMapViewController ()

@end

@implementation ZCGMapViewController

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
	NAMapView *mapView = [[NAMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.backgroundColor  = [UIColor whiteColor];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    mapView.minimumZoomScale = 1.0f;
    mapView.maximumZoomScale = 1.5f;
    
    [mapView displayMap:[UIImage imageNamed:@"map.jpg"]];
    
    [self.view addSubview:mapView];
    
    
    NAAnnotation * perth            = [NAAnnotation annotationWithPoint:CGPointMake(160.0f, 430.0f)];
	perth.title                     = @"正门";
    perth.subtitle                  = @"I have a button";
	perth.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    perth.color                     = NAPinColorPurple;
    
	[mapView addAnnotation:perth animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
