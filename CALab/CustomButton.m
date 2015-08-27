//
//  CustomButton.m
//  CALab
//
//  Created by Tong G. on 8/27/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import QuartzCore;
#import "CustomButton.h"

@implementation CustomButton

- ( void ) awakeFromNib
    {
//    [ self setWantsLayer: YES ];
//    [ self setLayerContentsRedrawPolicy: NSViewLayerContentsRedrawOnSetNeedsDisplay ];
//
//    CALayer* hostingLayer = [ CALayer layer ];
//
//    [ hostingLayer setDelegate: self ];
//
//    [ hostingLayer setBounds: self.bounds ];
//    [ hostingLayer setAnchorPoint: NSMakePoint( 0.f, 0.f ) ];
////    [ hostingLayer setBackgroundColor: [ NSColor orangeColor ].CGColor ];
//    [ hostingLayer setPosition: CGPointMake( 0.f, 0.f ) ];
//
//    [ self setLayer: hostingLayer ];

    NSLog( @"Layer: %@", self.layer );
    }

//- ( BOOL ) wantsUpdateLayer
//    {
//    return YES;
//    }
//
//- ( void ) updateLayer
//    {
//    NSLog( @"%s", __PRETTY_FUNCTION__ );
//    }

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];

//    [ [ NSColor orangeColor ] set ];
    }

//- ( void ) displayLayer: ( nonnull CALayer* )_Layer
//    {
//    NSLog( @"%@", _Layer );
//    }

- ( void ) drawLayer: ( nonnull CALayer* )_Layer inContext: ( nonnull CGContextRef )_cgCtx
    {
    NSLog( @"Fuck: %@", _Layer );

    CGContextRef cgContext = _cgCtx;
    CGMutablePathRef cgPath = CGPathCreateMutable();

    CGPathAddRect( cgPath, NULL, CGRectMake( NSMinX( self.bounds ), NSMinY( self.bounds ), NSWidth( self.bounds ), NSHeight( self.bounds ) ) );
    CGContextAddPath( cgContext, cgPath );
    CGContextSetLineWidth( cgContext, 1.f );

    if ( self.cell.isHighlighted )
        {
        CGColorRef cgColor = CGColorCreateGenericRGB( 1.f, 1.f, 1.f, 1.f );
        CGContextSetStrokeColorWithColor( cgContext, cgColor );
        CFRelease( cgColor );
        }

    CGContextStrokePath( cgContext );

    CFRelease( cgPath );
    }
//
//- ( void ) animate
//    {
//
//    }

@end
