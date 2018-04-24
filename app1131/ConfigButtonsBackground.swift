//
//  ConfigButtonsBackground.swift
//  app1131
//
//  Created by camila oliveira on 11/13/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ConfigButtonsBackground: UIView {

    override func drawRect(rect: CGRect) {
        layoutIfNeeded()
        super.layoutSubviews()
        #if DEBUG
            print("camila - ConfigButtonBackground - layoutSubviews ")
        #endif
        
        setColors()
        
        self.layer.borderWidth = ViewConfig.widths.borderFrame
        
        self.addSubview(getDiv())

        setNeedsLayout()
    }
    
    func setColors (){
        self.layer.borderColor = ViewConfig.color.borderColor.dark.CGColor
        self.backgroundColor = ViewConfig.color.background.dark
    }
    func getDiv() -> UIView{
        let rect = self.frame
        let div = UIView(frame:CGRectMake(rect.width / 2, rect.height * 0.2, ViewConfig.widths.borderFrame, rect.height * 0.6))
        div.backgroundColor = UIColor(CGColor:self.layer.borderColor!)
        return div
    }


}
