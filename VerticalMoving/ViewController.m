//
//  ViewController.m
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import "ViewController.h"

#import "RegularMover.h"
#import "VelocityMover.h"


@interface ViewController ()

@property (nonatomic, strong) IBOutlet NSLayoutConstraint* topDistance;
@property (nonatomic, strong) IBOutlet UIView* movingView;
@property (nonatomic, strong) IBOutlet UISegmentedControl* typeOfMovingSegmentedControl;

@property (nonatomic, strong) MoverBase* mover;

- (IBAction)typeOfMovingChangedAction:(id)sender;

@end


@interface ViewController (Private)

- (void)_updateMover;
- (void)_updateMoverThresholdsWithViewSize:(CGSize)size;

@end


@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self _updateMover];
}


- (void)viewSafeAreaInsetsDidChange
{
	[super viewSafeAreaInsetsDidChange];
	
	[self _updateMoverThresholdsWithViewSize:self.view.bounds.size];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	[self _updateMoverThresholdsWithViewSize:size];
}



#pragma mark Action
- (IBAction)typeOfMovingChangedAction:(id)sender
{
	[self _updateMover];
}


@end


#pragma mark -
@implementation ViewController (Private)

#define MOVER_INDEX_REGULAR (0)
#define MOVER_INDEX_VELOCITY (1)

- (void)_updateMover
{
	if (_mover)
	{
		[_mover.gestureRecognizers enumerateObjectsUsingBlock:^(UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			[self.view removeGestureRecognizer:obj];
		}];
	}
	
	if (self.typeOfMovingSegmentedControl.selectedSegmentIndex == MOVER_INDEX_REGULAR)
	{
		_mover = [[RegularMover alloc] init];
	}
	else if (self.typeOfMovingSegmentedControl.selectedSegmentIndex == MOVER_INDEX_VELOCITY)
	{
		_mover = [[VelocityMover alloc] init];
	}
	
	[_mover.gestureRecognizers enumerateObjectsUsingBlock:^(UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[self.view addGestureRecognizer:obj];
	}];
	
	_mover.constraint = self.topDistance;
	[self _updateMoverThresholdsWithViewSize:self.view.bounds.size];
	
	__weak typeof(self) selfWeak = self;
	_mover.offsetChangedCallback = ^(MoverBase *sender) {
		__strong typeof(selfWeak) selfStrong = selfWeak;
		if (selfStrong)
		{
			[selfStrong.view setNeedsLayout];
		}
	};
}


- (void)_updateMoverThresholdsWithViewSize:(CGSize)size
{
	_mover.minTopOffset = 0.0;
	_mover.maxTopOffset = size.height - CGRectGetHeight(self.movingView.frame) - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom;
}

@end
