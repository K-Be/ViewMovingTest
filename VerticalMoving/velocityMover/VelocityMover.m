//
//  VelocityMover.m
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import "VelocityMover.h"
#import "Animator.h"
#import "MovingWithVelocityAnimation.h"


@interface VelocityMover ()

@property (nonatomic, strong) UIPanGestureRecognizer* panRecognizer;
@property (nonatomic, strong) Animator* animator;
@property (nonatomic, strong) MovingWithVelocityAnimation* animation;

- (void)panRecognizerStateChanged:(UIPanGestureRecognizer*)sender;

@end


@interface VelocityMover (Private)

- (void)_startMovingPrediction;
- (void)_stopMovingPrediciton;

@end


@implementation VelocityMover

- (instancetype)init
{
	if (self  = [super init])
	{
		_panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizerStateChanged:)];
		_animator = [[Animator alloc] init];
	}
	
	return self;
}


- (NSArray<UIGestureRecognizer *> *)gestureRecognizers
{
	return @[_panRecognizer];
}


- (void)panRecognizerStateChanged:(UIPanGestureRecognizer*)sender
{
//	static NSDate* date = nil;
	
	if (sender.state == UIGestureRecognizerStateBegan)
	{
//		date = [NSDate date];
		[sender setTranslation:CGPointMake(0.0, self.constraint.constant) inView:sender.view];
		[self _startMovingPrediction];
	}
	else if (sender.state == UIGestureRecognizerStateChanged)
	{
	//	NSDate* currentDate = [NSDate date];
//		NSLog(@"time: %@",@([currentDate timeIntervalSinceDate:date]));
	//	date = currentDate;
		
		CGPoint translation = [sender translationInView:sender.view];
		CGFloat offset = [self adjustOffset:translation.y];
		self.constraint.constant = offset;
		[self offsetChanged];
		[self _stopMovingPrediciton];
		[self _startMovingPrediction];
	}
	else if (sender.state == UIGestureRecognizerStateEnded ||
					 sender.state == UIGestureRecognizerStateFailed ||
					 sender.state == UIGestureRecognizerStateCancelled)
	{
		[self _stopMovingPrediciton];
	}
}


- (void)dealloc
{
	[self _stopMovingPrediciton];
}

@end


#pragma mark -
@implementation VelocityMover (Private)

- (void)_startMovingPrediction
{
	NSAssert(_animation == nil, @"should call _stop before");
	
	CGPoint velocity = [self.panRecognizer velocityInView:self.panRecognizer.view];
	if (velocity.y != 0.0)
	{
		_animation = [[MovingWithVelocityAnimation alloc] init];
		_animation.startPosition = [self.panRecognizer translationInView:self.panRecognizer.view];
		_animation.duration = 0.015;
		_animation.velocity = velocity;
		__weak typeof(self) selfWeak = self;
		_animation.callback = ^(CGPoint position) {
			__strong typeof(selfWeak) selfStrong = selfWeak;
			if (selfStrong)
			{
				CGFloat offset = [selfStrong adjustOffset:position.y];
				selfStrong.constraint.constant = offset;
				[selfStrong offsetChanged];
			}
		};
		[self.animator addAnimation:_animation];
	}
}


- (void)_stopMovingPrediciton
{
	if (_animation != nil)
	{
		[self.animator breakAnimation:_animation];
		self.animation = nil;
	}
}

@end
