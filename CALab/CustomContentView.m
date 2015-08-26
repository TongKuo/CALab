//
//  CustomContentView.m
//  CALab
//
//  Created by Tong G. on 8/26/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "CustomContentView.h"

@implementation CustomContentView

- ( void ) awakeFromNib
    {
//    NSLog( @"%d", self.wantsUpdateLayer );
    [ self setWantsLayer: YES ];

    CALayer* hostingLayer = [ CALayer layer ];
    hostingLayer.backgroundColor = [ NSColor purpleColor ].CGColor;
    [ self setLayer: hostingLayer ];
    }

//- ( void ) drawRect: ( NSRect )_DirtyRect
//    {
//    [ super drawRect: _DirtyRect ];
//    }

- ( void ) drawLayer: ( nonnull CALayer* )_Layer
           inContext: ( nonnull CGContextRef )_Ctx
    {
    NSLog( @"%s", __PRETTY_FUNCTION__ );
    }

- ( void ) updateLayer
    {
    NSLog( @"%s", __PRETTY_FUNCTION__ );
    [ super updateLayer ];
    self.layer.backgroundColor = [ NSColor orangeColor ].CGColor;
    }

@end
