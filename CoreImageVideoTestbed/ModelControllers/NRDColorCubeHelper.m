//
// Created by Joshua Sullivan on 9/22/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.
//

@import Accelerate;
#import "NRDColorCubeHelper.h"

@interface NRDColorCubeHelper ()

@end

@implementation NRDColorCubeHelper


+ (NSData *)createColorCubeDataForImage:(UIImage *)image cubeDimension:(size_t)cubeDimension
{
    CGSize imageSize = image.size;
    size_t dim = (size_t)imageSize.width;
    size_t pixels = dim * dim;
    if (pixels != cubeDimension * cubeDimension * cubeDimension) {
        NSAssert(NO, @"ERROR: This image is the wrong size for a cube dimension of %lu.", cubeDimension);
        return nil;
    }
    size_t channels = 4;
    size_t componentSize = sizeof(uint8_t);
    size_t bytesPerRow = dim * channels * componentSize;
    size_t memSize = bytesPerRow * dim;
    uint8_t *imageBytes = malloc(memSize);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGContextRef bitmapContext = CGBitmapContextCreate(imageBytes, dim, dim, componentSize * 8, bytesPerRow, colorSpace, bitmapInfo);
    CGContextDrawImage(bitmapContext, CGRectMake(0.0f, 0.0f, dim, dim), image.CGImage);
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);

    size_t floatSize = memSize * sizeof(float);
    float *floatBuffer = malloc(floatSize);
    float *finalBuffer = malloc(floatSize);
    float divisor = 255.0f;

    vDSP_vfltu8(imageBytes, 1, floatBuffer, 1, memSize);
    vDSP_vsdiv(floatBuffer, 1, &divisor, finalBuffer, 1, memSize);

    free(imageBytes);
    free(floatBuffer);

    NSData *cubeData = [NSData dataWithBytesNoCopy:finalBuffer
                                            length:floatSize
                                      freeWhenDone:YES];

    return cubeData;

}
@end
