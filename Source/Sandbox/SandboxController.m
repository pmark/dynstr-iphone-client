//
//  SandboxController.m
//  Dynstr
//
//  Created by P. Mark Anderson on 6/10/10.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import "SandboxController.h"
#import "Constants.h"
#import "ResponseController.h"
#import "UIApplication_TLCommon.h"

#define API_KEY @"bx492"

@implementation SandboxController

@synthesize apiKeyLabel;
@synthesize sampleClient;

- (void) dealloc {
    RELEASE(apiKeyLabel);
    RELEASE(sampleClient);
    [super dealloc];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    apiKeyLabel.text = API_KEY;
    
    self.sampleClient = [[SampleClient alloc] initWithApiKey:API_KEY];
    sampleClient.clientDelegate = self;
}

#pragma mark -

- (IBAction) create 
{
    [[UIApplication sharedApplication] didStartNetworkRequest];
	[sampleClient createExampleDocument];
}

- (IBAction) find
{
    [[UIApplication sharedApplication] didStartNetworkRequest];
	[sampleClient fetchCustomResource];
}

- (IBAction) update
{
    
}

- (IBAction) destroy
{
    
}

#pragma mark -

- (void) pushResponseControllerWithText:(NSString*)text
{
    ResponseController *rc = [[ResponseController alloc] init];
    rc.text = text;
    [self.navigationController pushViewController:rc animated:YES];
    [rc release];
}

- (void) apiClient:(DynstrClient*)client didReceiveResource:(NSDictionary*)resource
{
    [[UIApplication sharedApplication] didStopNetworkRequest];
	NSLog(@"Did receive resource: %@", resource);   
    [self pushResponseControllerWithText:[resource description]];
}

- (void) apiClient:(DynstrClient*)client didReceiveErrorMessages:(NSArray*)messages
{
    [[UIApplication sharedApplication] didStopNetworkRequest];
	NSLog(@"Did receive errors: %@", messages);    
    [self pushResponseControllerWithText:[messages description]];
}

@end
