//
//  NormalSave.swift
//  app1131
//
//  Created by camila oliveira on 11/3/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class Save: NSObject {
    func save (storyModel : VideoModelCamiTretas){
        #if DEBUG
            print("camila - Save - start saving video")
        #endif

//        ({
            let vdao = VideoDAO()
            vdao.saveVideo(storyModel)
//        }) ~> ({
//            #if DEBUG
//                print("CAMILA - Save - Finalizando salvar video assincrono")
//            #endif
//        })
 
        
    }
}

