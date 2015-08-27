//
//  LayerBackedButton.m
//  CALab
//
//  Created by Tong G. on 8/27/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "LayerBackedButton.h"

@implementation LayerBackedButton

- ( void ) awakeFromNib
    {
    [ self setWantsLayer: YES ];
    }

- ( BOOL ) wantsUpdateLayer
    {
    return YES;
    }

- ( void ) updateLayer
    {
    NSLog( @"%s", __PRETTY_FUNCTION__ );
    [ self.layer setBackgroundColor: [ NSColor orangeColor ].CGColor ];
    }

//- ( void ) drawLayer:(nonnull CALayer *)layer inContext:(nonnull CGContextRef)ctx
//    {
//    NSLog( @"%s", __PRETTY_FUNCTION__ );
//    }

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];
    NSLog( @"%s", __PRETTY_FUNCTION__ );
    }

@end
