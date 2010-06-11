//
//  DynstrClient.h
//  Dynstr
//
//  Created by P. Mark Anderson on 6/10/10.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRiot.h"

@protocol DynstrClientDelegate;

@interface DynstrClient : HRRestModel <HRResponseDelegate> 
{
    NSObject<DynstrClientDelegate> *clientDelegate;
	NSString *apiKey;
}

@property (nonatomic, assign) NSObject<DynstrClientDelegate> *clientDelegate;
@property (nonatomic, retain) NSString *apiKey;

- (id) initWithApiKey:(NSString*)key;
- (void) create:(NSString*)collection attribs:(NSDictionary*)attribs;
- (void) find:(NSString*)collection attribs:(NSDictionary*)attribs;
- (void) update:(NSString*)collection identifier:(NSString*)identifier attribs:(NSDictionary*)attribs;
- (void) destroy:(NSString*)collection identifier:(NSString*)identifier;
- (void) executeGet:(NSString*)endpoint params:(NSDictionary*)params;

@end

@protocol DynstrClientDelegate
- (void) apiClient:(DynstrClient*)client didReceiveResource:(NSDictionary*)resource;
- (void) apiClient:(DynstrClient*)client didReceiveErrorMessages:(NSArray*)messages;
@end
