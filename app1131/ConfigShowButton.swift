//
//  ConfigShowButton.swift
//  app1131
//
//  Created by camila oliveira on 11/13/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ConfigShowButton: UIButton {
        var picker : GenericPicker?
    var color : ViewConfig.color? {
        didSet {
            self.setTitleColor(color!.dark, forState: UIControlState.Normal)
        }
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        backgroundColor = UIColor.clearColor()
        
        if color == nil{
            self.setTitleColor(ViewConfig.text.buttons.color, forState: UIControlState.Normal)
        }
        
        if picker != nil{
            titleLabel?.font = picker!.font
        }else{
            titleLabel?.font = GenericPicker().font
        }
        
        layoutIfNeeded()
    }

  

}
