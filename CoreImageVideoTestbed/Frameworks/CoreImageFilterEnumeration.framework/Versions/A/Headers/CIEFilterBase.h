//
// CIEFilterBase.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


@import CoreImage;

@interface CIEFilterBase : CIFilter

@property (readonly, nonatomic) NSString *filterName;
@property (readonly, nonatomic) BOOL isChainable;

- (BOOL)chainFromFilter:(CIEFilterBase *)filter;

@end
