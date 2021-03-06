//
//  CustomLayer.h
//  CALab
//
//  Created by Tong G. on 8/28/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@import Cocoa;

@interface CustomLayer : CALayer
    {
@protected
    NSView __strong* _hostView;

    NSColor* _greenColor;
    NSColor* _orangeColor;
    }

- ( instancetype ) initWithHostView: ( NSView* )_View;

@end
