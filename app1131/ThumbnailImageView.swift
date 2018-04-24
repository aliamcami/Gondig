//
//  ThumbnailImageView.swift
//  app1131
//
//  Created by camila oliveira on 11/6/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ThumbnailImageView: UIImageView {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        
//    }
    
    override func setNeedsDisplay() {
//        self.layer.cornerRadius = self.bounds.width * 0.2
        self.layer.borderWidth = ViewConfig.widths.borderFrame
        self.layer.borderColor = ViewConfig.color.borderColor.light.CGColor
        
    }


}


