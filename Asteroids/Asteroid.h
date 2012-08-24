//
//  Asteroid.h
//  Asteroids
//
//  Created by Michael Ng on 8/23/12.
//  Copyright (c) 2012 Michael Ng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Asteroid : NSObject

@property (strong) CALayer *layer;
-(Asteroid*)initWithView:(UIView*)view;

@end
