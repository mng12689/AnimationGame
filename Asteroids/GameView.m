//
//  GameView.m
//  Asteroids
//
//  Created by Michael Ng on 8/23/12.
//  Copyright (c) 2012 Michael Ng. All rights reserved.
//

#import "GameView.h"
#import "Asteroid.h"
#import "HealthIndicator.h"
#import <QuartzCore/QuartzCore.h>

@interface GameView ()

@property (strong) NSTimer *timer;

@end

@implementation GameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.asteroids = [NSMutableArray new];
        [self generateHealthIndicator];
        
        for (int i = 0; i < 2; i++) {
            [self.asteroids addObject:[[Asteroid alloc]initWithView:self]];
        }
        
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(generateAsteroid)
                                       userInfo:nil
                                        repeats:YES];
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    
    Asteroid *asteroidForDeletion = nil;
    for (Asteroid* asteroid in self.asteroids) {
        if ([self shouldDelete:asteroid AtLocation:touchLocation]) {
            [asteroid.layer removeFromSuperlayer];
            asteroidForDeletion = asteroid;
            break;
        }
    }
    if(asteroidForDeletion){
        [self.asteroids removeObject:asteroidForDeletion];
    }
    
}

-(BOOL)shouldDelete:(Asteroid*)asteroid AtLocation:(CGPoint)location {
    return CGRectContainsPoint(asteroid.layer.frame, location);
}

-(void)generateAsteroid
{
    if ([self.asteroids count] < 5)
        [self.asteroids addObject:[[Asteroid alloc]initWithView:self]];
}

-(void)generateHealthIndicator
{
    self.healthIndicator = [[HealthIndicator alloc]initWithView:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
