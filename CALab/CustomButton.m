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
    CALayer* hostingLayer = [ CALayer layer ];

    [ hostingLayer setDelegate: self ];

    [ hostingLayer setBounds: self.bounds ];
    [ hostingLayer setPosition: CGPointMake( NSMinX( self.frame ), NSMinY( self.frame ) ) ];
    [ hostingLayer setBackgroundColor: [ NSColor orangeColor ].CGColor ];

    [ self setLayer: hostingLayer ];
    [ self setLayerContentsRedrawPolicy: NSViewLayerContentsRedrawOnSetNeedsDisplay ];
    [ self setWantsLayer: YES ];
    }

- ( BOOL ) wantsUpdateLayer
    {
    return YES;
    }

- ( void ) drawLayer: ( nonnull CALayer* )_Layer inContext: ( nonnull CGContextRef )_cgCtx
    {
    NSLog( @"Fuck: %@", NSStringFromPoint( _Layer.position ) );

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

- ( void ) animate
    {
    [ self setFrameOrigin: NSMakePoint( 0.f, 10.f ) ];

    CABasicAnimation* basicAnim = [ CABasicAnimation animationWithKeyPath: @"position" ];
    [ basicAnim setDuration: .4f ];
    [ self.layer addAnimation: basicAnim forKey: @"position" ];
    [ self.layer setPosition: CGPointMake( 0.f, 10.f ) ];
    }

@end
