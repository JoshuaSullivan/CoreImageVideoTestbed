//
// CIEDotScreen.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEDotScreen : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputCenter;
@property (strong, nonatomic) NSNumber *inputAngle;
@property (strong, nonatomic) NSNumber *inputWidth;
@property (strong, nonatomic) NSNumber *inputSharpness;

@end
