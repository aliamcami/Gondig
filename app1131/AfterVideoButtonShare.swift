//
//  CameraRollSave.swift
//  app1131
//
//  Created by camila oliveira on 11/17/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class AfterVideoButtonShare: AfterVideoButtonGeneric {
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
//        backgroundColor = UIColor.clearColor()
//        setTitleColor(VideoConfig.Color.Branco.uiColor, forState: UIControlState.Normal)
//    }
    
    override var image : UIImage?{
        return UIImage(named: "Share")
    }
    override var title : String{
        return "share"
    }
    override var bgColor : UIColor{
        return ViewConfig.color.color4.dark
    }
    override var dotsColor :UIColor{
        return ViewConfig.color.color4.light
    }
    
    
    override func clickAction(gesture: UIGestureRecognizer?) {
        #if DEBUG
            print("camila - AfterVideoShare - compartilhando... ")
        #endif
        super.clickAction(gesture)
        
        if controller != nil{
            let bb = ShareButton()
            bb.controller = self.controller
            bb.share(self.model!)
        }else{
            #if DEBUG
                print("camila - AfterVideoShare - controller NIL, impossivel compartilhar... ")
            #endif
        }
    }
    
    


}
