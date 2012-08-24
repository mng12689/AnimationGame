//
//  HealthIndicator.m
//  Asteroids
//
//  Created by Michael Ng on 8/23/12.
//  Copyright (c) 2012 Michael Ng. All rights reserved.
//

#import "HealthIndicator.h"
#import <QuartzCore/QuartzCore.h>

@implementation HealthIndicator

-(HealthIndicator*)initWithView:(UIView*)view{
    self = [super init];
    if (self) {
        self.layer = [CALayer new];
        self.layer.bounds = CGRectMake(0, 0, self.layer.superlayer.bounds.size.width, self.layer.superlayer.bounds.size.height);
        self.layer.backgroundColor = [[UIColor redColor]CGColor];
        self.layer.opacity = 0;
        [self pulsate];
        self.layer.zPosition = 100;
        [view.layer addSublayer:self.layer];
    }
    return self;
}

-(void)pulsate {
    
    CAKeyframeAnimation *pulse = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    pulse.removedOnCompletion = NO;
    pulse.delegate = self;

    [pulse setValues:@[@0,@1,@0]];
    pulse.duration = 1.0;
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.layer addAnimation:pulse forKey:@"pulseBackground"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self pulsate];
}

@end
