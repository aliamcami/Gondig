//
//  ConfigButtons.swift
//  app1131
//
//  Created by camila oliveira on 12/2/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ConfigButtons: UIView {
    var buttonsBG : UIView!

    override func drawRect(rect: CGRect) {
        layoutIfNeeded()
        
        setButtonsBackground()
        

//        self.addSubview(buttonsBG)
    }
    
    override func setNeedsDisplay() {
        self.backgroundColor = UIColor.purpleColor()
    }
    
    func getBackground()-> UIView{
        let rect = CGRectMake(0,
            0,
            self.frame.width/2,
            self.frame.height)
        
        let up = DotsFactory.dots.quadrado.getByWidth(rect,
            color: ViewConfig.color.background.light.colorWithAlphaComponent(0.9))
        let down = DotsFactory.dots.quadrado.getByWidth(
            rect,
            color: ViewConfig.color.background.light.colorWithAlphaComponent(0.9))

        
//        up.rotate(45)
//        down.rotate(-45)
        
//        up.center = CGPointMake(rect.width/2, rect.height * 0.25)
//        down.center = CGPointMake(rect.width/2, rect.height * 0.75)
        
        let bg = UIView(frame: rect)
        bg.addSubview(up)
        bg.addSubview(down)
        
        return bg
    }
    
    private func setButtonsBackground() {
        let rect = self.frame
        let frame = CGRectMake(0, 0, rect.width * 0.8, rect.height * 0.1)
        buttonsBG = ConfigButtonsBackground(frame: frame)
        buttonsBG.center = CGPointMake(rect.width/2, rect.height * 0.75)
    }

}
