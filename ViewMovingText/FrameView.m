//
//  FrameView.m
//  ViewMovingText
//
//  Created by Andrew Romanov on 20.08.14.
//  Copyright (c) 2014 Andrew Romanov. All rights reserved.
//

#import "FrameView.h"


@interface FrameView ()

@property (nonatomic, strong) UIColor* borderColor;
@property (nonatomic, strong) UIImageView* imageView;

@end



@implementation FrameView

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		_borderColor = [UIColor redColor];
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeRedraw;
		
		_imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 13.0, 13.0)];
		_imageView.backgroundColor = [UIColor clearColor];
		_imageView.userInteractionEnabled = NO;
		_imageView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
		_imageView.contentMode = UIViewContentModeScaleAspectFill;
		_imageView.image = [UIImage imageNamed:@"background.jpg"];
		_imageView.clipsToBounds = YES;
		[self addSubview:_imageView];
	}
	
	return self;
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
	return [NSNull null];
}


@end
