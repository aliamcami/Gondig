//
//  VideoModelCamiTretas.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/16/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//
//  Classe das Tretas hehehe

import UIKit
import AVFoundation

class VideoModelCamiTretas: VideoModel {
    var asset : AVAsset!{
        didSet{
            self.thumbnail = self.getThumbnailOfVideoAt()
        }
    }
    var arrayElements = Array<UIImage>() //array de UIimage
    var animationSize : VideoConfig.animationSize!
    var originURL : NSURL!{
        didSet{
            self.asset = AVURLAsset(URL: self.originURL)
        }
    }
    var totalTime : NSNumber {
        get{
            return self.phraseStatus.value.doubleValue + self.length.value.doubleValue
        }
    }
    var phraseStatus : VideoConfig.phraseStatus!
    var phrese : String = ""
    
    init() {
        let lvl = VideoConfig.userLevel
        let lng = VideoConfig.userLength
        super.init(name: "Video_\(Int(NSDate().timeIntervalSince1970))", level: lvl, time: lng)
        
        #if DEBUG
            print("\ncamila - VideoModelCamiTretas - init - name: \(self.name)\n")
        #endif
        
        animationSize = VideoConfig.userAnimationSize
        phraseStatus = VideoConfig.userPhraseStatus
    }
       
    init(lenght : VideoConfig.length, level : VideoConfig.level, animationSize : VideoConfig.animationSize, phrase : VideoConfig.phraseStatus){
        super.init(name: "Video_\(Int(NSDate().timeIntervalSince1970))", level: level, time: lenght)
        
        #if DEBUG
            print("\ncamila - VideoModelCamiTretas - init - name: \(self.name)\n")
        #endif
        
        self.animationSize = animationSize
        self.phraseStatus = phrase

    }
        
    
    let animationView = AddAnimationViewController()
    var exportSession : AVAssetExportSession?
    func getExportSession() -> AVAssetExportSession{
        #if DEBUG
            print("camila - VideoModelCamiTretas - getExportSession")
        #endif
        
        if (exportSession == nil){
            #if DEBUG
                print("camila - VideoModelCamiTretas - getExportSession - Create New Export Session")
            #endif
            
            //animation factory for render
            let factory = FactoryAnimationRender(storyModel: self)
            
            //container to animations - modification
            let container = CALayer()
            container.frame = CGRectMake(0, 0, factory.viewSize.width, factory.viewSize.height)
            
            //if there are a start phrase then add it
            if self.hasPhrase(){
                #if DEBUG
                    print("camila - FactoryAnimationShow - insertAnimationInLayer - Phrase Status ON")
                #endif
                
                container.addSublayer(factory.getPhrase())
            }
            
            //add imagens animation
            let animation = factory.getAllAnimations()
            container.addSublayer(animation)
            
            let hq = BordersFactory(rect: container.frame)
            container.addSublayer(hq.getFilledWithInsideBorder())
            
            //export session
            exportSession = animationView.videoOutputWithAsset(
                self.asset,
                andOverlayLayer: container
            )
        }
        
        return exportSession!
    }
    
    
    var timesUp = false
    func addAnimationLayer(image : UIImage){
        if !timesUp {
            print("camila - VideoModelCamiTretas - addAnimationLayer - Adicionando Elemento")
            arrayElements.append(image)
        }
        
        #if DEBUG
            print("camila - VideoModelCamiTretas - addAnimationLayer - timesUp \(timesUp) count: \(self.arrayElements.count)")
        #endif
        
    }
    
    private var naturalSize : CGSize?
    func getNaturalSize() -> CGSize{
        #if DEBUG
            print("camila - VideoModelCamiTretas - getNaturalSize")
        #endif
        
        if (self.naturalSize == nil){
            #if DEBUG
                print("camila - VideoModelCamiTretas - getNaturalSize - instantiate new natural size")
            #endif
            
            let ns = animationView.getNaturalSizeFor(animationView.getAssetTrackAndFixOrientationFor(self.asset))
            return ns
        }
        return self.naturalSize!
    }
    
    func getThumbnailOfVideoAt() -> UIImage{
        
        // Cria um gerador de imagem baseado no Asset de cima
        let generator = AVAssetImageGenerator(asset: self.asset)
        generator.appliesPreferredTrackTransform = true
        
        // Setando um tamanho maximo pra thumbnail video gravado em 720 x 1280,  ASPECT RATIO 1:177777
        let max : CGFloat = 150.0
        let maxSize = CGSizeMake( max, (max * 1.78))
        generator.maximumSize = maxSize
        
        // seta qual frame que a thumbanil vai ser
        let time = CMTimeMake(2, 60)
        
        // Inicia a imagem pq genialmente tudo que é criado dentro do do-try-catch só existe dentro do escopo do Do (Du'oh)
        var image = UIImage()
        
        // Iniciando a linda estrutura do do-try-catch
        do {
            // Gerando a referencia para a imagem atraves do gerador
            let imgRef = try generator.copyCGImageAtTime(time, actualTime: nil)
            
            // Pegando a imagem atraves da referencia
            image = UIImage(CGImage: imgRef)
            // Tenho que tratar os erros direito
        } catch {
            print("Erro durante a captura da CGImage")
        }
        
        // Retorna a imagem
        return image
    }
    
    func isInfinite() -> Bool{
        return self.length == VideoConfig.length.infinite
    }
    func hasPhrase() ->  Bool{
        return !(self.phraseStatus == VideoConfig.phraseStatus.off)
    }
    

    
      

}
