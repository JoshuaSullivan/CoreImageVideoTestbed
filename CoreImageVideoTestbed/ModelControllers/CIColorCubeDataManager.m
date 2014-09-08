//
// Created by Joshua Sullivan on 9/6/14.
// Copyright (c) 2014 The Nerdery. All rights reserved.
//

#import "CIColorCubeDataManager.h"

@interface CIColorCubeDataManager ()

@end

@implementation CIColorCubeDataManager

- (UIImage *)createReferenceImage
{
    CFTimeInterval startTime = CACurrentMediaTime();
    size_t cubeSize = 64U;
    size_t sizeRoot = (size_t)sqrt(cubeSize);
    size_t memSize = cubeSize * cubeSize * cubeSize * 4 * sizeof(uint8_t);
    size_t dim = cubeSize * sizeRoot;
    uint8_t *bytes = malloc(memSize);
    CGFloat colorStep = 255.0f / (cubeSize - 1);
    size_t offset = 0;
    for (size_t j = 0; j < dim; j++) {
        for (size_t i = 0; i < dim; i++) {
            bytes[offset] = (uint8_t)roundf((i % cubeSize) * colorStep);
            bytes[offset + 1] = (uint8_t)roundf((j % cubeSize) * colorStep);
            bytes[offset + 2] = (uint8_t)roundf((i / cubeSize + (j / cubeSize) * sizeRoot) * colorStep);
            bytes[offset + 3] = 255;
            offset += 4;
        }
    }

    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, bytes, memSize, NULL);
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = dim * 4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(dim, dim, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, bitmapInfo, dataProvider, NULL, NO, renderingIntent);
    UIImage *cubeImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(dataProvider);
    free(bytes);

    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"Generation took %0.2fms.", (endTime - startTime) * 1000.0);

    return cubeImage;
}

- (NSData *)createColorCubeDataFromImage:(UIImage *)image
{
    CFTimeInterval startTime = CACurrentMediaTime();
    size_t dim = 512;
    size_t pixelCount = dim * dim;
    size_t channels = 4;
    size_t bytesPerRow = dim * channels;
    size_t memSize = bytesPerRow * dim;
    uint8_t *imageBytes = malloc(memSize);
    CGImageRef imageRef = image.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGContextRef bitmapContext = CGBitmapContextCreate(imageBytes, dim, dim, 8, bytesPerRow, colorSpace, bitmapInfo);
    CGContextDrawImage(bitmapContext, CGRectMake(0.0f, 0.0f, dim, dim), imageRef);
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    size_t floatSize = sizeof(float);
    size_t cubeMemSize = memSize * floatSize;
    size_t offset = 0;
    float *cubeBytes = malloc(cubeMemSize);
    for (size_t i = 0; i < pixelCount; i++) {
        cubeBytes[offset + 0] = (float)imageBytes[offset + 0] / 255.0f;
        cubeBytes[offset + 1] = (float)imageBytes[offset + 1] / 255.0f;
        cubeBytes[offset + 2] = (float)imageBytes[offset + 2] / 255.0f;
        cubeBytes[offset + 3] = (float)imageBytes[offset + 3] / 255.0f;
        offset += 4;
    }
    free(imageBytes);
    NSData *cubeData = [NSData dataWithBytesNoCopy:cubeBytes
                                            length:cubeMemSize
                                      freeWhenDone:YES];
    return cubeData;
}


@end