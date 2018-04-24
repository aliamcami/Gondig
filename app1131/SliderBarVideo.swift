//
//  SliderBarVideo.swift
//  app1131
//
//  Created by camila oliveira on 11/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class SliderBarVideo: UISlider {

    var parentController : PlayerStoryViewController!
    var parentView : ControlViewContainer!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        parentController.controlView.isPlaying ? parentController.player.play() : parentController.player.pause()
        parentView.isHide = false
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        parentController.player.pause()
        parentView.autoHide?.invalidate()
    }

}

