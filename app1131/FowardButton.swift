//
//  FowardButton.swift
//  app1131
//
//  Created by camila oliveira on 12/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class FowardButton: UIButton {

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
        self.setImage(UIImage(named: "Foward")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
    }

}
