//
//  CGLoginView.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CGLoginView: GondigBG {

    init(rect :  CGRect){
        
        super.init(rect: rect, tipo: GondigBG.tipo.login)
        self.azul.fillColor = ViewConfig.color.color3.dark.CGColor
        self.verde.fillColor = ViewConfig.color.color2.dark.CGColor
//        self.vermelho.fillColor = ViewConfig.color.color4.light.CGColor
        self.amarelo.fillColor = ViewConfig.color.color1.dark.CGColor
        self.backgroundColor = ViewConfig.color.background.light
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
