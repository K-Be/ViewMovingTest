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
@property (nonatomic, strong) IBOutlet UISlider* timeIntervalsSlider;
@property (nonatomic, strong) IBOutlet UIView* destinationIndicatorView;
@property (nonatomic, strong) IBOutlet UISwitch* timerSwitch;
@property (nonatomic, strong) IBOutlet UISwitch* callRedrawSwitch;
@property (nonatomic, strong) UIPanGestureRecognizer* panRecognizer;
@property (nonatomic, weak) NSTimer* timer;
@property (nonatomic) CGPoint startCenter;

- (void)panRecognizerAction:(id)sender;
- (IBAction)transformSwitchAction:(id)sender;
- (IBAction)tmeIntervalChanged:(id)sender;
- (IBAction)timerSwitchValueChanged:(UISwitch*)sender;
- (IBAction)cleanPoints:(id)sender;

- (void)moveViewToRandomPosition:(NSTimer*)sender;

@end


@interface ViewController (Private)

- (void)_updateTransformation;
- (void)_scheduleTimerWithNewTime;

- (void)_setForFrameViewNewCenter:(CGPoint)center;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizerAction:)];
    [self.frameView addGestureRecognizer:_panRecognizer];
    self.view.clipsToBounds = YES;
    
    
    self.timerSwitch.on = NO;
    
    [self _updateTransformation];
    
    [self timerSwitchValueChanged:self.timerSwitch];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.frameView.layer.shouldRasterize = NO;
    
    CATransform3D transform = self.frameView.layer.transform;
    self.frameView.layer.transform = CATransform3DIdentity;
    self.frameView.frame = CGRectInset(self.view.bounds, CGRectGetWidth(self.view.bounds) / 3.0, CGRectGetHeight(self.view.bounds) / 3.0);
    self.frameView.layer.transform = transform;
    
    self.frameView.layer.rasterizationScale = 4.0;
    self.frameView.layer.shouldRasterize = YES;
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
        //CGPoint locationInView = [_panRecognizer locationInView:self.pointsView];
        //[self.pointsView addPoint:locationInView];
        //[self.pointsView setNeedsDisplay];
        
        CGPoint transition = [_panRecognizer translationInView:self.view];
        CGPoint newCenter = CGPointMake(_startCenter.x + transition.x, _startCenter.y + transition.y);
        
        [self _setForFrameViewNewCenter:newCenter];
    }
    else
    {
        
    }
}


- (IBAction)transformSwitchAction:(id)sender
{
    [self _updateTransformation];
}


- (IBAction)tmeIntervalChanged:(id)sender
{
    if (self.timerSwitch.on)
    {
        [self _scheduleTimerWithNewTime];
    }
}


- (IBAction)timerSwitchValueChanged:(UISwitch*)sender
{
    if (sender.on)
    {
        [self _scheduleTimerWithNewTime];
    }
    else
    {
        [_timer invalidate];
    }
}


- (IBAction)cleanPoints:(id)sender
{
    
}


- (void)moveViewToRandomPosition:(NSTimer*)sender
{
    CGRect viewFrame = self.frameView.frame;
    CGRect selfViewBounds = self.view.bounds;
    CGSize allowValues = CGSizeMake(CGRectGetWidth(selfViewBounds) - CGRectGetWidth(viewFrame),
                                    CGRectGetHeight(selfViewBounds) - CGRectGetHeight(viewFrame));
    CGSize value = CGSizeMake(((CGFloat)rand() / (CGFloat)RAND_MAX) * allowValues.width,
                              ((CGFloat)rand() / (CGFloat)RAND_MAX) * allowValues.height);
    CGPoint center = CGPointMake(value.width + CGRectGetWidth(viewFrame) / 2.0,
                                 value.height + CGRectGetHeight(viewFrame) / 2.0);
    [self _setForFrameViewNewCenter:center];
}

@end


#pragma mark -
@implementation ViewController (Private)

- (void)_updateTransformation
{
    self.frameView.layer.shouldRasterize = NO;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (_transformSwitch.on)
    {
        transform = CGAffineTransformRotate(CGAffineTransformMakeScale(4.0, 4.0), M_PI / 3.0);
    }
    
    self.frameView.layer.transform = CATransform3DMakeAffineTransform(transform);//transform;//transform = transform;
    
    self.frameView.layer.rasterizationScale = 4.0;
    self.frameView.layer.shouldRasterize = YES;
}


- (void)_scheduleTimerWithNewTime
{
    if (_timer)
    {
        [_timer invalidate];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeIntervalsSlider.value target:self selector:@selector(moveViewToRandomPosition:) userInfo:nil repeats:YES];
}


- (void)_setForFrameViewNewCenter:(CGPoint)center
{
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
    //    	[CATransaction setValue:@(YES) forKey:kCATransactionDisableActions];
    
    
    if ([self.callRedrawSwitch isOn])
    {
        [self.frameView.layer setNeedsDisplay];
    }
    
    _destinationIndicatorView.center = center;
    self.frameView.center = center;
    
    
//    [CATransaction commit];
}

@end
