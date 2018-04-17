//
//  RegularMover.m
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import "RegularMover.h"

@interface RegularMover ()

@property (nonatomic, strong) UIPanGestureRecognizer* panRecognizer;

- (void)panRecognizerStateChanged:(UIPanGestureRecognizer*)sender;

@end


@implementation RegularMover

- (instancetype)init
{
	if (self  = [super init])
	{
		_panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizerStateChanged:)];
	}
	
	return self;
}


- (NSArray<UIGestureRecognizer *> *)gestureRecognizers
{
	return @[_panRecognizer];
}


- (void)panRecognizerStateChanged:(UIPanGestureRecognizer*)sender
{
	if (sender.state == UIGestureRecognizerStateBegan)
	{
		[sender setTranslation:CGPointMake(0.0, self.constraint.constant) inView:sender.view];
	}
	else if (sender.state == UIGestureRecognizerStateChanged)
	{
		CGPoint translation = [sender translationInView:sender.view];
		CGFloat offset = [self adjustOffset:translation.y];
		self.constraint.constant = offset;
		[self offsetChanged];
	}
}

@end
