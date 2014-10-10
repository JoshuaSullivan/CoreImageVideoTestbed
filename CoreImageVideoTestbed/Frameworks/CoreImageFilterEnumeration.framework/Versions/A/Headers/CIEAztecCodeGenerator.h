//
// CIEAztecCodeGenerator.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEAztecCodeGenerator : CIEFilterBase

@property (strong, nonatomic) NSData *inputMessage;
@property (strong, nonatomic) NSNumber *inputCorrectionLevel;
@property (strong, nonatomic) NSNumber *inputLayers;
@property (strong, nonatomic) NSNumber *inputCompactStyle;

@property (readonly, nonatomic) CGImageRef outputCGImage;

@end
