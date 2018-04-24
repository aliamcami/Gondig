//
//  FactoryOverlayAnimation.swift
//  T1_TesteCamera1131app
//
//  Created by camila oliveira on 10/14/15.
//  Copyright © 2015 camila oliveira. All rights reserved.
//

import UIKit

class FactoryAnimation : NSObject{
    var storyModel : VideoModelCamiTretas!
    var extra : CGFloat{
        return self.storyModel.animationSize.borderAbsoluteMax
    }
    var viewSize : CGSize!{
        didSet{
            let tam = viewSize.height * CGFloat(storyModel.animationSize.value.floatValue)
            self.animationSize = CGSizeMake(tam, tam)
            self.backgroundSize = CGSizeMake(viewSize.width, tam + extra * 3)
            if isCompactDevice{
                self.startPoint = CGPointMake(0, 140)
            }else{
                self.startPoint = CGPointMake(0, 190)
            }
            
            self.hqFrame = BorderFrame(frame: CGRectMake(0, 0, viewSize.width, viewSize.height))
        }
    }
    var backgroundSize : CGSize!
    var animationSize : CGSize!
    var startPoint : CGPoint!
    var hqFrame : UIView!
    
    func getAnimation() -> LayerAnimation {
        #if DEBUG
            print("camila - FactoryAnimation - getAnimation")
        #endif
        
        
        let image = getRandomImage()
        
        //incui na storyModel
        self.storyModel.addAnimationLayer(image)
        
        let origin = CGPointMake((backgroundSize.width/2 - animationSize.width/2), extra)
        let layerAnim = LayerAnimation(img: image,
            rect: CGRect(origin: origin, size: self.animationSize),
            startTime: 0,
            forSeconds: storyModel.level.value)
        return layerAnim
    }
    func getBGFrame()-> CALayer! {
        //tentar por borda
        let borderCG = CGRectMake(0, 0, self.backgroundSize.width + 40, self.backgroundSize.height)
        let border = BordersFactory(rect: borderCG, minAbsolute: max(storyModel.animationSize.borderAbsoluteMax/1.5, ViewConfig.widths.borderFrame), maxAbsolute: storyModel.animationSize.borderAbsoluteMax).getFilledWithBorders()
        border.frame.origin = CGPointMake(startPoint.x - 20, startPoint.y)
        //COLOCAR DOTS AQUI
        return border
    }

    private func getRandomImage() -> UIImage{
        
        #if DEBUG
            print("camila - FactoryAnimation - getRandomImage")
        #endif
        
        var img = UIImage(named: getRandomImageName())
        //tenta pegar img por 10x
        for _ in 1...10{
            if img != nil {
                #if DEBUG
                    print("camila - FactoryAnimation - getRandomImage - Deu Bom")
                #endif
                break
            }else{
                #if DEBUG
                    print("camila - FactoryAnimation - getRandomImage - Deu Merda")
                #endif
                img = UIImage(named: getRandomImageName())
            }
        }
        //se ainda der merda e for nil, instancia uma img sem img pra n dar merda
        if img == nil{
            #if DEBUG
                print("camila - FactoryAnimation - getRandomImage - depois de 10 tentativas ainda nao encontrou img, instanciando uma imagem sem imagem")
            #endif
            
            img = UIImage()
        }
        
        return img!
    }
    private func getRandomImageName() -> String{
        
        let index = Int(arc4random_uniform(UInt32(VideoConfig.maxImages.max.value.integerValue))) + VideoConfig.maxImages.minimun.value.integerValue
//        let index = (Int(random()) % VideoConfig.maxImages.minimun.value.integerValue)+1
        let name = "img\(index).png"
        
        #if DEBUG
            print("camila - FactoryAnimation - getRandomImageNAME - img named: \(name)")
        #endif
        
        return name
    }
    
    func getBackgroundLayer () -> CALayer{
        #if DEBUG
            print("camila - FactoryAnimation - getBackgroundLayer")
        #endif
        
        let layer = CALayer()
        layer.frame = CGRect(origin: startPoint, size: self.backgroundSize)
        layer.backgroundColor = ViewConfig.color.background.dark.colorWithAlphaComponent(0.7).CGColor
        
        
        return layer
    }
    
//    var labelAnim : LabelAnimation{
//        return LabelAnimation
//    }
   
    func getPhrase () -> LabelAnimation{
        #if DEBUG
            print("camila - FactoryAnimationShow - getPhrase - get layer with a phrase")
        #endif
        print(self.storyModel.phrese)
        
        //adiciona uma nova frase na story model se nao existir
        if self.storyModel.phrese == ""{
            //get string phrase
            let phrase = FactoryRandomPhrase().getPhrase()
            
            //set storyModel string phrase
            self.storyModel.phrese = phrase
        }
        
        //get layer with phrase
        let ph = getLabel()
        ph.startAnimations()
        
        return ph
    }
    
    func getLabel()-> LabelAnimation{
        //set sizes
        let width = viewSize.width - 20
        let height = viewSize.height/3.5
        //get layer with phrase
        let ph = LabelAnimation(label: self.storyModel.phrese,
            rect: CGRectMake(
                10,
                viewSize.height * 0.05,
                width,
                height),
            startTime: 0,
            forSeconds: self.storyModel.phraseStatus.value)
        return ph
    }

    
    
}
