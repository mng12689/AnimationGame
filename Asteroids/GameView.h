//
//  GameView.h
//  Asteroids
//
//  Created by Michael Ng on 8/23/12.
//  Copyright (c) 2012 Michael Ng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HealthIndicator;
@class Asteroid;

@interface GameView : UIView

@property (strong) NSMutableArray *asteroids;
@property (strong) HealthIndicator *healthIndicator;
-(BOOL)shouldDelete:(Asteroid*)asteroid AtLocation:(CGPoint)location;
@end
