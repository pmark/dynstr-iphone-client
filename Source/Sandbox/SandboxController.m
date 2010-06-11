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

#define API_KEY @"bx492"

@implementation SandboxController

@synthesize apiKeyLabel;
@synthesize sampleClient;

- (void) dealloc {
    RELEASE(apiKeyLabel);
    RELEASE(sampleClient);
    [super dealloc];
}

-

- (void) viewDidLoad {
    [super viewDidLoad];
    
    apiKeyLabel.text = API_KEY;
    
    self.sampleClient = [[SampleClient alloc] initWithApiKey:API_KEY];
}

#pragma mark -

- (IBAction) create 
{
	[sampleClient createSampleWithFrequency:321];
}

- (IBAction) find
{
    
}

- (IBAction) update
{
    
}

- (IBAction) destroy
{
    
}


@end
