//
// CIERadialGradient.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIERadialGradient : CIEFilterBase

@property (strong, nonatomic) CIVector *inputCenter;
@property (strong, nonatomic) NSNumber *inputRadius0;
@property (strong, nonatomic) NSNumber *inputRadius1;
@property (strong, nonatomic) CIColor *inputColor0;
@property (strong, nonatomic) CIColor *inputColor1;

@end
