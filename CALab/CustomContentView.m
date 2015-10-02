//
//  CustomContentView.m
//  CALab
//
//  Created by Tong G. on 8/26/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import QuartzCore;
#import "CustomContentView.h"
#import "LayerHostingButton.h"

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
    [ sublayer addConstraint: [ CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX ] ];
    [ self.layer addSublayer: sublayer ];

    self->_timer = [ NSTimer timerWithTimeInterval: 1.f
                                            target: self
                                          selector: @selector( _timerFireMethod: )
                                          userInfo: @{ @"sublayer" : sublayer }
                                           repeats: NO ];

    [ [ NSRunLoop currentRunLoop ] addTimer: self->_timer forMode: NSDefaultRunLoopMode ];

    [ self _demoLayerConstraints ];
    }

- ( void ) _demoLayerConstraints
    {
    [ self.layer setLayoutManager: [ CAConstraintLayoutManager layoutManager ] ];

    CGColorRef cgBackgroundColor = [ NSColor colorWithSRGBRed: 252.f / 255 green: 216.f / 255 blue: 182.f / 255 alpha: 1.f ].CGColor;

    CALayer* layerA = [ CALayer layer ];
    layerA.name = @"layer-a";
    layerA.backgroundColor = cgBackgroundColor;
    layerA.bounds = CGRectMake( 0, 0, 200.f, 50.f );
    layerA.borderWidth = 2.f;

    [ layerA addConstraint: [ CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX ] ];
    [ layerA addConstraint: [ CAConstraint constraintWithAttribute: kCAConstraintMidY relativeTo: @"superlayer" attribute: kCAConstraintMidY ] ];

    CALayer* layerB = [ CALayer layer ];
    layerB.name = @"layer-b";
    layerB.backgroundColor = cgBackgroundColor;
    layerB.borderWidth = 2.f;

    layerB.bounds = CGRectMake( 0.f, 0.f, 200.f, 200.f );

//    [ layerB addConstraint: [ CAConstraint constraintWithAttribute: kCAConstraintMaxY relativeTo: layerA.name attribute: kCAConstraintMinY offset: -10.f ] ];
//    [ layerB addConstraint: [ CAConstraint constraintWithAttribute: kCAConstraintWidth relativeTo: layerA.name attribute: kCAConstraintWidth ] ];
//    [ layerB addConstraint: [ CAConstraint constraintWithAttribute: kCAConstraintMinY relativeTo: @"superlayer" attribute: kCAConstraintMinY offset: 10.f ] ];
//    [ layerB addConstraint: [ CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX ] ];

    [ self.layer addSublayer: layerA ];
    [ layerA addSublayer: layerB ];
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

    [ sublayer setPosition: CGPointMake( 566.f, 74.f ) ];
    [ sublayer setBackgroundColor: newColor.CGColor ];
    }

- ( IBAction ) buttonTopClickedAction: ( id )_Sender
    {
    CATransition* transitionForTop = [ CATransition animation ];
    [ transitionForTop setStartProgress: 0.f ];
    [ transitionForTop setEndProgress: 1.f ];
    [ transitionForTop setType: kCATransitionReveal ];
    [ transitionForTop setSubtype: kCATransitionFromTop ];
    [ transitionForTop setDuration: .5f ];

//    CATransition* transitionForBottom = [ CATransition animation ];
//    [ transitionForBottom setStartProgress: 0.f ];
//    [ transitionForBottom setEndProgress: 1.f ];
//    [ transitionForBottom setSubtype: kCATransitionFromRight ];
//    [ transitionForBottom setType: kCATransitionPush ];
//    [ transitionForBottom setDuration: .5f ];

    [ self.buttonTop.layer addAnimation: transitionForTop forKey: @"trasition" ];
    [ self.buttonBottom.layer addAnimation: transitionForTop forKey: @"trasition" ];

    self.buttonTop.hidden = YES;
    self.buttonBottom.hidden = NO;
    }

@end
