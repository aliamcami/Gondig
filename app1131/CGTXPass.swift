//
//  CGTXPass.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CGTXPass: TextFieldGondig {

    override func verify() {
        //GIOVANI, VERIFICA SE USERNAME JA EXISTE
        // valid = true
        if self.valid{
            setValid()
        }else{
            setInvalid()
        }
        
        //verifica se o cara ja digitou o outro pass e arrumou esse
        parent?.fieldPassConf.verify()
        
    }

}
