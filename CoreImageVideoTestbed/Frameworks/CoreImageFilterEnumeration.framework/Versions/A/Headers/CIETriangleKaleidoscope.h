//
// CIETriangleKaleidoscope.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIETriangleKaleidoscope : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputPoint;
@property (strong, nonatomic) NSNumber *inputSize;
@property (strong, nonatomic) NSNumber *inputRotation;
@property (strong, nonatomic) NSNumber *inputDecay;

@end
