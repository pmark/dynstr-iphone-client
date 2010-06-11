//
//  ResponseController.h
//  Dynstr
//
//  Created by P. Mark Anderson on 6/10/10.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResponseController : UIViewController {
    NSString *text;
	IBOutlet UITextView *textView;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
