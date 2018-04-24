//
//  VideoModel.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/15/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class VideoModel: NSObject {
    // Nome do video - Aaahhhhh váaaaaaa
    var name : String!
    // Nivel de dificuldade do video
    var level : VideoConfig.level!
    // Tempo do video
    var length : VideoConfig.length!
    // A thumbnail da budega
    var thumbnail: UIImage?
    
    // MARK: Custom Init
    init(name: String, level: VideoConfig.level, time: VideoConfig.length) {
        super.init()
        // Coisa de linguagem de baixa produtividade \/
        self.name = name
        self.level = level
        self.length = time
        self.thumbnail = UIImage(named: "img2.png")
    }
    
    
}
