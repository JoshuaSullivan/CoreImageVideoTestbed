//
// CIEColorCubeWithColorSpace.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEColorCubeWithColorSpace : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) NSNumber *inputCubeDimension;
@property (strong, nonatomic) NSData *inputCubeData;
@property (strong, nonatomic) NSObject *inputColorSpace;

@end
