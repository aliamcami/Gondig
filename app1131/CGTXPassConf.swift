//
//  CGTXPassConf.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CGTXPassConf: TextFieldGondig {
    
    override func verify (){
        //GIOVANI, VERIFICA SE USERNAME JA EXISTE
        
         valid = self.text == parent?.fieldPass.text
        if self.valid{
            setValid()
        }else{
            setInvalid()
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
