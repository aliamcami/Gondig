//
//  ShareButton.swift
//  app1131
//
//  Created by camila oliveira on 10/30/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ShareButton: UIButton, UIDocumentInteractionControllerDelegate {
    var controller : UIViewController?
    
    func share(videoModel : VideoModelShow) {
        #if DEBUG
            print("camila - ShareButton - share")
        #endif
        
        let interaction = UIDocumentInteractionController(URL: videoModel.videoUrl!)
        interaction.UTI = "public.movie"
        interaction.delegate = self
        if controller != nil{
            if interaction.presentOpenInMenuFromRect(CGRectZero, inView: controller!.view, animated: true){
                #if DEBUG
                    print("camila - ShareButton - share - concluido")
                #endif
            }
        }else{
            #if DEBUG
                print("camila - ShareButton - CONTROLLER NIL, impossivel compartilhar")
            #endif
        }
        
    }
    override func drawRect(rect: CGRect) {
        self.setImage(
            UIImage(named: "ShareSmall")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate),
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

