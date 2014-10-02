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
    // Set up some variables for calculating memory size.
    CGSize imageSize = image.size;
    size_t dim = (size_t)imageSize.width;
    size_t pixels = dim * dim;
    size_t channels = 4;

    // If the number of pixels doesn't match what's needed for the supplied cube dimension, abort.
    if (pixels != cubeDimension * cubeDimension * cubeDimension) {
        NSAssert(NO, @"ERROR: This image is the wrong size for a cube dimension of %lu.", cubeDimension);
        return nil;
    }

    // We don't need a sizeof() because uint_8t is explicitly 1 byte.
    size_t memSize = pixels * channels;

    // Get the UIImage's backing CGImageRef
    CGImageRef img = image.CGImage;

    // Get a reference to the CGImage's data provider.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);

    // Copy the data and get a pointer.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);

    // Get a pointer to the copied data.
    const void *inBuffer = CFDataGetBytePtr(inBitmapData);

    // Calculate the size of the float buffer and allocate it.
    size_t floatSize = pixels * channels * sizeof(float);
    float *finalBuffer = malloc(floatSize);

    // Convert the uint_8t to float. Note: a uint of 255 will convert to 255.0f.
    vDSP_vfltu8(inBuffer, 1, finalBuffer, 1, memSize);

    // Divide each float by 255.0 to get the 0-1 range we are looking for.
    float divisor = 255.0f;
    vDSP_vsdiv(finalBuffer, 1, &divisor, finalBuffer, 1, memSize);

    // Don't copy the bytes, just have the NSData take ownership of the buffer.
    NSData *cubeData = [NSData dataWithBytesNoCopy:finalBuffer
                                            length:floatSize
                                      freeWhenDone:YES];

    // Release the copy of the bitmap data we created above.
    CFRelease(inBitmapData);

    return cubeData;

}
@end
