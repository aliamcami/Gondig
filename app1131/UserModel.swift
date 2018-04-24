//
//  UserModel.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 11/17/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

class UserModel: NSObject {
    // Todos os atributos estao opcionais pq a resposta do servidor nao contem boa parte dos atributos
    
    // Acho que nao precisa colocar id nao ne? Ja que essa model nao vai ser construida atraves dos dados do server
    // Precisa sim! Eu vou retornar o autor do video, entao vou parsear nessa model
    var userID : Int?
    
    var email : String?
    var username : String?
    var password : String?
    
    // O ativo eu seto verdadeiro como valor padrao no banco de dados - então nem precisa por
    // Deixei aqui so pra vc saber que tem
    // var active : Bool?
    
    // Custom init
    // Init pra camila
    init(email: String, password: String, username: String) {
        super.init()
        self.email = email
        self.password = password
        self.username = username

    }
    
    // Outro init pra camila - Esse é para o login
    init(email: String, password: String){
        super.init()
        self.email = email
        self.password = password
    }
    
    init(username: String, password: String) {
        super.init()
        self.username = username
        self.password = password
    }
    
    // Init pra mim, so isso que eu retorno do server mesmo
    init(userID: Int, username: String) {
        super.init()
        self.userID = userID
        self.username = username
    }
    
    // MARK: Functions
    // Transforma a classe em um dicionario para registro de novo usuario
    // Os ifs sao so pra nao crashar kkkk
    func dictForQuery() -> Dictionary<String, NSObject>{
        var classDict = Dictionary<String, NSObject>()
        
        if self.email != nil {
            classDict["email"] = self.email
        }
        
        if self.username != nil {
            classDict["username"] = self.username
        }
        
        if self.password != nil {
            classDict["password"] = self.password
        }
        
        var userDict = Dictionary<String, NSObject>()
        userDict["user"] = classDict
        
        return userDict
    }
    
}
