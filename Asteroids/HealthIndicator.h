//
//  HealthIndicator.h
//  Asteroids
//
//  Created by Michael Ng on 8/23/12.
//  Copyright (c) 2012 Michael Ng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthIndicator : NSObject
@property (strong) CALayer* layer;
-(HealthIndicator*)initWithView:(UIView*)view;
-(void)pulsate;
@end
