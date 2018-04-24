//
//  CRCameraMerge.swift
//  app1131
//
//  Created by camila oliveira on 11/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CRCameraMerge: CRCameraControlBridge {
    var firstVideo : VideoModelShow!
    
    @IBOutlet weak var configBG: ConfigButtonsBackground!

    @IBOutlet weak var showConfigInfoWIdth: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: CancelButton!
    
    override var actualColor : ViewConfig.color{
        return firstVideo.length.color
    }
    override func viewDidLoad() {
        #if DEBUG
            //  MUDAR
            print("camila - CRCameraMerge - ViewdidLoad")
        #endif
        
        super.viewDidLoad()
        
        
        (cameraButton as! SwitchCameraButton).color = firstVideo.length.color.dark
        cancelButton.color = firstVideo.length.color.dark
//        self.circularProgressView.progressInsideFillColor = firstVideo.length.color.dark
//        self.circularProgressView.trackColor = firstVideo.length.color.dark
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        if isCompactDevice{
            showConfigInfoWIdth?.constant = self.view.frame.width * 0.6
        }else{
            showConfigInfoWIdth?.constant = self.view.frame.width * 0.4
        }
        
    }
    
    override func startAction(sender: AnyObject) {
        super.startAction(sender)
        let hide = !isRecording()
        hideConfigStuff(hide)
        
    }
    
    override func initialConfigButtonsShowPicker() {
        
        //set title information to the user
        showLenghtButton?.setTitle("\(firstVideo.length.valueDescription)", forState: UIControlState.Normal)
        showLevelButton?.setTitle("\(firstVideo.level.description)", forState: UIControlState.Normal)
        configBG.backgroundColor = firstVideo.length.color.dark
        showLevelButton.color = ViewConfig.color.background
        showLenghtButton.color = ViewConfig.color.background
        
        //cancel interaction on the buttons, they are only for information
        self.showLenghtButton?.userInteractionEnabled = false
        self.showLevelButton?.userInteractionEnabled = false
        
    }
    override func getNewInstance() -> VideoModelCamiTretas {
        return VideoModelCamiTretas(lenght: firstVideo.length, level: firstVideo.level, animationSize: VideoConfig.animationSize.medium, phrase: VideoConfig.phraseStatus.off)
    }
    override func hideConfigStuff(hide: Bool) {
        
        showLenghtButton?.hidden = hide
        showLevelButton?.hidden = hide
        configBG.hidden = hide
    }
    
    
    @IBAction func cancelMerge(sender: AnyObject) {
        #if DEBUG
            print("camila - CRCameraMerge - cancelMerge ")
        #endif
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidAppear(animated: Bool) {
        #if DEBUG
            print("camila - CRCameraMerge - viewDidAppear ")
        #endif
        
        hideConfigStuff(false)
       
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        #if DEBUG
            print("camila - CRCameraMerge - prepareForSegue - to \(segue.identifier)")
        #endif
  
        if segue.identifier == "confirmVideo"{
            let conf = segue.destinationViewController as! AfterConfirmVideoController
            conf.tretas = self.storyModel
            conf.saveClass = MergeSave(firstVideo: firstVideo, controller: self)
        }
    }
    

    
}
