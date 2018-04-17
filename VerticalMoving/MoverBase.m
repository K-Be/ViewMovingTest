//
//  MoverBase.m
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import "MoverBase.h"

@implementation MoverBase

- (NSArray<UIGestureRecognizer*>*)gestureRecognizers
{
	return @[];
}

@end


@implementation MoverBase (Protected)

- (CGFloat)adjustOffset:(CGFloat)offset
{
	return MAX(MIN(offset, self.maxTopOffset), self.minTopOffset);
}


- (void)offsetChanged
{
	NSParameterAssert(_offsetChangedCallback != nil);
	if (_offsetChangedCallback)
	{
		_offsetChangedCallback(self);
	}
}

@end

