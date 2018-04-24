//
//  CGTXEmail.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CGTXEmail: TextFieldGondig {

    override func verify() {
        //GIOVANI, VERIFICA SE USERNAME JA EXISTE
        // Nao fiz validacao nao kkkk
        // valid = true
        if self.valid{
            setValid()
        }else{
            setInvalid()
        }
    }


}
