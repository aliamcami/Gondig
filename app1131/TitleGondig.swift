//
//  TitleGondig.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class TitleGondig: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func setNeedsLayout() {
        self.text = "gondig".localized
        self.font = ViewConfig.text.gondig.font
        self.textColor = ViewConfig.text.gondig.color
        
    }

}
