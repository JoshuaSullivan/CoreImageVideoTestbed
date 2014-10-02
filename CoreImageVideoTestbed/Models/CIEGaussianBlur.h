//
// CIEGaussianBlur.h
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/2/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


@import CoreImage;

@interface CIEGaussianBlur : CIFilter

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) NSNumber *inputRadius;

@end
