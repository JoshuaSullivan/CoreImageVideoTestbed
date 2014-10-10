//
// CIEStarShineGenerator.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEStarShineGenerator : CIEFilterBase

@property (strong, nonatomic) CIVector *inputCenter;
@property (strong, nonatomic) CIColor *inputColor;
@property (strong, nonatomic) NSNumber *inputRadius;
@property (strong, nonatomic) NSNumber *inputCrossScale;
@property (strong, nonatomic) NSNumber *inputCrossAngle;
@property (strong, nonatomic) NSNumber *inputCrossOpacity;
@property (strong, nonatomic) NSNumber *inputCrossWidth;
@property (strong, nonatomic) NSNumber *inputEpsilon;

@end
