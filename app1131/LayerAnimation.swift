//
//  LayerAnimation.swift
//  T1_TesteCamera1131app
//
//  Created by camila oliveira on 10/18/15.
//  Copyright © 2015 camila oliveira. All rights reserved.
//

import UIKit

class LayerAnimation: CALayer {
    var forSecondss : NSNumber!
    var startAnimation : CABasicAnimation!
    
    
    init(img : UIImage, rect : CGRect, startTime : NSNumber, forSeconds : NSNumber) {
        super.init()
        self.opacity = 0
        contents = img.CGImage as? AnyObject
        frame = rect
        masksToBounds = true
        forSecondss = 0
        self.forSecondss = forSeconds
        if forSecondss == nil {
            forSecondss = NSNumber(double: 0.0)
        }
        buildAnimations()

    }
    
    func startAnimations(){
//        self.hidden = false
        //ACHO QUE NAO PRECISA ... MUDAR
        self.addAnimation(startAnimation, forKey: "startAnimation")

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
