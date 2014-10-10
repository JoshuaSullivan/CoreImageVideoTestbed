//
// CIEHistogramDisplayFilter.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEHistogramDisplayFilter : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) NSNumber *inputHeight;
@property (strong, nonatomic) NSNumber *inputHighLimit;
@property (strong, nonatomic) NSNumber *inputLowLimit;

@end
