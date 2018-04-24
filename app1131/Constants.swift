//
//  Constants.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/19/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

// Todas as constantes pra facilitar a vida ne?
struct Constants {
    // Constantes relacionadas ao diretorio dos conteudos do app
    struct path {
        // Diretorio das thumbnails
        static let thumbnails = NSHomeDirectory() + "/Documents/Thumbnails/"
        // Diretorio dos videos
        static let videos = NSHomeDirectory() + "/Documents/Videos/"
        // Diretorio do banco de dados
        static let database = NSHomeDirectory() + "/Library/Database/"
        // Diretorio do temp
        static let tmp = NSHomeDirectory() + "/tmp/"
    }
    // Constantes de nomes das budegas
    struct name {
        // Nome do banco de dados
        static let database = "SemNome.sqlite"
    }
    // Extensao dos arquivos
    struct fileType {
        static let video = ".mov"
        static let thumbnail = ".jpg"
    }

    // Eu realmente nao queria adicionar mais constantes, acho que isso nao deveria ficar em memoria. Mas era a solucao mais rapida que eu tinha
    struct amazon {
        // Nome do nosso bucket
        static let bucket = "app1131"
        // As tretas de local do servidor e pa
        static let identityPoolId = "us-east-1:4e98da24-658c-4251-9caa-66846a5b48fd"
        // Regiao aonde nosso server esta localizado
        static let region = AWSRegionType.USEast1
    }
}