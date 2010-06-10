//
//  SampleClient.m
//
//
//

#import "SampleClient.h"

#define API_BASE_URL @"http://omphone.heroku.com"
//#define API_BASE_URL @"http://192.168.20.5:3000"
#define API_CREATE_ENDPOINT @"/samples"
#define API_AVERAGE_ENDPOINT @"/samples/average.json"

@implementation SampleClient

- (void) create:(NSInteger)frequency udid:(NSString*)udid latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude 
{
    NSString *latitudeString = [NSString stringWithFormat:@"%f", latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", longitude];
    NSString *frequencyString = [NSString stringWithFormat:@"%i", frequency];  
    
    [self initParameters];    
    [self.httpParameters setValue:udid forKey:@"udid"];  
    [self.httpParameters setValue:frequencyString forKey:@"frequency"];    
    
    if (latitude != 0.0 && longitude != 0.0)
    {
        [self.httpParameters setValue:latitudeString forKey:@"lat"];  
        [self.httpParameters setValue:longitudeString forKey:@"lng"];  
    }

    self.baseURL = API_BASE_URL;    
    [self executePostRequest:API_CREATE_ENDPOINT];
}

- (void) fetchAverage
{
    [self initParameters];        
    self.baseURL = API_BASE_URL;    
    [self executeGetRequest:API_AVERAGE_ENDPOINT];
}

#pragma mark -
- (void) sendRemoteItems:(id)results {    
    //NSLog(@"[API] Preparing results of type %@: %@", [results class], results);
    
    NSArray *itemArray = [NSArray arrayWithObject:results];
    
    [self.resultsDelegate apiClient:self didReceiveRemoteItems:itemArray];
}

- (void) prepareResults:(NSDictionary*)tree {
    if (self.resultsDelegate == nil) {
        return;
    }
    
    if ([tree count] == 0)
        return;    
    //[self.resultsDelegate apiClient:self didReceiveEmptyResultSet:self.httpParameters];  

    id results = [tree objectForKey:@"average"];
    if (results) {
        [self sendRemoteItems:results];
        return;
    }
}




@end
