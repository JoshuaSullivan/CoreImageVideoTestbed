//
// CIEDisintegrateWithMaskTransition.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEDisintegrateWithMaskTransition : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIImage *inputTargetImage;
@property (strong, nonatomic) CIImage *inputMaskImage;
@property (strong, nonatomic) NSNumber *inputTime;
@property (strong, nonatomic) NSNumber *inputShadowRadius;
@property (strong, nonatomic) NSNumber *inputShadowDensity;
@property (strong, nonatomic) CIVector *inputShadowOffset;

@end
