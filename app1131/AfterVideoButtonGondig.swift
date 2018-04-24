//
//  AfterVideoButtonShare.swift
//  app1131
//
//  Created by camila oliveira on 12/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class AfterVideoButtonGondig: AfterVideoButtonGeneric {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override var image : UIImage?{
        return UIImage(named: "ShareGondig")
    }
    override var title : String{
        return "shareGondig"
    }
    override var bgColor : UIColor{
        return ViewConfig.color.color1.light
    }
    override var dotsColor :UIColor{
        return ViewConfig.color.color1.dark
    }
    override func clickAction(gesture: UIGestureRecognizer?) {
        #if DEBUG
            print("camila - AfterVideoButtonGondig - compartilhando... ")
        #endif
        super.clickAction(gesture)
        
        if controller != nil{
            // VALIDAR SE O VIDEO NAO É DO TAMANHO VOCE DECIDE
            let b = BackEnd()
            b.uploadNewStory(self.model!, completionHandler: { uploadStatus in
                // Eu ainda nao chamo seu bloco, pq nao tenho o status do downlaod
                // Mas se quiser completa ai
            })
            
            // Mostra um alerta
        }else{
            #if DEBUG
                print("camila - AfterVideoButtonGondig - controller NIL, impossivel compartilhar... ")
            #endif
        }
    }

    
}
