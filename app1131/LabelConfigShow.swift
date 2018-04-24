//
//  LabelConfigShow.swift
//  app1131
//
//  Created by camila oliveira on 12/2/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class LabelConfigShow: UILabel {
    var sizeTitle : CGFloat!

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        layoutIfNeeded()
        sizeTitle = rect.height * 0.013
        setFont()

        setNeedsDisplay()
    }
    override func setNeedsDisplay() {
        self.backgroundColor = ViewConfig.color.background.dark
        self.textColor = ViewConfig.color.borderColor.dark
        
    }
    func setFont (){
        self.textColor = ViewConfig.color.borderColor.dark
        self.font = UIFont.systemFontOfSize(sizeTitle, weight: UIFontWeightRegular)
    }


}
