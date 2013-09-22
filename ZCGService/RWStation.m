//
//  RWStation.m
//  RWMapping
//
//  Created by Matt Galloway on 23/06/2012.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import "RWStation.h"

#import <AddressBook/AddressBook.h>

@implementation RWStation

- (MKMapItem*)mapItem {
    // 1
    NSDictionary *addressDict = @{
    (NSString*)kABPersonAddressCountryKey : @"UK",
    (NSString*)kABPersonAddressCityKey : @"London",
    (NSString*)kABPersonAddressStreetKey : @"10 Downing Street",
    (NSString*)kABPersonAddressZIPKey : @"SW1A 2AA"};
    
    // 2
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:addressDict];
    
    // 3
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    mapItem.phoneNumber = @"+44-20-8123-4567";
    mapItem.url = [NSURL URLWithString:@"http://www.raywenderlich.com/"];
    
    return mapItem;
}

@end
