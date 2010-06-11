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

- (void) createExampleDocument
{
    NSMutableDictionary *attribs = [NSMutableDictionary dictionary];
    
    [attribs setValue:[[UIDevice currentDevice] uniqueIdentifier]
               forKey:@"udid"];  
    
    [attribs setValue:@"444"
               forKey:@"frequency"];  
    
    CLLocationDegrees lat = locationManager.location.coordinate.latitude;
    CLLocationDegrees lng = locationManager.location.coordinate.longitude;
    
    if (lat != 0.0 && lng != 0.0)
    {
        [attribs setValue:[NSString stringWithFormat:@"%f", lat]
                   forKey:@"lat"];  
        
        [attribs setValue:[NSString stringWithFormat:@"%f", lng]
                   forKey:@"lng"];  
    }

    [self create:@"examples" attribs:attribs];
}

- (void) fetchCustomResource
{
	[self executeGet:@"/samples/average.json" params:nil];    
}

@end
