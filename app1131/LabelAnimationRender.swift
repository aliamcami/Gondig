//
//  LabelAnimationRender.swift
//  app1131
//
//  Created by camila oliveira on 12/3/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class LabelAnimationRender: LabelAnimation {
    override func getTriangulo(rect : CGRect) -> CALayer{
        let trigSize = CGSizeMake(rect.width * 0.15 , rect.height * 0.15)
        //make path
        let bordaPath = UIBezierPath()
        let w = rect.width * 0.85 - trigSize.width
        let y = trigSize.height + ViewConfig.widths.borderFrame + 1
        bordaPath.moveToPoint(CGPointMake(w, y))
        bordaPath.addLineToPoint(CGPointMake(w + trigSize.width * 0.6, y - trigSize.height))
        bordaPath.addLineToPoint(CGPointMake(w + trigSize.width, y))
        bordaPath.closePath()
        //make shaped layer
        let trig = CAShapeLayer()
        trig.path = bordaPath.CGPath
        trig.lineWidth = ViewConfig.widths.borderFrame
        trig.fillColor = ViewConfig.color.background.dark.CGColor
        trig.strokeColor = ViewConfig.color.borderColor.dark.CGColor
        trig.strokeStart = 0.015
        trig.strokeEnd = 0.595
        
        return trig
        //        self.addSublayer(trig)
    }
    
   override func getQuadrado(rect : CGRect)-> CALayer{
        let chat = CALayer()
        let trigSize = CGSizeMake(rect.width * 0.15 , rect.height * 0.15)

        //configura chat grande
        chat.frame = CGRectMake(0, trigSize.height, rect.width * 0.95, rect.height - trigSize.height)
        chat.borderColor = ViewConfig.color.borderColor.dark.CGColor
        chat.borderWidth = ViewConfig.widths.borderFrame
        chat.shadowColor = chat.borderColor
        chat.shadowOffset = CGSizeMake(3, -10)
        chat.shadowOpacity = 0.9
        chat.shadowRadius = 8
        chat.backgroundColor = ViewConfig.color.background.dark.CGColor
        chat.cornerRadius = rect.height * 0.15
        
        //        self.addSublayer(chat)
        return chat
        
    }

}