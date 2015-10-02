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
        {
        self->_greenColor = [ NSColor greenColor ];
        self->_orangeColor = [ NSColor orangeColor ];

        self->_hostView = _HostView;

        [ self setBounds: self.bounds ];
        [ self setPosition: CGPointMake( NSMinX( self.frame ), NSMinY( self.frame ) ) ];
        [ self setBackgroundColor: [ NSColor orangeColor ].CGColor ];

        CABasicAnimation* posAnim = [ CABasicAnimation animationWithKeyPath: @"position" ];
        [ posAnim setDuration: 1.f ];

        CABasicAnimation* bgColorAnim  = [ CABasicAnimation animationWithKeyPath: @"backgroundColor" ];
        [ bgColorAnim setFromValue: ( __bridge id )( self.backgroundColor ) ];
        [ bgColorAnim setDuration: 1.f ];

        [ self setActions: @{ @"position" : posAnim, @"backgroundColor" : bgColorAnim } ];
        }

    return self;
    }

- ( void ) drawInContext: ( nonnull CGContextRef )_cgCtx
    {
    NSLog( @">>> Layer: %@", NSStringFromPoint( self.position ) );

    CGContextRef cgContext = _cgCtx;
    CGMutablePathRef cgPath = CGPathCreateMutable();

    CGPathAddRect( cgPath, NULL, self.bounds );
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
