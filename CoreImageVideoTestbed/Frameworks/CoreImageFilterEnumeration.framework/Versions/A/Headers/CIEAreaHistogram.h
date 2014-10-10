//
// CIEAreaHistogram.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEAreaHistogram : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputExtent;
@property (strong, nonatomic) NSNumber *inputScale;
@property (strong, nonatomic) NSNumber *inputCount;

@property (readonly, nonatomic) NSData * outputData;

@end
