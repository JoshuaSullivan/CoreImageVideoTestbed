//
// CIEGaussianBlur.m
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/2/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEGaussianBlur.h"

@implementation CIEGaussianBlur

- (instancetype)init
{
    self = [CIFilter filterWithName:@"CIGaussianBlur"];
    return self;
}

@end
