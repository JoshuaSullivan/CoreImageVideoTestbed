//
// CIEColorControls.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEColorControls : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) NSNumber *inputSaturation;
@property (strong, nonatomic) NSNumber *inputBrightness;
@property (strong, nonatomic) NSNumber *inputContrast;

@end
