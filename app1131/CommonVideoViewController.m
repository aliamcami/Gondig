//
//  CommonVideoViewController.m
//  VideoEditingPart2
//
//  Created by Abdul Azeem Khan on 1/24/13.
//  Copyright (c) 2013 com.datainvent. All rights reserved.
//

#import "CommonVideoViewController.h"

@interface CommonVideoViewController ()
@property AVAsset* theAsset;
@end

@implementation CommonVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size withOverlayLayer:(CALayer*) overlayLayer
{
  // no-op - override this method in the subclass
}


#pragma mark Functionalities
  // 3.1 - Create AVMutableVideoCompositionInstruction
-(AVMutableVideoCompositionInstruction*) createAVMutableVideoCompositionInstruction{
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, self.theAsset.duration);
    return mainInstruction;
}


  //3a AUDIO TRACK
-(AVMutableCompositionTrack*) insertAudioTrackInto:(AVMutableComposition*) mixComposition {
  
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, self.theAsset.duration)
                        ofTrack:[[self.theAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                         atTime:kCMTimeZero
                          error:nil];

    return audioTrack;
}

// 3b - Video track
-(AVMutableCompositionTrack*) insertVideoTrackInto:(AVMutableComposition*)mixComposition{
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, self.theAsset.duration)
                        ofTrack:[[self.theAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];

    return videoTrack;
}

//3.2.1
    BOOL isVideoAssetPortrait_  = NO;
-(AVAssetTrack*) getAssetTrackAndFixOrientationFor:(AVAsset*) anAsset {
    AVAssetTrack *videoAssetTrack = [[anAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
//    UIImageOrientation videoAssetOrientation_  = UIImageOrientationUp;
//    BOOL isVideoAssetPortrait_  = NO;
    CGAffineTransform videoTransform = videoAssetTrack.preferredTransform;
    if (videoTransform.a == 0 && videoTransform.b == 1.0 && videoTransform.c == -1.0 && videoTransform.d == 0) {
//        videoAssetOrientation_ = UIImageOrientationRight;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 0 && videoTransform.b == -1.0 && videoTransform.c == 1.0 && videoTransform.d == 0) {
//        videoAssetOrientation_ =  UIImageOrientationLeft;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == 1.0) {
//        videoAssetOrientation_ =  UIImageOrientationUp;
    }
    if (videoTransform.a == -1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == -1.0) {
//        videoAssetOrientation_ = UIImageOrientationDown;
    }
    
    return videoAssetTrack;
}


// 3.2 - Create an AVMutableVideoCompositionLayerInstruction for the video track and fix the orientation.
-(AVMutableVideoCompositionLayerInstruction*) createAVMutableVideoCompositionLayerInstructionFor:(AVMutableCompositionTrack*) videoTrack withVideoAssetTrack:(AVAssetTrack*)videoAssetTrack {
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    
    [videolayerInstruction setTransform:videoAssetTrack.preferredTransform atTime:kCMTimeZero];
    [videolayerInstruction setOpacity:0.0 atTime:self.theAsset.duration];

    return videolayerInstruction;
}

//get natural size
-(CGSize) getNaturalSizeFor:(AVAssetTrack*)videoAssetTrack {
    CGSize naturalSize;
    if(isVideoAssetPortrait_){
        naturalSize = CGSizeMake(videoAssetTrack.naturalSize.height, videoAssetTrack.naturalSize.width);
    } else {
        naturalSize = videoAssetTrack.naturalSize;
    }
    return naturalSize;
}

-(AVMutableVideoComposition*) createAVMutableVideoCompositionForInstruction:(AVMutableVideoCompositionInstruction*) mainInstruction withSize:(CGSize) naturalSize{
    
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    float renderWidth, renderHeight;
    renderWidth = naturalSize.width;
    renderHeight = naturalSize.height;
    mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderHeight);
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    
    return mainCompositionInst;
}

- (AVAssetExportSession*)videoOutputWithAsset:(AVAsset*) anAsset andOverlayLayer:(CALayer*)overlayLayer
{
#if DEBUG
    printf("camila - Objc CommonVideoViewController - VideoOutpuWithAsset\n");
#endif
    self.theAsset = anAsset;
  // 1 - Early exit if there's no video file
  if (!self.theAsset) {
      printf("\n ERROR:  video asset not loaded");
      return  nil;
  }

  // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
  AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];

  //3a AUDIO TRACK
    [self insertAudioTrackInto:mixComposition];
    
  // 3b - Video track
    AVMutableCompositionTrack *videoTrack = [self insertVideoTrackInto:mixComposition];
    
  // 3.1 - Create AVMutableVideoCompositionInstruction
    AVMutableVideoCompositionInstruction *mainInstruction = [self createAVMutableVideoCompositionInstruction];
    
    //3.2.1 fix orientation and create asset track
    AVAssetTrack* videoAssetTrack = [self getAssetTrackAndFixOrientationFor:self.theAsset];
    
    // 3.2 - Create an AVMutableVideoCompositionLayerInstruction for the video track and fix the orientation.
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [self createAVMutableVideoCompositionLayerInstructionFor:videoTrack withVideoAssetTrack:videoAssetTrack];
    
  // 3.3 - Add instructions
  mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    //Natural Size
    CGSize naturalSize = [self getNaturalSizeFor:videoAssetTrack];

    AVMutableVideoComposition *mainCompositionInst = [self createAVMutableVideoCompositionForInstruction:mainInstruction withSize:naturalSize];
    
//    return mainCompositionInst;
    
    [self addOverlayLayer:overlayLayer ToComposition:mainCompositionInst forNaturalSize:naturalSize];
    
    AVAssetExportSession *exporter = [self exportComposition:mixComposition withInstructions:mainCompositionInst];

    
    return exporter;
}
#pragma mark ADD IMAGES TO VIDEO
-(void) addOverlayLayer: (CALayer*) overlayLayer ToComposition:(AVMutableVideoComposition*) mainCompositionInst forNaturalSize:(CGSize)naturalSize{
#if DEBUG
    printf("camila - Objc CommonVideoViewController - AddOverlayLayer\n");
#endif
      [self applyVideoEffectsToComposition:mainCompositionInst size:naturalSize withOverlayLayer:overlayLayer];
}

-(AVAssetExportSession*) exportComposition:(AVMutableComposition*) mixComposition withInstructions:(AVMutableVideoComposition*)mainCompositionInst {
#if DEBUG
    printf("camila - Objc CommonVideoViewController - ExportComposition\n");
#endif
    
//    // 4 - Get path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:@"/DeuMerda.mov"];
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];

#pragma mark export config
    // 5 - Create exporter
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetMediumQuality];
    exporter.outputURL= url;
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
    exporter.shouldOptimizeForNetworkUse = YES;
    exporter.videoComposition = mainCompositionInst;
    
    return exporter;
}



@end
