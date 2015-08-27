//
//  CustomContentView.m
//  CALab
//
//  Created by Tong G. on 8/26/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import QuartzCore;
#import "CustomContentView.h"
#import "CustomButton.h"

@implementation CustomContentView

- ( IBAction ) stopExplicitAnimAction: ( id )_Sender
    {
    for ( CALayer* _Layer in self.layer.sublayers )
        [ _Layer removeAnimationForKey: @"animations" ];

    [ _Sender animate ];
    }

- ( void ) awakeFromNib
    {
    [ self setWantsLayer: YES ];

    CALayer* sublayer = [ CALayer layer ];
    [ sublayer setBounds: NSMakeRect( 0, 0, 50, 60 ) ];
    [ sublayer setAnchorPoint: NSMakePoint( 0, 0 ) ];
    [ sublayer setBackgroundColor: [ NSColor orangeColor ].CGColor ];
    [ sublayer setPosition: CGPointMake( 74.f, 74.f ) ];

    [ sublayer setDelegate: self ];
    [ self.layer addSublayer: sublayer ];

    self->_timer = [ NSTimer timerWithTimeInterval: 1.f
                                            target: self
                                          selector: @selector( _timerFireMethod: )
                                          userInfo: @{ @"sublayer" : sublayer }
                                           repeats: NO ];

//    [ self->_timer fire ];
    [ [ NSRunLoop currentRunLoop ] addTimer: self->_timer forMode: NSDefaultRunLoopMode ];
    }

- ( void ) _timerFireMethod: ( NSTimer* )_Timer
    {
    CALayer* sublayer = _Timer.userInfo[ @"sublayer" ];

//    CABasicAnimation* positionAnim = [ CABasicAnimation animationWithKeyPath: @"position" ];
////    CGPoint oldPosition = CGPointMake( sublayer.position.x, sublayer.position.y );
////    CGPoint newPosition = CGPointMake( sublayer.position.x + 300, sublayer.position.y );
////    [ positionAnim setFromValue: [ NSValue valueWithBytes: &oldPosition objCType: @encode( CGPoint ) ] ];
////    [ positionAnim setFromValue: [ NSValue valueWithBytes: &newPosition objCType: @encode( CGPoint ) ] ];
////    [ positionAnim setFromValue: [ NSColor whiteColor ] ];
////    [ positionAnim setToValue: [ NSColor blackColor ] ];
//    [ positionAnim setDuration: 4.f ];
//    [ sublayer addAnimation: positionAnim forKey: @"position" ];

    CAKeyframeAnimation* keyframeAnim = [ CAKeyframeAnimation animationWithKeyPath: @"position" ];
#if 0 // Set up keyframe animation by specifying the values/keyTimes
    CGFloat sublayerHeight = NSHeight( sublayer.bounds );
    CGFloat sublayerWidth = NSWidth( sublayer.bounds );
    CGPoint pos0 = CGPointMake( NSMinX( self.bounds ), NSMinY( self.bounds ) );
    CGPoint pos1 = CGPointMake( NSMinX( self.bounds ), NSMaxY( self.bounds ) - sublayerHeight );
    CGPoint pos2 = CGPointMake( NSMaxX( self.bounds ) - sublayerWidth, NSMaxY( self.bounds ) - sublayerHeight );
    CGPoint pos3 = CGPointMake( NSMaxX( self.bounds ) - sublayerWidth, NSMinY( self.bounds ) );
    [ keyframeAnim setValues: @[ [ NSValue valueWithBytes: &pos0 objCType: @encode( CGPoint ) ]
                               , [ NSValue valueWithBytes: &pos1 objCType: @encode( CGPoint ) ]
                               , [ NSValue valueWithBytes: &pos2 objCType: @encode( CGPoint ) ]
                               , [ NSValue valueWithBytes: &pos3 objCType: @encode( CGPoint ) ]
                               , [ NSValue valueWithBytes: &pos0 objCType: @encode( CGPoint ) ]
                               ] ];

    [ keyframeAnim setKeyTimes: @[ @( 0.1 ), @( 0.3 ), @( 0.4 ), @( 0.5 ), @( 1.0 ) ] ];

#endif

#if 1 // Set up keyframe animation by specifying the bezier path
    CGMutablePathRef cgPath = CGPathCreateMutable();
    CGPathMoveToPoint( cgPath, NULL, 74.f, 74.f );

    CGPathAddCurveToPoint( cgPath, NULL
                         , 74.f, 500.f
                         , 320.f, 500.f
                         , 320.f, 74.f
                         );

    CGPathAddCurveToPoint( cgPath, NULL
                         , 320.f, 500.f
                         , 566.f, 500.f
                         , 566.f, 74.f
                         );

//    CGContextRef cgCurrentContext = [ NSGraphicsContext currentContext ].graphicsPort;
//    CGContextSetStrokeColorWithColor( cgCurrentContext, [ NSColor redColor ].CGColor );
//    CGContextSetLineWidth( cgCurrentContext, 5.f );
//    CGContextAddPath( cgCurrentContext, cgPath );
//    CGContextDrawPath( cgCurrentContext, kCGPathStroke );

    keyframeAnim.path = cgPath;
    [ keyframeAnim setKeyTimes: @[ @( 0.1 ), @( 0.3 ), @( 0.4 ), @( 0.5 ), @( 1.0 ) ] ];

    CFRelease( cgPath );
#endif
    [ keyframeAnim setDuration: 6.f ];

    CABasicAnimation* gradientAnim = [ CABasicAnimation animationWithKeyPath: @"backgroundColor" ];
    NSColor* oldColor = [ NSColor orangeColor ];
    NSColor* newColor = [ NSColor greenColor ];
    [ gradientAnim setFromValue: oldColor ];
    [ gradientAnim setToValue: newColor ];
    [ gradientAnim setDuration: 6.f ];

    CAAnimationGroup* animationGroup = [ CAAnimationGroup animation ];
    [ animationGroup setAnimations: @[ keyframeAnim, gradientAnim ] ];
    [ animationGroup setDuration: 6.f ];
    [ sublayer addAnimation: animationGroup forKey: @"animations" ];
//    [ sublayer addAnimation: keyframeAnim forKey: @"position" ];
//    [ sublayer addAnimation: gradientAnim forKey: @"backgroundColor" ];

    [ sublayer setPosition: CGPointMake( 566.f, 74.f ) ];
    [ sublayer setBackgroundColor: newColor.CGColor ];
    }

@end
