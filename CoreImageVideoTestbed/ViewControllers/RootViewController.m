//
//  RootViewController.m
//  CoreImageVideoTestbed
//
//  Created by Joshua Sullivan on 8/24/14.
//  Copyright (c) 2014 Josh Sullivan. All rights reserved.
//

#import "RootViewController.h"
#import "StatView.h"
#import "NRDColorCubeHelper.h"
#import "CIEGaussianBlur.h"
#import "CIEColorCube.h"

@import GLKit;
@import AVFoundation;

@interface RootViewController () <AVCaptureVideoDataOutputSampleBufferDelegate, GLKViewDelegate>

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) EAGLContext *eaglContext;
@property (strong, nonatomic) CIContext *ciContext;
@property (strong, nonatomic) GLKView *glkView;
@property (weak, nonatomic) IBOutlet StatView *statView;
@property (assign, nonatomic) BOOL isRunning;

@property (strong, nonatomic) CIEColorCube *colorCubeFilter;
@property (strong, nonatomic) CIEGaussianBlur *gaussianBlur;

@property (weak, nonatomic) IBOutlet UIButton *configButton;

@end

@implementation RootViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [self setupCoreImage];
    [self setupCaptureSession];

    self.glkView = [[GLKView alloc] initWithFrame:self.view.bounds context:self.eaglContext];
    self.glkView.backgroundColor = [UIColor redColor];
//    self.glkView.delegate = self;
    [self.view insertSubview:self.glkView belowSubview:self.configButton];
    [self.captureSession performSelector:@selector(startRunning) withObject:nil afterDelay:0.25];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isRunning = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.isRunning = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set up the colorCubeFilter stack on the video frame

- (CIImage *)addFilterStackToImage:(CIImage *)image
{
    // Set the raw frame as the color cube's input.
    self.colorCubeFilter.inputImage = image;
    self.gaussianBlur.inputImage = self.colorCubeFilter.outputImage;
    return self.gaussianBlur.outputImage;
}

#pragma mark - Core Image Setup

- (void)setupCoreImage
{
    // We don't need color management where we're going.
    NSDictionary *ciOptions = @{
            kCIContextWorkingColorSpace : [NSNull null]
    };

    // Create a CIContext backed by OpenGL for MAXIMUM FASTNESS!
    self.ciContext = [CIContext contextWithEAGLContext:self.eaglContext options:ciOptions];

    // Set up a CIColorCube colorCubeFilter.
    self.colorCubeFilter = [CIEColorCube new];

    // Pick a cube image to work with. Remember to update the cubeDimension if you're not using a 64-step image.
    UIImage *cubeImage = [UIImage imageNamed:@"maximumContrastBW64"];
    CFTimeInterval startTime = CACurrentMediaTime();

    // Create the NSData for the color cube colorCubeFilter.
    NSData *cubeData = [NRDColorCubeHelper createColorCubeDataForImage:cubeImage
                                                         cubeDimension:64];
    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"Data creation took %0.2fms.", (endTime - startTime) * 1000.0);

    // Set the data we generated above on the colorCubeFilter.
    self.colorCubeFilter.inputCubeData = cubeData;

    // Make sure this matches the "cubeDimension" property from above.
    self.colorCubeFilter.inputCubeDimension = @64;

    // A gaussian blur that demonstrates my idea of making enumerations for the Core Image filters so that properties can be type-checked.
    self.gaussianBlur = [CIEGaussianBlur new];
    self.gaussianBlur.inputRadius = @8.0f;
}

#pragma mark - AVCaptureSession Setup

- (void)setupCaptureSession
{
    // Create the session and begin configuration.
    self.captureSession = [AVCaptureSession new];
    [self.captureSession beginConfiguration];

    // Use high quality where available. This is the highest quality the camera supports, but varies by model.
    // iPhone 4/4S use 640x480, iPhone 5 and later use 1280x720.
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    }

    // Capture device
    AVCaptureDevice *captureDevice;

    // Find the front-facing camera.
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == AVCaptureDevicePositionFront) {
            captureDevice = device;
            break;
        }
    }

    // If we couldn't find the front-facing camera, this is a wash.
    if (!captureDevice) {
        NSLog(@"Error! Couldn't find camera.");
        return;
    }

    // Assign the capture device to the session.
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if ([self.captureSession canAddInput:deviceInput]) {
        [self.captureSession addInput:deviceInput];
    }

    // Image capture CORE IMAGE EXCITEMENT
    AVCaptureVideoDataOutput *videoDataOutput = [AVCaptureVideoDataOutput new];

    // Keep the native pixel format YUV420BiPlanar.
    videoDataOutput.videoSettings = nil;

    // Set the delegate callback. DON'T USE THE MAIN QUEUE or you shall reap naught but woe and misery and a blocked UI.
    [videoDataOutput setSampleBufferDelegate:self
                                       queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [self.captureSession addOutput:videoDataOutput];

    // All done!
    [self.captureSession commitConfiguration];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    // If this view has been hidden, stop doing anything with the captured video frames.
    if (!self.isRunning) {
        return;
    }
    CGRect frame = self.view.bounds;

    // Get the pixel buffer from the sample buffer.
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);

    // Create a CIImage from the pixel buffer.
    CIImage *videoFrame = [CIImage imageWithCVPixelBuffer:pixelBuffer];

    // Rotate the frame so it matches the screen orientation.
    CGAffineTransform rotation = CGAffineTransformMakeRotation((CGFloat)-M_PI_2);
    videoFrame = [videoFrame imageByApplyingTransform:rotation];

    // Store the video frame's size prior to applying filters to it as some filters can give the image an infinite extent.
    CGRect videoExtent = [videoFrame extent];

    // Add the filter stack to the frame image.
    videoFrame = [self addFilterStackToImage:videoFrame];

    // Double the size of the frame or the retina conversion causes it to be half size.
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(2.0f, 2.0f);
    frame = CGRectApplyAffineTransform(frame, scaleTransform);

    // Take a time reading prior to drawing.
    CFTimeInterval startTime = CACurrentMediaTime();

    // Draw the video frame with all of the filters applied while keeping everything on the GPU.
    [self.ciContext drawImage:videoFrame inRect:frame fromRect:videoExtent];

    // Determine how long it took to draw.
    CFTimeInterval completionTime = (CACurrentMediaTime() - startTime) * 1000.0;

    // Tell the GLKView that points to the same memory space as the CIContext that it should redraw now.
    [self.glkView display];

    // Jump back to the main thread and add the timing to our stat view.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.statView addTiming:completionTime];
    });
}

#pragma mark - GLKViewDelegate

/** This is currently unused. */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
}


#pragma mark - IBActions

/** Placeholder for future functionality. */
- (IBAction)unwindToRootViewController:(UIStoryboardSegue *)segue
{

}

@end

