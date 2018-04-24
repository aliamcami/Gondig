//
//  FactoryAnimationShow.swift
//  T1_TesteCamera1131app
//
//  Created by camila oliveira on 10/18/15.
//  Copyright © 2015 camila oliveira. All rights reserved.
//

import UIKit


class FactoryAnimationShow: FactoryAnimation {
    var timer : NSTimer?
    private var layer : CALayer!
    
    init(storyModel : VideoModelCamiTretas, viewSize : CGSize){
        super.init()
        self.storyModel = storyModel
        self.viewSize = viewSize
        self.startPoint.y = viewSize.height - self.animationSize.height - self.startPoint.y
    }
    
    //Point(0,0) upper left
    var whiteBG : CALayer!
    func insertAnimationInLayer(layer: CALayer)  {
        
        #if DEBUG
            print("camila - FactoryAnimationShow - insertAnimationInLayer")
        #endif
        
        self.layer = layer
        
        //add Phrase
        print(self.storyModel)
        if self.storyModel.hasPhrase(){
            #if DEBUG
                print("camila - FactoryAnimationShow - insertAnimationInLayer - Phrase Status ON")
            #endif
            
            layer.addSublayer(self.getPhrase())
        }

        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.storyModel.phraseStatus.value.doubleValue,
            target: self, selector: "addAnimationWithTimer:", userInfo: nil, repeats: false)
        
        
    }
    func addAnimationWithTimer(timer : NSTimer){
        //add Elements
            //white background for elements to be more visible
            self.whiteBG = self.getBackgroundLayer()

            //add first element
            self.addElement(NSTimer())
            //get new element every LEVEL seconds
            if (self.storyModel.length.value.doubleValue > self.storyModel.level.value.doubleValue) || (self.storyModel.length == VideoConfig.length.infinite){
                self.timer = NSTimer.scheduledTimerWithTimeInterval(self.storyModel.level.value.doubleValue,
                    target: self, selector: "addElement:", userInfo: nil, repeats: true)
            }
        
        self.layer.addSublayer(self.whiteBG)
        
        self.layer.insertSublayer(getBGFrame(), above: self.whiteBG)
        
    }
    
    
    override func getAnimation() -> LayerAnimation {
        #if DEBUG
            print("camila - FactoryAnimationShow - getAnimation")
        #endif
        let animation = super.getAnimation()
        return animation
    }
    
    func addElement (timer :  NSTimer){
        #if DEBUG
            print("camila - FactoryAnimationShow - addElement")
        #endif
        
        self.whiteBG.sublayers = nil
        let animation = getAnimation()
        self.whiteBG.addSublayer(animation)
        animation.startAnimations()
    }
    
    override func getPhrase() -> LabelAnimation {
        let ph = super.getPhrase()
        
        //adicionando countdown da frase na layer da frase
//        insertPhraseCountDown(ph)
        
        return ph
    }
    
//    private let progress = UIProgressView()
//    private func insertPhraseCountDown (phLayer : CALayer){
//        let width =  phLayer.frame.width * 0.75
//        let height =  phLayer.frame.height * 0.05
//        let x = phLayer.frame.width * (1 - (width / phLayer.frame.width))/2
//        let y = phLayer.frame.height * 0.75
//        let frame = CGRectMake(x, y, width, height)
//        let bar = CRProgressBar(rect: frame, time: self.storyModel.phraseStatus.value)
//        phLayer.insertSublayer(bar, atIndex: 0)
//        
//    }
    
    
    
    
}
