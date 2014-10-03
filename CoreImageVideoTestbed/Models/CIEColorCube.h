//
// CIEColorCube.h
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/3/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


@import CoreImage;

@interface CIEColorCube : CIFilter

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) NSNumber *inputCubeDimension;
@property (strong, nonatomic) NSData *inputCubeData;

@end
