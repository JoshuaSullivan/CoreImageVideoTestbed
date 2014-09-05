//
//  StatView.h
//  CoreImageVideoTestbed
//
//  Created by Joshua Sullivan on 9/4/14.
//  Copyright (c) 2014 Joshua Sullivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatView : UIView

- (void)addTiming:(NSTimeInterval)timing;
- (void)resetStats;

@end
