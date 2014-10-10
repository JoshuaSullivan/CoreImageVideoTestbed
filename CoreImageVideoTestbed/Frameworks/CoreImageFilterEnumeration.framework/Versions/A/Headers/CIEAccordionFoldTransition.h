//
// CIEAccordionFoldTransition.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEAccordionFoldTransition : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIImage *inputTargetImage;
@property (strong, nonatomic) NSNumber *inputBottomHeight;
@property (strong, nonatomic) NSNumber *inputNumberOfFolds;
@property (strong, nonatomic) NSNumber *inputFoldShadowAmount;
@property (strong, nonatomic) NSNumber *inputTime;

@end
