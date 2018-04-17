//
//  MovingWithVelocityAnimation.m
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import "MovingWithVelocityAnimation.h"

@implementation MovingWithVelocityAnimation

@synthesize startTime = _startTime;
@synthesize duration = _duration;


- (instancetype)init
{
	if (self = [super init])
	{
		_duration = CGFLOAT_MAX;
	}
	
	return self;
}


- (void)exec:(NSTimeInterval)time
{
	CGPoint position = CGPointMake(_startPosition.x + _velocity.x * time, _startPosition.y + _velocity.y * time);
	if (self.callback)
	{
		self.callback(position);
	}
}

@end
