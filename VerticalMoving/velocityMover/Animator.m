//
//  Animator.m
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import "Animator.h"
@import QuartzCore;


@interface Animator ()

@property (nonatomic, strong) NSMutableArray<id<Animation> >* animations;
@property (nonatomic, strong) CADisplayLink* displayLink;

- (void)displayLinkAction:(id)sender;

@end



@implementation Animator


- (instancetype)init
{
	if (self = [super init])
	{
		_animations = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	return self;
}


- (void)addAnimation:(id<Animation>)animation
{
	[_animations addObject:animation];
	if (!_displayLink)
	{
		_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
		[_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	}
	
	animation.startTime = [[NSDate date] timeIntervalSince1970];
}


- (void)breakAnimation:(id<Animation>)animation
{
	[_animations removeObject:animation];
	if (_animations.count == 0)
	{
		if (_displayLink)
		{
			[_displayLink invalidate];
			_displayLink = nil;
		}
	}
}

#pragma mark Actions
- (void)displayLinkAction:(id)sender
{
	
	NSMutableArray* animationsToRemovig = [[NSMutableArray alloc] initWithCapacity:1];
	
	NSTimeInterval timeStamp =  [[NSDate date] timeIntervalSince1970];
	[_animations enumerateObjectsUsingBlock:^(id<Animation>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		CGFloat completedDuration = (timeStamp - obj.startTime);
		[obj exec:completedDuration];
		
		if (completedDuration >= obj.duration)
		{
			[animationsToRemovig addObject:obj];
		}
	}];
	
	if (animationsToRemovig > 0)
	{
		[_animations removeObjectsInArray:animationsToRemovig];
	}
}


- (void)dealloc
{
	if (_displayLink)
	{
		[_displayLink invalidate];
		_displayLink = nil;
	}
}

@end
