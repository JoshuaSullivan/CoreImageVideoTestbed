//
// CIETemperatureAndTint.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIETemperatureAndTint : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputNeutral;
@property (strong, nonatomic) CIVector *inputTargetNeutral;

@end
