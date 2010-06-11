//
//  SampleClient.m
//
//
//

#import "SampleClient.h"

@implementation SampleClient

@synthesize locationManager;

- (void) dealloc
{
    [locationManager release];
    [super dealloc];
}

- (id) initWithApiKey:(NSString*)key
{
	if (self = [super initWithApiKey:key]) 
    {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        
        if (locationManager.locationServicesEnabled) {
            locationManager.delegate = self;
            locationManager.distanceFilter = 1000;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [locationManager startUpdatingLocation];
        }        
    }
	return self;
}

- (void) create:(NSInteger)frequency udid:(NSString*)udid 
{
    NSString *latitudeString = [NSString stringWithFormat:@"%f", 
                                locationManager.location.coordinate.latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", 
                                 locationManager.location.coordinate.longitude];
    NSString *frequencyString = [NSString stringWithFormat:@"%i", frequency];  
    
    NSMutableDictionary *attribs = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    udid, @"udid",
                                    frequencyString, @"frequency",
                                    nil];
    
    if (latitude != 0.0 && longitude != 0.0)
    {
        [attribs setValue:latitudeString forKey:@"lat"];  
        [attribs setValue:longitudeString forKey:@"lng"];  
    }

    [self create:@"samples" attribs:attribs];
}

@end
