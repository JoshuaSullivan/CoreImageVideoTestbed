//
// CIEBarsSwipeTransition.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEBarsSwipeTransition : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIImage *inputTargetImage;
@property (strong, nonatomic) NSNumber *inputAngle;
@property (strong, nonatomic) NSNumber *inputWidth;
@property (strong, nonatomic) NSNumber *inputBarOffset;
@property (strong, nonatomic) NSNumber *inputTime;

@end
