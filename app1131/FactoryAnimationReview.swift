//
//  FactoryAnimationReview.swift
//  app1131
//
//  Created by camila oliveira on 10/19/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class FactoryAnimationReview: FactoryAnimationShow {
    var iterator = -1
    override func getAnimation() -> LayerAnimation {

        #if DEBUG
            print("camila - FactoryAnimationReview - getAnimation - get image from preloaded storyModel images")
        #endif
        
        
       iterator++
        if iterator >= self.storyModel.arrayElements.count - 1{
            self.timer?.invalidate()
        }
        
        #if DEBUG
            print("camila - FactoryAnimationReview - getAnimation - i:\(iterator) max:\(storyModel.arrayElements.count)")
        #endif
        
        let image = self.storyModel.arrayElements[iterator] 
        let origin = CGPointMake((backgroundSize.width/2 - animationSize.width/2), animationSize.height * 0.025)
        let layerAnim = LayerAnimation(img: image,
            rect: CGRect(origin: origin, size: self.animationSize),
            startTime: 0,
            forSeconds: storyModel.level.value)
        layerAnim.startAnimation.beginTime = CACurrentMediaTime()
        return layerAnim
    }
    
    override func getPhrase() -> LabelAnimation {
        let ph = super.getPhrase()
        if self.storyModel.hasPhrase(){
            ph.sublayers![0].removeFromSuperlayer()
        }
        
        
        return ph
    }
    
}
