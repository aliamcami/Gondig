//
//  VideoModelNetwork.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 11/11/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class VideoModelNetwork: VideoModelShow {
    // Identificador gerado pelo servidor
    // Estou reavaliando essa funcionalidade, talvez ela dë mais trabalho do que realmente ajude
    // var prefix : String!
    
    // Autor do video
    var author : UserModel!
    
    // Pai desse video na arvore
    var parent : VideoModelNetwork?
    
    // Os videos da network são salvos na pasta temporario
    override var videoUrl : NSURL? {
        get{
            return NSURL(fileURLWithPath: Constants.path.tmp + "\(self.videoID!)" + Constants.fileType.video)
        }
    }
    
    // Thumbnail
    override var thumbUrl : NSURL?{
        // URL da thumbnai
        return NSURL(fileURLWithPath: Constants.path.tmp + "\(self.videoID!)" + Constants.fileType.thumbnail)
    }
    
    // Data de criacao, to mantendo o padrao de nome que o ruby usa pra facilitar o parse. Fock o CamelCase
    // Desisti de retornar isso, nao vai precisar msm
    // var created_at : String?
    
    // Lembrando que ainda temos o nome, level e length na classe avó VideoModel
    // E a url do video e thumbnail na classe pai VideoModelShoe
    
    
    // MARK: Custom init
    // Pra mim
    init(videoID: Int32, name: String, level: VideoConfig.level, time: VideoConfig.length, parent: VideoModelNetwork) {
        super.init(videoID: videoID, name: name, level: level, time: time)
        self.parent = parent
    }
    
    override init(videoID: Int32, name: String, level: VideoConfig.level, time: VideoConfig.length) {
        super.init(videoID: videoID, name: name, level: level, time: time)
    }
    
    // Pra camila
    init(name: String, level: VideoConfig.level, time: VideoConfig.length, parent: VideoModelNetwork) {
        super.init(name: name, level: level, time: time)
        self.parent = parent
    }
    
    override init(name: String, level: VideoConfig.level, time: VideoConfig.length) {
        super.init(name: name, level: level, time: time)
    }
    
    // Transformando a classe em um dict
    // As verificacoes sao para evitar que dê qualquer merda, ja que os atributos sao opcionais
    func classDictionary() -> Dictionary<String, NSObject>{
        var classDict = Dictionary<String, NSObject>()
        // Acho que o id nunca tera um valor, sei lah, soh acho kkkkk tem que ver
        if (self.videoID != nil) {
            classDict["id"] = NSNumber(int: self.videoID!)
        }
        
        if (self.parent != nil){
            classDict["parent"] = NSNumber(int: self.parent!.videoID!)
        }
        
        // Esses atributos nao sao opcionais, entao nao vou verificar a existencia deles
        classDict["length"] = self.length.rawValue
        classDict["level"] = self.level.rawValue
        classDict["name"] = self.name
        
        var videoDict = Dictionary<String, NSObject>()
        videoDict["video"] = classDict
        
        return videoDict
    }
}
