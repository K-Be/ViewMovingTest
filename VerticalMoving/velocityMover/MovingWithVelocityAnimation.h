//
//  MovingWithVelocityAnimation.h
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Animation.h"


@interface MovingWithVelocityAnimation : NSObject <Animation>

@property (nonatomic) CGPoint startPosition;
@property (nonatomic) CGPoint velocity;
@property (nonatomic, copy) void(^callback)(CGPoint position);

@end
