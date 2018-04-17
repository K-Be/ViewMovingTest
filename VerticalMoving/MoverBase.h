//
//  MoverBase.h
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MoverBase : NSObject

@property (nonatomic, copy) void(^offsetChangedCallback)(MoverBase* sender);
@property (nonatomic, strong) NSLayoutConstraint* constraint;
@property (nonatomic) CGFloat minTopOffset;
@property (nonatomic) CGFloat maxTopOffset;

- (NSArray<UIGestureRecognizer*>*)gestureRecognizers;

@end


@interface MoverBase (Protected)

- (CGFloat)adjustOffset:(CGFloat)offset;
- (void)offsetChanged;

@end
