//
// CIEColorPosterize.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEColorPosterize : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) NSNumber *inputLevels;

@end
