//
//  SampleClient.h
//
//  Created by P. Mark Anderson on 12/7/09.
//  Copyright 2010 Spot Metrix. All rights reserved.
//

#import "DynstrClient.h"
#import <MapKit/MapKit.h>

@interface SampleClient : DynstrClient <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

- (void) createExampleDocument;
- (void) fetchCustomResource;

@end
