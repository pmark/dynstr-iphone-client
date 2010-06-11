//
//  DynstrClient.m
//  Dynstr
//
//  Created by P. Mark Anderson on 6/10/10.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import "DynstrClient.h"

#define API_BASE_URL @"http://dynstr.heroku.com"
#define API_CREATE_ENDPOINT @"/apikey/collections/%@"
#define API_FIND_ENDPOINT @"/apikey/collections/%@.json"
#define API_UPDATE_ENDPOINT @"/apikey/collections/%@"
#define API_DESTROY_ENDPOINT @"/apikey/collections/%@"

@implementation DynstrClient

@synthesize apiKey;
@synthesize clientDelegate;

- (void) dealloc
{
	[apiKey release];
    [super dealloc];
}

- (id) initWithApiKey:(NSString*)key
{
	if (self = [super init]) 
    {
        self.apiKey = key;
    }
	return self;
}

- (NSString*) initEndpointForCollection:(NSString*)collection
{
    [[self class] setBaseURL:[NSURL URLWithString:API_BASE_URL]];
	[[self class] setDelegate:self];
	//NSString *url = [NSString stringWithFormat:@"%@%@", [[self class] baseURL], endpoint];    
    return [NSString stringWithFormat:API_UPDATE_ENDPOINT, collection];
}

- (void) create:(NSString*)collection attribs:(NSDictionary*)attribs
{
    NSString *endpoint = [self initEndpointForCollection:collection];

    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"application/x-www-form-urlencoded", @"Content-Type", nil];
    
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInt:HRDataFormatUnknown], kHRClassAttributesFormatKey,
                             headers, kHRClassAttributesHeadersKey,
                             attribs, kHRClassAttributesBodyKey,
                             nil];

    [[self class] setDefaultParams:nil];    
	[[self class] postPath:endpoint withOptions:options object:nil];
}

- (void) find:(NSString*)collection attribs:(NSDictionary*)attribs
{
    NSString *endpoint = [self initEndpointForCollection:collection];

	NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:HRDataFormatJSON] 
                                                        forKey:kHRClassAttributesFormatKey];
    
    [[self class] setDefaultParams:attribs];    
	[[self class] getPath:endpoint withOptions:options object:nil];
}

- (void) update:(NSString*)collection identifier:(NSString*)identifier attribs:(NSDictionary*)attribs
{
    NSString *endpoint = [self initEndpointForCollection:collection];
    
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"application/x-www-form-urlencoded", @"Content-Type", nil];
    
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInt:HRDataFormatUnknown], kHRClassAttributesFormatKey,
                             headers, kHRClassAttributesHeadersKey,
                             attribs, kHRClassAttributesBodyKey,
                             nil];
    
    [[self class] setDefaultParams:nil];    
	[[self class] putPath:endpoint withOptions:options object:nil];
}

- (void) destroy:(NSString*)collection identifier:(NSString*)identifier
{
    NSString *endpoint = [self initEndpointForCollection:collection];
    
	NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:HRDataFormatJSON] 
                                                        forKey:kHRClassAttributesFormatKey];
    
    [[self class] setDefaultParams:nil];
	[[self class] deletePath:endpoint withOptions:options object:nil];
}

#pragma mark -

- (void)restConnection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response object:(id)object 
{
	NSURL *url = [response URL];
	NSString *urlStr = [url absoluteString];
	NSLog(@"[API] Received response (code %i) URL: %@", [response statusCode], urlStr);
}

- (void)restConnection:(NSURLConnection*)connection didReturnResource:(id)resource object:(id)object 
{
    if (self.clientDelegate) 
        [self.clientDelegate apiClient:self didReceiveResource:(NSDictionary*)resource];
}

- (void)restConnection:(NSURLConnection*)connection didReceiveError:(NSError*)error response:(NSHTTPURLResponse*)response object:(id)object 
{
	// Received a bad status code 404, 500, etc.
	NSURL *url = [response URL];
	NSString *urlStr = [url absoluteString];
	NSLog(@"[DynstrClient] Error (code %i) URL: %@", [error code], urlStr);
    
    NSString *message = [NSString stringWithFormat:@"Sorry, the server is temporarily experiencing technical difficulties (code %i).", [error code]];
    if (self.clientDelegate)
        [self.clientDelegate apiClient:self didReceiveErrorMessages:[NSArray arrayWithObject:message]];
}

- (void)restConnection:(NSURLConnection*)connection didReceiveParseError:(NSError*)error responseBody:(NSString*)string object:(id)object
{
	NSLog(@"[DynstrClient] Parse error (code %i): %@", [error code], error);
	NSLog(@"[DynstrClient] Response Body: %@", string);
    
    NSString *message = [NSString stringWithFormat:@"Sorry, the server is temporarily experiencing technical difficulties (format error)."];
    if (self.clientDelegate)
        [self.clientDelegate apiClient:self didReceiveErrorMessages:[NSArray arrayWithObject:message]];  
}

- (void)restConnection:(NSURLConnection*)connection didFailWithError:(NSError*)error object:(id)object 
{
	NSLog(@"[DynstrClient] Error getting connection: code: %i", [error code]);	
}

@end
