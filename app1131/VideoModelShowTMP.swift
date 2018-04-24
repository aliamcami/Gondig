//
//  VideoModelShowTMP.swift
//  app1131
//
//  Created by camila oliveira on 11/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class VideoModelShowTMP: VideoModelShow {
    override var videoUrl : NSURL{
        get{
            return NSURL(fileURLWithPath: Constants.path.tmp + super.name + Constants.fileType.video)
        }
    }
    override var thumbUrl : NSURL?{
        get{
            return nil
        }
    }
    
    
    override init(videoID: Int32, name: String, level: VideoConfig.level, time: VideoConfig.length) {
        // Sem ideia boa pra esse comentario... chamando super init, nao que essa seja uma boa ideia
        super.init(videoID: 0, name: name, level: level, time: time)
        
        // Coisa de linguagem de baixa produtividade \/
        self.videoID = videoID

    }
    
    // Retorna a thumbnail para a camila
    override func getThumbnail() -> UIImage? {
        return nil
    }
}

