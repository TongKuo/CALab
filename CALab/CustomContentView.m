//
//  CustomContentView.m
//  CALab
//
//  Created by Tong G. on 8/26/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import QuartzCore;
#import "CustomContentView.h"

@implementation CustomContentView

- ( void ) awakeFromNib
    {
    [ self setWantsLayer: YES ];

    CALayer* sublayer = [ CALayer layer ];
    [ sublayer setBounds: NSMakeRect( 80, 80, 50, 60 ) ];
    [ sublayer setAnchorPoint: NSMakePoint( 0, 0 ) ];
    [ sublayer setBackgroundColor: [ NSColor orangeColor ].CGColor ];

    [ sublayer setDelegate: self ];
    [ self.layer addSublayer: sublayer ];

    [ NSTimer scheduledTimerWithTimeInterval: 1.f
                                      target: self
                                    selector: @selector( _timerFireMethod: )
                                    userInfo: @{ @"sublayer" : sublayer }
                                     repeats: NO ];
    }

- ( void ) _timerFireMethod: ( NSTimer* )_Timer
    {
    CALayer* sublayer = _Timer.userInfo[ @"sublayer" ];

    CABasicAnimation* positionAnim = [ CABasicAnimation animationWithKeyPath: @"position" ];
//    CGPoint oldPosition = CGPointMake( sublayer.position.x, sublayer.position.y );
//    CGPoint newPosition = CGPointMake( sublayer.position.x + 300, sublayer.position.y );
//    [ positionAnim setFromValue: [ NSValue valueWithBytes: &oldPosition objCType: @encode( CGPoint ) ] ];
//    [ positionAnim setFromValue: [ NSValue valueWithBytes: &newPosition objCType: @encode( CGPoint ) ] ];
//    [ positionAnim setFromValue: [ NSColor whiteColor ] ];
//    [ positionAnim setToValue: [ NSColor blackColor ] ];
    [ positionAnim setDuration: 4.f ];
    [ sublayer addAnimation: positionAnim forKey: @"position" ];

    CABasicAnimation* gradientAnim = [ CABasicAnimation animationWithKeyPath: @"backgroundColor" ];
    NSColor* oldColor = [ NSColor orangeColor ];
    NSColor* newColor = [ NSColor greenColor ];
    [ gradientAnim setFromValue: oldColor ];
    [ gradientAnim setToValue: newColor ];
    [ gradientAnim setDuration: 4.f ];
    [ sublayer addAnimation: gradientAnim forKey: @"backgroundColor" ];

    [ sublayer setPosition: CGPointMake( sublayer.position.x + 300, sublayer.position.y + 300 ) ];
    [ sublayer setBackgroundColor: newColor.CGColor ];
    }

@end
