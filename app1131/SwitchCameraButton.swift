//
//  SwitchCameraButton.swift
//  app1131
//
//  Created by camila oliveira on 11/6/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class SwitchCameraButton: UIButton {
    var color : UIColor?{
        didSet{
            self.setNeedsDisplay()
        }
    }
    func setForBackCamera(){
        #if DEBUG
            print("camila - SwitchCameraButton - BACK")
        #endif
    }
    func setForFrontCamera(){
        #if DEBUG
            print("camila - SwitchCameraButton - FRONT")
        #endif
    }
    
    override func drawRect(rect: CGRect) {
        self.setImage(UIImage(named: "CameraBG")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        
        let iv = UIImageView(image: UIImage(named: "CameraBorder"))
        self.layer.insertSublayer(iv.layer, atIndex: 0)

    }

    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        if color == nil{
            self.tintColor = VideoConfig.userLength.color.light
        }else{
            self.tintColor = self.color
        }
        
    }
    

    

}

