//
//  CustomContentView.h
//  CALab
//
//  Created by Tong G. on 8/26/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CustomContentView : NSView
    {
@protected
    NSTimer __strong* _timer;
    }

@property ( weak ) IBOutlet NSButton* buttonTop;
@property ( weak ) IBOutlet NSButton* buttonBottom;

- ( IBAction ) buttonTopClickedAction: ( id )_Sender;

@end
