//
//  VideoModelShow.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/16/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class VideoModelShow: VideoModel {
    // Id no Database
    var videoID : Int32?
    // Video em si
    var videoUrl : NSURL? {
        get{
           return NSURL(fileURLWithPath: Constants.path.videos + self.name + Constants.fileType.video)
        }
    }
    
    // Thumbnail
    var thumbUrl : NSURL?{
        // URL da thumbnai
        return NSURL(fileURLWithPath: Constants.path.thumbnails + self.name + Constants.fileType.thumbnail)
    }
    
    // MARK: Custom Init
    // Init pra quando buscar do Database
    init(videoID: Int32, name: String, level: VideoConfig.level, time: VideoConfig.length) {
        // Sem ideia boa pra esse comentario
        super.init(name: name, level: level, time: time)
        
        // Coisa de linguagem de baixa produtividade \/
        self.videoID = videoID
        
    }
    // Init pros videos da nossa rede criado pela camila
    override init(name: String, level: VideoConfig.level, time: VideoConfig.length) {
        super.init(name: name, level: level, time: time)
    }
    
    // Retorna a thumbnail para a camila
    func getThumbnail() -> UIImage? {
        #if DEBUG
            print("Giovani - VideoModelShow - getThumbnail -> Buscando o binario na url da thumbnail...")
        #endif
        
        if self.thumbUrl == nil{
            return nil
        }
        
        // Busca o binario da treta salva no disco
        if let thumbData = NSData(contentsOfURL: self.thumbUrl!) {
            #if DEBUG
                print("Giovani - VideoModelShow - getThumbnail -> Binário buscado com sucesso!")
                print("Giovani - VideoModelShow - getThumbnail -> Preparando para transformar o binário em imagem...")
            #endif
            // Transforma o binário em foto
            if let image = UIImage(data: thumbData) {
                #if DEBUG
                    print("Giovani - VideoModelShow - getThumbnail -> Imagem buscada com sucesso!")
                    print("Giovani - VideoModelShow - getThumbnail -> Retornando a UIImage gerada...")
                #endif
                return image
            }
            #if DEBUG
                print("Giovani - VideoModelShow - getThumbnail -> Falha na transformação do binário em UIImage")
            #endif
            // Nao retorna nada
            return nil
        }
        #if DEBUG
            print("Giovani - VideoModelShow - getThumbnail -> Falha na retirada do binário do disco")
        #endif
        // Nao retorna nada
        return nil
    }
    
    
    //duration in minutes
    private var duration : Double!
    func getVideoTime () -> String{
        
                
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = .Positional
        formatter.zeroFormattingBehavior = .Pad
        formatter.allowedUnits = [NSCalendarUnit.Minute, NSCalendarUnit.Second]
  
        return formatter.stringFromTimeInterval(getAssetDuration())!
    }
    
    func getAssetDuration() -> Double{
        if self.videoUrl == nil{
            return 0
        }
        
        if duration == nil{
            let tasset = AVAsset(URL: self.videoUrl!)
            duration = ceil(tasset.duration.seconds)
            
        }
        return duration
    }

}
