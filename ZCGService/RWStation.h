//
//  RWStation.h
//  RWMapping
//
//  Created by Matt Galloway on 23/06/2012.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RWStation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (MKMapItem*)mapItem;

@end
