//
//  AfterVideoButtonSaveCamera.swift
//  app1131
//
//  Created by camila oliveira on 12/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class AfterVideoButtonSaveCamera: AfterVideoButtonGeneric {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func clickAction(gesture: UIGestureRecognizer?) {
        //garantindo que nesse ponto o video ja foi renderizado... 
        //como só habilito os botoes depois da renderizaçao, ta d boa
        super.clickAction(gesture)
        let name = (self.controller as! AfterConfirmVideoController).tretas?.name
        if name != nil{
            ({VideoManager().saveVideoToCameraRoll(name!)})~>({self.showConfirmAlert()})
            
        }
        
    }
    func showConfirmAlert(){
            let alert = UIAlertController(title: "confirm_videoSavedOn_CameraRoll".localized, message: "", preferredStyle: UIAlertControllerStyle.Alert)
            let confirm = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(confirm)
            self.controller?.presentViewController(alert, animated: true, completion: nil)

    }
    override var image : UIImage?{
        return UIImage(named: "SaveRoll")
    }
    override var title : String{
        return "saveRoll"
    }
    override var bgColor : UIColor{
        return ViewConfig.color.color2.dark
    }
    override var dotsColor :UIColor{
        return ViewConfig.color.color2.light
    }
   
}
