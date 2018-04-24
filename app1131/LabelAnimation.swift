//
//  LabelAnimation.swift
//  app1131
//
//  Created by camila oliveira on 10/29/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class LabelAnimation: LayerAnimation {
    var label : UILabel!
    
    init(label : String, rect : CGRect, startTime : NSNumber, forSeconds : NSNumber) {
        //set container
        let container = CALayer()
        let wid : CGFloat
        if isCompactDevice{
            wid = rect.width * 0.9
        }else{
            wid = rect.width * 0.7
        }
        container.frame = CGRectMake(rect.width/2 - wid/2 + rect.origin.x + rect.width * 0.025, rect.origin.y, wid, rect.height)
        
        //set label
        let re = CGRectMake(container.frame.width * 0.1, 0, container.frame.width * 0.8, container.frame.height)
        self.label = UILabel(frame: re)
        self.label.text = label
        self.label.textAlignment = NSTextAlignment.Center
        self.label.numberOfLines = 3
        //set font
        self.label.font = UIFont.systemFontOfSize(rect.height * 0.1, weight: UIFontWeightSemibold)
        self.label.textColor = ViewConfig.text.phrase.color
        
        super.init(img : UIImage(), rect : container.frame, startTime : startTime, forSeconds : forSeconds)
        
        addChat(container)
        
        self.contents = nil
        self.addSublayer(self.label.layer)
        
        self.backgroundColor = UIColor.clearColor().CGColor
        
        //tentando col=
    }
    func addChat(container : CALayer){
        self.addSublayer(getChatLayer(container.frame))
    }

    func getChatLayer (rect : CGRect) -> CALayer{
        let cont = CALayer()
        cont.addSublayer(getQuadrado(rect))
        cont.addSublayer(getTriangulo(rect))
        return cont
    }
    
    func getQuadrado(rect : CGRect)-> CALayer{
        let chat = CALayer()
        let trigSize = CGSizeMake(rect.width * 0.15 , rect.height * 0.15)
        
        //configura chat grande
        chat.frame = CGRectMake(0, 0, rect.width * 0.95, rect.height - trigSize.height)
        chat.borderColor = ViewConfig.color.borderColor.dark.CGColor
        chat.borderWidth = ViewConfig.widths.borderFrame
        chat.shadowColor = chat.borderColor
        chat.shadowOffset = CGSizeMake(3, 10)
        chat.shadowOpacity = 0.9
        chat.shadowRadius = 8
        chat.backgroundColor = ViewConfig.color.background.dark.CGColor
        chat.cornerRadius = rect.height * 0.15
        
        //        self.addSublayer(chat)
        return chat

    }
    
    func getTriangulo(rect : CGRect) -> CALayer{
        let trigSize = CGSizeMake(rect.width * 0.15 , rect.height * 0.15)
        //make path
        let bordaPath = UIBezierPath()
        let w = rect.width * 0.85 - trigSize.width
        let y = rect.height - trigSize.height - ViewConfig.widths.borderFrame - 1
        bordaPath.moveToPoint(CGPointMake(w, y))
        bordaPath.addLineToPoint(CGPointMake(w + trigSize.width * 0.6, y + trigSize.height))
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
    
    private func buildAnimations(){
        self.startAnimation = buildOpacityAnimation(1, toValue: 1)
        
    }
    
    private func buildOpacityAnimation(fromValue : NSNumber, toValue : NSNumber) -> CABasicAnimation{
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.duration = CFTimeInterval(forSecondss)
        opacity.repeatCount = 1
        opacity.autoreverses = false
        opacity.fromValue = fromValue
        opacity.toValue = toValue
        return opacity
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
