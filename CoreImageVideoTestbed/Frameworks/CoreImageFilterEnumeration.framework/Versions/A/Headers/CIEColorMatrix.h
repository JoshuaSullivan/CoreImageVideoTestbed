//
// CIEColorMatrix.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEColorMatrix : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputRVector;
@property (strong, nonatomic) CIVector *inputGVector;
@property (strong, nonatomic) CIVector *inputBVector;
@property (strong, nonatomic) CIVector *inputAVector;
@property (strong, nonatomic) CIVector *inputBiasVector;

@end
