//
//  GCadastroView.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class GCadastroView: GondigBG{
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    init(rect :  CGRect){

        super.init(rect: rect, tipo: GondigBG.tipo.cadastro)
        self.azul.fillColor = ViewConfig.color.color3.dark.CGColor
        self.verde.fillColor = ViewConfig.color.color2.dark.CGColor
        self.vermelho.fillColor = ViewConfig.color.color4.light.CGColor
        
        self.backgroundColor = ViewConfig.color.background.light
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    
  
    
}
