//
// CIEColorPolynomial.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEColorPolynomial : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputRedCoefficients;
@property (strong, nonatomic) CIVector *inputGreenCoefficients;
@property (strong, nonatomic) CIVector *inputBlueCoefficients;
@property (strong, nonatomic) CIVector *inputAlphaCoefficients;

@end
