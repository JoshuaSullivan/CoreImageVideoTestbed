//
// CIEQRCodeGenerator.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEQRCodeGenerator : CIEFilterBase

@property (strong, nonatomic) NSData *inputMessage;
@property (strong, nonatomic) NSString *inputCorrectionLevel;

@property (readonly, nonatomic) CGImageRef outputCGImage;

@end
