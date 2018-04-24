//
//  CloseButton.swift
//  app1131
//
//  Created by camila oliveira on 10/30/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class DeleteButton: UIButton {
    
    var cell : CRCollectionCell!
    var color : UIColor?{
        didSet{
            self.tintColor = self.color
            self.setNeedsDisplay()
        }
    }

    func setImgs(){
        let img = UIImage(named: "TrashBG")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.setImage(img, forState: UIControlState.Normal)
        
        let bg = UIImageView(image: UIImage(named: "TrashBorder")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        bg.contentMode = UIViewContentMode.ScaleAspectFit
        self.layer.insertSublayer(bg.layer, atIndex: 0)
        self.layer.masksToBounds = true

    }
    

}

