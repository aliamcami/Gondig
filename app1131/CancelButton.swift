//
//  CancelButton.swift
//  app1131
//
//  Created by camila oliveira on 12/3/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CancelButton: UIButton {
    var color : UIColor?{
        didSet{
            self.tintColor = color
            setNeedsDisplay()
        }
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.setTitle("cancel".localized, forState: UIControlState.Normal)
        self.setTitleColor(ViewConfig.color.background.dark, forState: UIControlState.Normal)
        self.setTitleShadowColor(ViewConfig.color.borderColor.light, forState: UIControlState.Normal)
        self.titleLabel?.font = ViewConfig.text.buttons.font
        
        //image
        self.setImage(UIImage(named: "Back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        
    }

}
