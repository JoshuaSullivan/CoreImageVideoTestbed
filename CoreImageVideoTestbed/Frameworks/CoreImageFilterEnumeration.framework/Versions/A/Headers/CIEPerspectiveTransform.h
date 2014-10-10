//
// CIEPerspectiveTransform.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEPerspectiveTransform : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputTopLeft;
@property (strong, nonatomic) CIVector *inputTopRight;
@property (strong, nonatomic) CIVector *inputBottomRight;
@property (strong, nonatomic) CIVector *inputBottomLeft;

@end
