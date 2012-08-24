//
//  Asteroid.m
//  Asteroids
//
//  Created by Michael Ng on 8/23/12.
//  Copyright (c) 2012 Michael Ng. All rights reserved.
//

#import "Asteroid.h"
#import <QuartzCore/QuartzCore.h>

@interface Asteroid () 

-(CGPoint)randomPositionForAsteroidInView:(UIView*)view;
-(void)moveInView:(UIView*)view;
-(void)pulsate;

@end

@implementation Asteroid

-(Asteroid*)initWithView:(UIView*)view
{
    self = [super init];
    if(self){
        self.layer = [[CALayer alloc]init];
        self.layer.bounds = CGRectMake(0.0, 0.0, 60.0, 60.0);

        self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        self.layer.shadowColor = [[UIColor yellowColor]CGColor];
        self.layer.shadowRadius = 20.0;
        self.layer.shadowOpacity = 1.0;
        
        self.layer.delegate = self;
        self.layer.position = [self randomPositionForAsteroidInView:view];
        [self pulsate];
        [self moveInView:view];
        [self.layer setNeedsDisplay];
        [view.layer addSublayer:self.layer];
    }
    
    return self;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, layer.bounds.size.width-4, layer.bounds.size.height-4));
    CGContextSetFillColorWithColor(ctx, [[UIColor greenColor]CGColor]);
    CGContextFillEllipseInRect(ctx, layer.bounds);
}

-(CGPoint)randomPositionForAsteroidInView:(UIView*)view
{
    return CGPointMake((double)arc4random() / UINT_MAX *view.bounds.size.width, (double)arc4random() / UINT_MAX * view.bounds.size.height);
}

-(void)moveInView:(UIView*)view
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:(double)(arc4random()%5 +.5)];
    [CATransaction setCompletionBlock:^{[self moveInView:view];}];
    self.layer.position = [self randomPositionForAsteroidInView:view];
    [CATransaction commit];
}

-(void)pulsate
{
    CAKeyframeAnimation *pulse = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

    pulse.removedOnCompletion = NO;
    pulse.delegate = self;
    CATransform3D grow = CATransform3DMakeScale(1.3, 1.3, 1.3);
    //CATransform3D shrink = CATransform3DMakeScale(.5, .5, .5);
    
    [pulse setValues:[NSArray arrayWithObjects:
                          [NSValue valueWithCATransform3D:CATransform3DIdentity],
                          [NSValue valueWithCATransform3D:grow],
                          [NSValue valueWithCATransform3D:CATransform3DIdentity],
                          nil]];
    pulse.duration = 1.0;
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:pulse forKey:@"pulseAnimation"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self pulsate];
}

@end
