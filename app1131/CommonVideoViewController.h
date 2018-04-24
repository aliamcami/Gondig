//
//  CommonVideoViewController.h
//  VideoEditingPart2
//
//  Created by Abdul Azeem Khan on 1/24/13.
//  Copyright (c) 2013 com.datainvent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface CommonVideoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>




- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size withOverlayLayer:(CALayer*) overlayLayer;

- (AVAssetExportSession*)videoOutputWithAsset:(AVAsset*) anAsset andOverlayLayer:(CALayer*)overlayLayer;

-(void) addOverlayLayer: (CALayer*) overlayLayer ToComposition:(AVMutableVideoComposition*) mainCompositionInst forNaturalSize:(CGSize)naturalSize;

//-(AVAssetExportSession*) exportComposition:(AVMutableComposition*) mixComposition withInstructions:(AVMutableVideoComposition*)mainCompositionInst;

-(CGSize) getNaturalSizeFor:(AVAssetTrack*)videoAssetTrack;

-(AVAssetTrack*) getAssetTrackAndFixOrientationFor:(AVAsset*) anAsset;
@end
