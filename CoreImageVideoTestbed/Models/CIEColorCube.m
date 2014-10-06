//
// CIEColorCube.m
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/3/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEColorCube.h"

@implementation CIEColorCube

- (instancetype)init
{
    self = (CIEColorCube *)[CIFilter filterWithName:@"CIColorCube"];
    return self;
}

@end
