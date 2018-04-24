//
//  CGBTRegister.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CGBTRegister: UIButton {
    override func drawRect(rect: CGRect) {
        
        self.setTitleColor(ViewConfig.text.buttons.color, forState: UIControlState.Normal)
        self.titleLabel?.font = ViewConfig.text.time.font
    }
    
    override func setNeedsDisplay() {
        
        super.setNeedsDisplay()
        self.backgroundColor = ViewConfig.color.color1.dark
        self.layer.borderColor = ViewConfig.color.borderColor.dark.CGColor
        self.layer.borderWidth = ViewConfig.widths.borderFrame
        self.layer.masksToBounds = true
        
        layoutIfNeeded()
    }
    override var enabled : Bool{
        didSet{
            if !enabled{
                self.alpha = 0.5
            }else{
                self.alpha = 1
            }
        }
    }

}
