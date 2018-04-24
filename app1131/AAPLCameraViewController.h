/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
View controller for camera interface.
*/

@import UIKit;
#import "AAPLPreviewView.h"
#import "CommonVideoViewController.h"
#import "AddAnimationViewController.h"

@interface AAPLCameraViewController : UIViewController

- (void)changeCamera:(id)sender;
- (IBAction)toggleMovieRecording:(id)sender;
- (IBAction)focusAndExposeTap:(UIGestureRecognizer *)gestureRecognizer;
- (IBAction)resumeInterruptedSession:(id)sender;
- (void) exportSession : (AVAssetExportSession*) exporter;
//
-(BOOL) isRecording;
- (void)exportDidFinish:(AVAssetExportSession*)session;
-(void) playVideo: (NSURL*) url;
// For use in the storyboards.
@property (nonatomic, weak) IBOutlet AAPLPreviewView *previewView;
@property (nonatomic, weak) IBOutlet UILabel *cameraUnavailableLabel;
@property (nonatomic, weak) IBOutlet UIButton *resumeButton;
@property (nonatomic, weak) IBOutlet UIButton *recordButton;
@property (nonatomic, weak) IBOutlet UIButton *cameraButton;
@property (nonatomic) Boolean isFrontCamera;
@property (nonatomic) CGSize naturalSize;
@end
