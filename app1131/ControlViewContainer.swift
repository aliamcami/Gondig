//
//  ControlViewContainer.swift
//  app1131
//
//  Created by camila oliveira on 11/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ControlViewContainer: UIView {
    var parentController : PlayerStoryViewController!
    
    //comeca tocando
    var isPlaying = true //false -> hide everyThing but play button
                          //true -> hide everthing
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var timeSlider: SliderBarVideo!
    @IBOutlet weak var videoTotalTime: UILabel!
    @IBOutlet weak var playPauseButton: PlayAndPauseButton!
    @IBOutlet weak var topView: TopContainerView!
    @IBOutlet weak var bottonView: BottonContainerView!
    @IBOutlet weak var storyTitleView: StoryTitleTextField!
    
    //comeca aparecendo
    var autoHide : NSTimer?
    var isHide : Bool! {
        didSet{
            if !isHide && isPlaying{
                autoHide = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "hide", userInfo: nil, repeats: false)
            }else{
                autoHide?.invalidate()
            }
            
        }
    }
    
    override func drawRect(rect: CGRect) {
        #if DEBUG
            print("camila - ControLViewContainer - drawRect")
        #endif
        
        //garantir que comeca tocando, se eu esquecer disso depois... 
        self.isHide = false
        self.parentController.player.play()
        self.playPauseButton.parentView = self
        timeSlider.parentView = self
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.autoHide?.invalidate()
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isHide = false
    }
  
    
    func pause(){
        self.playPauseButton.pause()
        self.show()
    }
    
    
    func play(){
        self.playPauseButton.play()
       
    }
    
    
    func hide(){
        #if DEBUG
            print("camila - ControLViewContainer - hide")
        #endif
        
        isHide = true
        
        //update no titulo de video se mudar..
        changedTitle()
        
        self.storyTitleView.resignFirstResponder()
        
        if isPlaying {
            
            //animaçao para sumir
            hideThe(self, hide: true)
            
        }else{
            hideEverythingButPlayButton()
        }
    }
    
    private func hideThe(objectToBeHidden : UIView, hide : Bool){
        
        var fromValue : NSNumber!
        var toValue : NSNumber!
        
        if hide {
            fromValue = 1
            toValue = 0
        }else{
            fromValue = 0
            toValue = 1
        }
        if objectToBeHidden.alpha != toValue{
            let opacity = CABasicAnimation(keyPath: "opacity")
            opacity.duration = CFTimeInterval(0.3)
            opacity.repeatCount = 1
            opacity.autoreverses = false
            opacity.fromValue = fromValue
            opacity.toValue = toValue
            opacity.beginTime = CACurrentMediaTime()
            opacity.removedOnCompletion = true
            
            objectToBeHidden.alpha = CGFloat(toValue.floatValue)
            objectToBeHidden.layer.addAnimation(opacity, forKey: "opacity")
        }
        
       
        
    }
    
    func changedTitle(){
        self.storyTitleView.changedTitle(self.parentController.playerItem!)
    }
    
    func show(){
        #if DEBUG
            print("camila - ControLViewContainer - show")
        #endif
        isHide = false
        hideThe(self, hide: false)
        showEverythingButPlayButton()
    }
    
    
    private func hideEverythingButPlayButton(){
        #if DEBUG
            print("camila - ControLViewContainer - hide EverythingButPlayButton")
        #endif
        
        hideThe(self, hide: false)
        hideThe(topView, hide: true)
        hideThe(bottonView, hide: true)
     
    }
    private func showEverythingButPlayButton(){
        #if DEBUG
            print("camila - ControLViewContainer - show EverythingButPlayButton")
        #endif
        
        hideThe(self, hide: false)
        hideThe(topView, hide: false)
        hideThe(bottonView, hide: false)
 
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func enableChangeTitle (gesture : UIGestureRecognizer){
        if !self.storyTitleView.enabled {
            self.storyTitleView.enabled = true
            self.autoHide?.invalidate()
        }
    }
    

}
