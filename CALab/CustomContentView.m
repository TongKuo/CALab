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
    [ self setWantsLayer: YES ];
    }

- ( void ) updateLayer
    {
    NSLog( @"%s", __PRETTY_FUNCTION__ );
    [ super updateLayer ];
    }

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    NSLog( @"%s", __PRETTY_FUNCTION__ );
    }

- ( void ) displayLayer: ( nonnull CALayer* )_Layer
    {
    NSImage* image = [ [ NSImage alloc ] initWithData: [ NSData dataWithContentsOfFile: @"/Users/EsquireTongG/Desktop/Okanogan_Complex_Fire_-_USFS.jpg" ] ];
    [ _Layer setContents: image ];
    }

- ( IBAction ) updateAction: ( id )_Sender
    {
    [ self setNeedsDisplay: YES ];
    }

@end