//
//  SandboxController.h
//  Dynstr
//
//  Created by P. Mark Anderson on 6/10/10.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleClient.h"

@interface SandboxController : UIViewController <DynstrClientDelegate> {
    IBOutlet UILabel *apiKeyLabel;
    SampleClient *sampleClient;
}

@property (nonatomic, retain) IBOutlet UILabel *apiKeyLabel;
@property (nonatomic, retain) SampleClient *sampleClient;

- (IBAction) create;
- (IBAction) find;
- (IBAction) update;
- (IBAction) destroy;

@end
