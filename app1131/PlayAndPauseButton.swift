//
//  PlayPauseButton.swift
//  app1131
//
//  Created by camila oliveira on 11/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class PlayAndPauseButton: UIButton {

    private var playImg = UIImage(named: "Play")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    private var stopImg = UIImage(named: "Pause")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    var parentView : ControlViewContainer!
    
    
    override func drawRect(rect: CGRect) {
        if parentView.isPlaying {
            self.setImage(stopImg, forState: UIControlState.Normal)
        }else{
            self.setImage(playImg, forState: UIControlState.Normal)
        }
        
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        #if DEBUG
            print("camila - PlayPauseButton - touchesBegan")
        #endif
        playPause()
    }
    
    func playPause (){
        #if DEBUG
            print("camila - PlayPauseButton - PlayPause")
        #endif
        
        if parentView.isPlaying {
            pause()
        }else{
            play()
        }
    }

    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    func pause (){
        #if DEBUG
            print("camila - PlayPauseButton - pause ")
        #endif
        
//        self.setImage(self.playImg, forState: UIControlState.Normal)
        parentView.isPlaying = false
        self.parentView.parentController.player.pause()
        self.parentView.autoHide?.invalidate()
        self.setNeedsDisplay()
    }
    func play(){
        #if DEBUG
            print("camila - PlayPauseButton - play")
        #endif
//        self.setImage(self.stopImg, forState: UIControlState.Normal)
        parentView.isPlaying = true
        parentView.hide()
        if self.parentView.parentController.itemDidEnd {
            self.parentView.parentController.player.seekToTime(kCMTimeZero)
            self.parentView.parentController.itemDidEnd = false
        }
        self.parentView.parentController.player.play()
        self.setNeedsDisplay()
    }
    
}
