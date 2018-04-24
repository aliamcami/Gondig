//
//  FactoryAnimationRender.swift
//  T1_TesteCamera1131app
//
//  Created by camila oliveira on 10/18/15.
//  Copyright © 2015 camila oliveira. All rights reserved.
//

import UIKit

class FactoryAnimationRender: FactoryAnimation {
    //TA DANDO MERDA...

    init(storyModel : VideoModelCamiTretas){
        super.init()
        self.storyModel = storyModel
        self.viewSize = storyModel.getNaturalSize()

    }
    
    func getAllAnimations() -> CALayer{
        #if DEBUG
            print("camila - FactoryAnimationRender - getAllAnimations")
        #endif
        //create container for animations
        let container = CALayer()
        container.frame = CGRectMake(0, 0, self.viewSize.width, self.viewSize.height)
        
        //get background image for images
        let bg = self.getBackgroundLayer()
        let borda = getBGFrame()
        
        //get phrase layer if phrase not off
        if storyModel.hasPhrase(){
            let phrase = getPhrase()
            phrase.startAnimation.beginTime = AVCoreAnimationBeginTimeAtZero
            phrase.startAnimations()
            
            //adiciona frase no container
            container.addSublayer(phrase)
            
            //make opacity animation for bg
            let opacity = CABasicAnimation(keyPath: "opacity")
            opacity.duration = CFTimeInterval(storyModel.phraseStatus.value)
            opacity.repeatCount = 1
            opacity.autoreverses = false
            opacity.fromValue = 0
            opacity.toValue = 0
            opacity.beginTime = AVCoreAnimationBeginTimeAtZero
            //adiciona animacoes no container
            bg.addAnimation(opacity, forKey: "opacity")
            borda.addAnimation(opacity, forKey: "opacity")
        }
        
        container.addSublayer(bg)
        container.addSublayer(borda)
        //iterate over all images on array
        for var index = 0; index < storyModel.arrayElements.count; index++ {
            #if DEBUG
                print("camila - FactoryAnimationRender - getAllAnimations - index:\(index) max:\(storyModel.arrayElements.count)")
            #endif
            
            let layer = self.getAnimation(index)
            bg.addSublayer(layer)
            layer.startAnimations()
        }
        
        return container
    }
    
    
    func getAnimation(index : Int) -> LayerAnimation {
        #if DEBUG
            print("camila - FactoryAnimationRender - getAnimation - get From Pre-Loaded storyModel Images")
        #endif
        
        let image = self.storyModel.arrayElements[index] 
        let origin = CGPointMake((backgroundSize.width/2 - animationSize.width/2), extra)
        let layerAnim = LayerAnimation(img: image,
            rect: CGRect(origin: origin, size: self.animationSize),
            startTime: 0,
            forSeconds: storyModel.level.value)
        let delay = (storyModel.level.value.doubleValue * Double(index)) + storyModel.phraseStatus.value.doubleValue
        layerAnim.startAnimation.beginTime = AVCoreAnimationBeginTimeAtZero + delay
        
        return layerAnim
    }
    
    override func getLabel()-> LabelAnimation{
        //set sizes
        let width = viewSize.width - 20
        let height = viewSize.height/3.5
        //get layer with phrase
        let ph = LabelAnimationRender(label: self.storyModel.phrese,
            rect: CGRectMake(
                10,
                viewSize.height * 0.95 - height,
                width,
                height),
            startTime: 0,
            forSeconds: self.storyModel.phraseStatus.value)
        return ph
    }
}
