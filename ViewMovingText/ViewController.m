//
//  ViewController.m
//  ViewMovingText
//
//  Created by Andrew Romanov on 20.08.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "ViewController.h"
#import "FrameView.h"


@interface ViewController ()

@property (nonatomic, strong) IBOutlet FrameView* frameView;
@property (nonatomic, strong) IBOutlet UIImageView* backgroundImageView;
@property (nonatomic, strong) IBOutlet UISwitch* transformSwitch;
@property (nonatomic, strong) UIPanGestureRecognizer* panRecognizer;
@property (nonatomic) CGPoint startCenter;

- (void)panRecognizerAction:(id)sender;
- (IBAction)transformSwitchAction:(id)sender;

@end


@interface ViewController (Private)

- (void)_updateTransformation;

@end


@implementation ViewController
            
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizerAction:)];
	[self.frameView addGestureRecognizer:_panRecognizer];
	
	[self _updateTransformation];
	
}


- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	CGAffineTransform transform = self.frameView.transform;
	self.frameView.transform = CGAffineTransformIdentity;
	self.frameView.frame = CGRectInset(self.view.bounds, CGRectGetWidth(self.view.bounds) / 3.0, CGRectGetHeight(self.view.bounds) / 3.0);
	self.frameView.transform = transform;
}


#pragma mark Actions
- (void)panRecognizerAction:(id)sender
{
	if (_panRecognizer.state == UIGestureRecognizerStateBegan)
	{
		_startCenter = _frameView.center;
	}
	else if (_panRecognizer.state == UIGestureRecognizerStateChanged)
	{
		CGPoint transition = [_panRecognizer translationInView:self.view];
		CGPoint newCenter = CGPointMake(_startCenter.x + transition.x, _startCenter.y + transition.y);
		self.frameView.center = newCenter;
	}
	else
	{
		
	}
}


- (IBAction)transformSwitchAction:(id)sender
{
	[self _updateTransformation];
}

@end


#pragma mark -
@implementation ViewController (Private)

- (void)_updateTransformation
{
	CGAffineTransform transform = CGAffineTransformIdentity;
	if (_transformSwitch.on)
	{
		transform = CGAffineTransformRotate(CGAffineTransformMakeScale(2.0, 2.0), M_PI / 3.0);
	}
	
	self.frameView.transform = transform;
}

@end
