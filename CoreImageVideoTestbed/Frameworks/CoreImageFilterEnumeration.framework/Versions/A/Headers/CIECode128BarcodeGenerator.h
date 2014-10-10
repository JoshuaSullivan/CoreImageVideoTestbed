//
// CIECode128BarcodeGenerator.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIECode128BarcodeGenerator : CIEFilterBase

@property (strong, nonatomic) NSData *inputMessage;
@property (strong, nonatomic) NSNumber *inputQuietSpace;

@property (readonly, nonatomic) CGImageRef outputCGImage;

@end
