//
//  AddAnimationViewController.h
//  VideoEditingPart2
//
//  Created by Abdul Azeem Khan on 1/24/13.
//  Copyright (c) 2013 com.datainvent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonVideoViewController.h"

@interface AddAnimationViewController : CommonVideoViewController


- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size withOverlayLayer:(CALayer*) overlayLayer;

@end
