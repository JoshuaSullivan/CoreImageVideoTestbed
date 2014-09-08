//
// Created by Joshua Sullivan on 9/6/14.
// Copyright (c) 2014 The Nerdery. All rights reserved.
//

@import UIKit;

@interface CIColorCubeDataManager : NSObject

- (UIImage *)createReferenceImage;
- (NSData *)createColorCubeDataFromImage:(UIImage *)image;

@end