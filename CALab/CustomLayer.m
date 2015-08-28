//
//  CustomLayer.m
//  CALab
//
//  Created by Tong G. on 8/28/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "CustomLayer.h"

@implementation CustomLayer

- ( instancetype ) initWithHostView: ( NSView* )_HostView
    {
    if ( self = [ super init ] )
        self->_hostView = _HostView;

    return self;
    }

- ( void ) drawInContext: ( nonnull CGContextRef )_cgCtx
    {
    NSLog( @">>> Layer: %@", NSStringFromPoint( self.position ) );

    CGContextRef cgContext = _cgCtx;
    CGMutablePathRef cgPath = CGPathCreateMutable();

    CGPathAddRect( cgPath, NULL, CGRectMake( NSMinX( self.bounds ), NSMinY( self.bounds ), NSWidth( self.bounds ), NSHeight( self.bounds ) ) );
    CGContextAddPath( cgContext, cgPath );
    CGContextSetLineWidth( cgContext, 1.f );

    if ( ( ( NSControl* )( self->_hostView ) ).cell.isHighlighted )
        {
        CGColorRef cgColor = CGColorCreateGenericRGB( 1.f, 1.f, 1.f, 1.f );
        CGContextSetStrokeColorWithColor( cgContext, cgColor );
        CFRelease( cgColor );
        }

    CGContextStrokePath( cgContext );

    CFRelease( cgPath );
    }


@end
