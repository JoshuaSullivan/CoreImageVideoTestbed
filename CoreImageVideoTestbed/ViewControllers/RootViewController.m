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

@import GLKit;
@import AVFoundation;

@interface RootViewController () <AVCaptureVideoDataOutputSampleBufferDelegate, GLKViewDelegate>

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) EAGLContext *eaglContext;
@property (strong, nonatomic) CIContext *ciContext;
@property (strong, nonatomic) GLKView *glkView;
@property (weak, nonatomic) IBOutlet StatView *statView;
@property (assign, nonatomic) BOOL isRunning;

@property (strong, nonatomic) CIFilter *filter;
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

#pragma mark - Core Image Setup

- (void)setupCoreImage
{
    NSDictionary *ciOptions = @{
            kCIContextWorkingColorSpace : [NSNull null]
    };
    self.ciContext = [CIContext contextWithEAGLContext:self.eaglContext options:ciOptions];

    self.filter = [CIFilter filterWithName:@"CIColorCube"];
    UIImage *cubeImage = [UIImage imageNamed:@"maximumContrastBW64"];
    CFTimeInterval startTime = CACurrentMediaTime();
    NSData *cubeData = [NRDColorCubeHelper createColorCubeDataForImage:cubeImage
                                                         cubeDimension:64];
    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"Data creation took %0.2fms.", (endTime - startTime) * 1000.0);
    [self.filter setValue:cubeData forKey:@"inputCubeData"];
    [self.filter setValue:@64 forKey:@"inputCubeDimension"];

    self.gaussianBlur = [CIEGaussianBlur new];
    self.gaussianBlur.inputRadius = @8.0f;
    NSLog(@"%@", self.gaussianBlur);
}

#pragma mark - AVCaptureSession Setup

- (void)setupCaptureSession
{
    self.captureSession = [AVCaptureSession new];
    [self.captureSession beginConfiguration];
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    }

    // Capture device
    AVCaptureDevice *captureDevice;

    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == AVCaptureDevicePositionFront) {
            captureDevice = device;
            break;
        }
    }
    if (!captureDevice) {
        NSLog(@"Error! Couldn't find camera.");
        return;
    }

    // Device input
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if ([self.captureSession canAddInput:deviceInput]) {
        [self.captureSession addInput:deviceInput];
    }

    // Image capture for light detection
    AVCaptureVideoDataOutput *videoDataOutput = [AVCaptureVideoDataOutput new];
    videoDataOutput.videoSettings = @{(id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)};
    [videoDataOutput setSampleBufferDelegate:self
                                       queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [self.captureSession addOutput:videoDataOutput];

    [self.captureSession commitConfiguration];
}

- (CIImage *)addFilterStackToImage:(CIImage *)image
{
    [self.filter setValue:image forKey:kCIInputImageKey];
    self.gaussianBlur.inputImage = self.filter.outputImage;
    return self.gaussianBlur.outputImage;
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    if (!self.isRunning) {
        return;
    }
    CGRect frame = self.view.bounds;
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *videoFrame = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    CGAffineTransform rotation = CGAffineTransformMakeRotation((CGFloat)-M_PI_2);
    videoFrame = [videoFrame imageByApplyingTransform:rotation];
    CGRect videoExtent = [videoFrame extent];
    videoFrame = [self addFilterStackToImage:videoFrame];
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(2.0f, 2.0f);
    frame = CGRectApplyAffineTransform(frame, scaleTransform);
    CFTimeInterval startTime = CACurrentMediaTime();
    [self.ciContext drawImage:videoFrame inRect:frame fromRect:videoExtent];
    CFTimeInterval completionTime = (CACurrentMediaTime() - startTime) * 1000.0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.statView addTiming:completionTime];
    });
    [self.glkView display];
}

#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
}


#pragma mark - IBActions

- (IBAction)unwindToRootViewController:(UIStoryboardSegue *)segue
{

}

@end

