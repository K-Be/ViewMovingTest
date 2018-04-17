//
//  Animator.h
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animation.h"


NS_ASSUME_NONNULL_BEGIN

@interface Animator : NSObject

- (void)addAnimation:(id<Animation>)animation;
- (void)breakAnimation:(id<Animation>)animation;

@end

NS_ASSUME_NONNULL_END
