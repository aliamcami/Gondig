//
//  BGBarControllerAfterVideoView.swift
//  app1131
//
//  Created by camila oliveira on 11/17/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class BGBarControllerAfterVideoView: UIView {
    @IBOutlet var fowardButton : FowardButton!
    @IBOutlet var trashButton : UIButton!
    var color : ViewConfig.color {
        return ViewConfig.color.color3
    }
    override func setNeedsLayout() {
        self.backgroundColor =  color.light
        fowardButton.color = ViewConfig.color.borderColor.dark
    }
    override func drawRect(rect: CGRect) {
        layoutIfNeeded()
        let dframe = CGRectMake(0, 0, rect.width * 0.6, rect.height)
        let dots = DotsFactory.dots.quadrado.getByWidth(dframe, color: color.dark)
        let subs = self.subviews.last
        if subs != nil{
            self.insertSubview(dots, belowSubview: self.subviews.last!)
        }else{
            self.addSubview(dots)
        }
        
    }

}
