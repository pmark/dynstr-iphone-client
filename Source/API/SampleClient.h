//
//  SampleClient.h
//
//  Created by P. Mark Anderson on 12/7/09.
//  Copyright 2010 Spot Metrix. All rights reserved.
//

#import "APIClient.h"
#import <MapKit/MapKit.h>

@interface SampleClient : APIClient {
}

- (void) create:(NSInteger)frequency udid:(NSString*)udid latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;
- (void) fetchAverage;

@end
