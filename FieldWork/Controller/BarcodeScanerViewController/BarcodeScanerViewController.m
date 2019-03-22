//
//  BarcodeScanerViewController.m
//  FieldWork
//
//  Created by Alexander on 07.09.17.
//
//

#import "BarcodeScanerViewController.h"
#import <ZXingObjC/ZXingObjC.h>
#import "ActivityIndicator.h"
#import <AVFoundation/AVFoundation.h>

@interface BarcodeScanerViewController () <ZXCaptureDelegate>
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIButton *buttonTourch;
@property (strong, nonatomic) ZXCapture *capture;

@end

@implementation BarcodeScanerViewController {
    CGAffineTransform _captureSizeTransform;
}

- (instancetype)initWithCompletion:(void (^)(NSString * barcode))completion {
    if ([super init]) {
        self.completion = completion;
    }
    return nil;
}

- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.buttonTourch.hidden = !([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn]);
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    [self.cameraView.layer addSublayer:self.capture.layer];
    
    
    [self requestCameraPermissionsIfNeeded];
}

- (void)viewDidLayoutSubviews {
    [self applyOrientation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.capture.delegate = self;
    [self applyOrientation];
}

#pragma mark - Notifications

- (void)deviceOrientationDidChange:(NSNotification *)notification {
        [self applyOrientation];
}


#pragma mark - Private
- (void)applyOrientation {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    float scanRectRotation;
    float captureRotation;
    
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            captureRotation = 0;
            scanRectRotation = 90;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            captureRotation = 90;
            scanRectRotation = 180;
            break;
        case UIInterfaceOrientationLandscapeRight:
            captureRotation = 270;
            scanRectRotation = 0;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            captureRotation = 180;
            scanRectRotation = 270;
            break;
        default:
            captureRotation = 0;
            scanRectRotation = 90;
            break;
    }
    [self applyRectOfInterest:orientation];
    CGAffineTransform transform = CGAffineTransformMakeRotation((CGFloat) (captureRotation / 180 * M_PI));
    [self.capture setTransform:transform];
    [self.capture setRotation:scanRectRotation];
    self.capture.layer.frame = self.cameraView.frame;
}

- (void)applyRectOfInterest:(UIInterfaceOrientation)orientation {
    CGFloat scaleVideo, scaleVideoX, scaleVideoY;
    CGFloat videoSizeX, videoSizeY;
    CGRect transformedVideoRect = self.cameraView.frame;
    if([self.capture.sessionPreset isEqualToString:AVCaptureSessionPreset1920x1080]) {
        videoSizeX = 1080;
        videoSizeY = 1920;
    } else {
        videoSizeX = 720;
        videoSizeY = 1280;
    }
    if(UIInterfaceOrientationIsPortrait(orientation)) {
        scaleVideoX = self.cameraView.frame.size.width / videoSizeX;
        scaleVideoY = self.cameraView.frame.size.height / videoSizeY;
        scaleVideo = MAX(scaleVideoX, scaleVideoY);
        if(scaleVideoX > scaleVideoY) {
            transformedVideoRect.origin.y += (scaleVideo * videoSizeY - self.cameraView.frame.size.height) / 2;
        } else {
            transformedVideoRect.origin.x += (scaleVideo * videoSizeX - self.cameraView.frame.size.width) / 2;
        }
    } else {
        scaleVideoX = self.cameraView.frame.size.width / videoSizeY;
        scaleVideoY = self.cameraView.frame.size.height / videoSizeX;
        scaleVideo = MAX(scaleVideoX, scaleVideoY);
        if(scaleVideoX > scaleVideoY) {
            transformedVideoRect.origin.y += (scaleVideo * videoSizeX - self.cameraView.frame.size.height) / 2;
        } else {
            transformedVideoRect.origin.x += (scaleVideo * videoSizeY - self.cameraView.frame.size.width) / 2;
        }
    }
    _captureSizeTransform = CGAffineTransformMakeScale(1/scaleVideo, 1/scaleVideo);
    self.capture.scanRect = CGRectApplyAffineTransform(transformedVideoRect, _captureSizeTransform);
}

- (void)requestCameraPermissionsIfNeeded {
    // check camera authorization status
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized: { // camera authorized
            // do camera intensive stuff
        }
            break;
        case AVAuthorizationStatusNotDetermined: { // request authorization
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if(granted) {
                        // do camera intensive stuff
                    } else {
                        [self notifyUserOfCameraAccessDenial];
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self notifyUserOfCameraAccessDenial];
            });
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)showError:(NSString *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Barcode error", @"")
                                                                   message:error
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionSettings = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", @"")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         NSURL *settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                         if ([[UIApplication sharedApplication] canOpenURL:settingsUrl]) {
                                                             [[UIApplication sharedApplication] openURL:settingsUrl];
                                                         }
                                                     }];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                     }];
    [alert addAction:actionOk];
    [alert addAction:actionSettings];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)notifyUserOfCameraAccessDenial {
    NSString *message = NSLocalizedString(@"This app does not have permission to use the camera.", @"");
    [self showError:message];
}

- (void)playBeep
{
    NSString *path = [NSString
                      stringWithFormat:@"%@%@",
                      [[NSBundle mainBundle] resourcePath],
                      @"/barcodeBeep.wav"];
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - IBActions
- (IBAction)onButtonTourchTap:(UIButton *)sender {
    AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    BOOL success = [flashLight lockForConfiguration:nil];
    if (success)
    {
        if ([flashLight isTorchActive]) {
            [flashLight setTorchMode:AVCaptureTorchModeOff];
        } else {
            [flashLight setTorchMode:AVCaptureTorchModeOn];
        }
        [flashLight unlockForConfiguration];
    }
}

- (IBAction)onButtonCancelTap:(UIButton *)sender {
    self.capture.delegate = nil;
    [self.capture stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ZXCaptureDelegate Methods
- (void)captureCameraIsReady:(ZXCapture *)capture  {
//    NSLog(@"camera is ready");
}

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;
    /*
    CGAffineTransform inverse = CGAffineTransformInvert(_captureSizeTransform);
    NSMutableArray *points = [[NSMutableArray alloc] init];
    NSString *location = @"";
    for (ZXResultPoint *resultPoint in result.resultPoints) {
        CGPoint cgPoint = CGPointMake(resultPoint.x, resultPoint.y);
        CGPoint transformedPoint = CGPointApplyAffineTransform(cgPoint, inverse);
        transformedPoint = [self.cameraView convertPoint:transformedPoint toView:self.cameraView.window];
        NSValue* windowPointValue = [NSValue valueWithCGPoint:transformedPoint];
        location = [NSString stringWithFormat:@"%@ (%f, %f)", location, transformedPoint.x, transformedPoint.y];
        [points addObject:windowPointValue];
    }
    */
    self.capture.delegate = nil;
    [self.capture stop];
    [self playBeep];
    [self.delegate barcodeScanerViewControllerDidScan:result.text];
    if (self.completion) {
        self.completion(result.text);
    }
    
}

@end
