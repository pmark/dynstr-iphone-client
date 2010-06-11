//
//  ResponseController.m
//  Dynstr
//
//  Created by P. Mark Anderson on 6/10/10.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import "ResponseController.h"
#import "Constants.h"

@implementation ResponseController

@synthesize text;
@synthesize textView;

- (void)dealloc {
    RELEASE(text);
    RELEASE(textView);
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = text;
}

@end
