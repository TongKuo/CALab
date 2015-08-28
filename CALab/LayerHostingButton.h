//
//  LayerHostingButton.h
//  CALab
//
//  Created by Tong G. on 8/27/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LayerHostingButton : NSButton
    {
@private
    NSColor* _greenColor;
    NSColor* _orangeColor;
    }

- ( void ) animate;

@end
