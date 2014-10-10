//
// CIELinearGradient.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIELinearGradient : CIEFilterBase

@property (strong, nonatomic) CIVector *inputPoint0;
@property (strong, nonatomic) CIVector *inputPoint1;
@property (strong, nonatomic) CIColor *inputColor0;
@property (strong, nonatomic) CIColor *inputColor1;

@end
