//
// CIEFlashTransition.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEFlashTransition : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIImage *inputTargetImage;
@property (strong, nonatomic) CIVector *inputCenter;
@property (strong, nonatomic) CIVector *inputExtent;
@property (strong, nonatomic) CIColor *inputColor;
@property (strong, nonatomic) NSNumber *inputTime;
@property (strong, nonatomic) NSNumber *inputMaxStriationRadius;
@property (strong, nonatomic) NSNumber *inputStriationStrength;
@property (strong, nonatomic) NSNumber *inputStriationContrast;
@property (strong, nonatomic) NSNumber *inputFadeThreshold;

@end
