//
//  DBController.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/15/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class DBController: NSObject {
    // Database
    var database : FMDatabase!
    
    // MARK: Custom Init
    override init() {
        super.init()
        // Setando o path do database
        let pathToDatabase = Constants.path.database + Constants.name.database
        // Buscando o DB
        self.database = FMDatabase(path: pathToDatabase)
        
        #if DEBUG
            self.database.logsErrors = true
            print("Giovani - DBController - Init -> Ativados os logs do database")
        #endif
    }
    
    // Abre o Database
    func openDatabase() -> Bool {
        return self.database.open()
    }
    
    // Fecha o database
    func closeDatabase() -> Bool {
        return self.database.close()
    }

}

