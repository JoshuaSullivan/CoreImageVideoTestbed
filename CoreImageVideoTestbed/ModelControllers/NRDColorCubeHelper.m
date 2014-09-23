//
// Created by Joshua Sullivan on 9/22/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.
//

#import "NRDColorCubeHelper.h"

@interface NRDColorCubeHelper ()

@end

@implementation NRDColorCubeHelper


+ (NSData *)createColorCubeDataForImage:(UIImage *)image cubeDimension:(size_t)cubeDimension
{
    CGSize imageSize = image.size;
    size_t dim = (size_t)imageSize.width;
    if (dim * dim != cubeDimension * cubeDimension * cubeDimension) {
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
    size_t pixelCount = dim * dim;
    size_t cubeDimensionSquared = cubeDimension * cubeDimension;
    size_t gridSize = (size_t)sqrt(cubeDimension);
    size_t i, x, y, z, gridOffsetX, gridOffsetY, index, offset;

    for (i = 0; i < pixelCount; i++) {
        x = i % cubeDimension;
        y = (i / cubeDimension) % cubeDimension;
        z = i / cubeDimensionSquared;
        gridOffsetX = z % gridSize;
        gridOffsetY = z / gridSize;
        index = (gridOffsetX * cubeDimension) + (gridOffsetY * cubeDimension * dim) + (y * dim) + x;
        index *= channels;
        offset = i * channels;
//        NSLog(@"x: %lu, y: %lu, z:%lu, index:%lu, offset:%lu", x, y, z, index, offset);
        floatBuffer[offset + 0] = (float)imageBytes[index + 0] / 255.0f;
        floatBuffer[offset + 1] = (float)imageBytes[index + 1] / 255.0f;
        floatBuffer[offset + 2] = (float)imageBytes[index + 2] / 255.0f;
        floatBuffer[offset + 3] = (float)imageBytes[index + 3] / 255.0f;
    }
    free(imageBytes);

    NSData *cubeData = [NSData dataWithBytesNoCopy:floatBuffer
                                            length:floatSize
                                      freeWhenDone:YES];

    return cubeData;

}
@end
