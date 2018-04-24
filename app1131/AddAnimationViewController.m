//
//  AddAnimationViewController.m
//  VideoEditingPart2
//
//  Created by Abdul Azeem Khan on 1/24/13.
//  Copyright (c) 2013 com.datainvent. All rights reserved.
//

#import "AddAnimationViewController.h"

@interface AddAnimationViewController ()

@end

@implementation AddAnimationViewController
- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size withOverlayLayer:(CALayer*) overlayLayer
{
#if DEBUG
    printf("camila - Objc AddAnimationVIewController - applyVideoEffectsToComposition");
#endif
  // 5
  CALayer *parentLayer = [CALayer layer];
  CALayer *videoLayer = [CALayer layer];
  parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
  videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
  [parentLayer addSublayer:videoLayer];

//CALAYER to add
    [parentLayer addSublayer:overlayLayer];
  composition.animationTool = [AVVideoCompositionCoreAnimationTool
                               videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
}

@end
