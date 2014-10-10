//
// CIEToneCurve.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEToneCurve : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputPoint0;
@property (strong, nonatomic) CIVector *inputPoint1;
@property (strong, nonatomic) CIVector *inputPoint2;
@property (strong, nonatomic) CIVector *inputPoint3;
@property (strong, nonatomic) CIVector *inputPoint4;

@end
