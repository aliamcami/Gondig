//
//  ContinueButton.swift
//  app1131
//
//  Created by camila oliveira on 11/3/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ContinueButton: UIButton {
    var videoModel : VideoModelShow!
    
    func continueVideo (video : VideoModelShow, controller : UIViewController){
        #if DEBUG
            print("camila - cotninueButton - SetMergeMode()")
        #endif
        controller.performSegueWithIdentifier("cameraMerge", sender: nil)
    }
    func continueFrom (controller : UIViewController){
        continueVideo(self.videoModel, controller: controller)
    }
    
    
    override func drawRect(rect: CGRect) {
        self.setImage(
            UIImage(named: "Continue")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate),
            forState: UIControlState.Normal)
        
    }
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        
        setLayout()
        
    }
    
    func setLayout(){
        self.backgroundColor = UIColor.clearColor()
        self.tintColor = ViewConfig.color.borderColor.light
    }

    
}

