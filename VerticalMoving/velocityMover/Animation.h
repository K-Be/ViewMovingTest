//
//  Animation.h
//  ViewTranslation
//
//  Created by Andrew Romanov on 12/04/2018.
//  Copyright © 2018 Andrew Romanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Animation <NSObject>

@property (nonatomic) NSTimeInterval startTime;

- (void)exec:(NSTimeInterval)time;

@end
