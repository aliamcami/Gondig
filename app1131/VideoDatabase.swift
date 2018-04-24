//
//  VideoDatabase.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/15/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class VideoDatabase: DBController {
    
    // MARK: Custom Init - Acho que nao precisa disso nao, mas tem que testar
//    override init() {
//        super.init()
//    }
    
    // MARK: Query
    func getAllVideos() -> Array<VideoModelShow> {
        // Usando o defer pra ver de qual é
        defer {
            // Fecha conexao
            super.closeDatabase()
        }
        // Conexao com db
        super.openDatabase()
        
        #if DEBUG
            print("Giovani - VideoDatabase - getAllVideos -> Preparando para buscar todos os videos no banco de dados...")
        #endif
        
        // Criando a query
        let query = "SELECT * FROM videos ORDER BY id DESC"
        
        #if DEBUG
            print("Giovani - VideoDatabase - getAllVideos -> Executando query: \(query)")
        #endif
        
        // Buscando o resultado da query
        let result = super.database.executeQuery(query)
        
        // Para buscar todos os nomes ou nao
        var allVideos = Array<VideoModelShow>()
        
        // Verificando se achou alguma coisa
        if (result != nil) {
            // Enquanto houver resultados
            while (result!.next()) {
                // Pra facilitar o entendimento do código
                let name = result!.stringForColumn("name")
                let vidId = result!.intForColumn("id")
                let level = VideoConfig().getLevel(result!.longForColumn("level"))
                let time = VideoConfig().getLenght(NSNumber(double: result!.doubleForColumn("time")))
                let video = VideoModelShow(videoID: vidId, name: name, level: level, time: time)
                #if DEBUG
                    print("Giovani - VideoDatabase - getAllVideos -> \(vidId) - \(name) - \(level) - \(time)")
                #endif
                
                // Adiciona ao array
                allVideos.append(video)
            }
        }
        #if DEBUG
            print("Giovani - VideoDatabase - getAllVideos -> Retornando todos os videos mostrados acima ^")
        #endif
        
        // Retorna o array de nomes
        return allVideos
    }
    
    func getAllVideoNames() -> Array<String>{
        // Usando o defer pra ver de qual é
        defer {
            // Fecha conexao
            super.closeDatabase()
        }
        // Conexao com db
        super.openDatabase()
        // Buscando o resultado da query
        let result = super.database.executeQuery("SELECT name FROM videos")
        
        // Para buscar todos os nomes ou nao
        var allVideoNames = Array<String>()
        
        // Verificando se achou alguma coisa
        if (result != nil) {
            // Enquanto houver resultados
            while (result!.next()) {
                #if DEBUG
                    print("Giovani - VideoDatabase - getAllVideoNames -> " + result!.stringForColumn("name"))
                #endif
                let name = result!.stringForColumn("name")
                // Adiciona ao array
                allVideoNames.append(name!)
            }
        }
        // Retorna o array de nomes
        return allVideoNames
    }
    
    // Tudo isso pra nao ter que escrever mais codigo kkkk #burro
    func isValidName(name: String) -> Bool {
        // Garantir que o db vai ser fechado
        defer {
            super.closeDatabase()
        }
        // Abrindo a conexao
        super.openDatabase()
        return checkNameInDatabase(name)
    }
    
    // Verifica se o nome ja esta em uso
    // Esse metodo só pode ser chamado se ja houver conexao com db
    // Tudo isso so pra nao ter que escrever mta coisa kkkkkk #burro
    private func checkNameInDatabase(name: String) -> Bool {
        // preparando a query
        let query = "SELECT * FROM videos WHERE name = ? LIMIT 1"
        
        #if DEBUG
            print("Giovani - VideoDatabase - checkName... -> Executando query: \(query)")
        #endif
        
        // query para verificar a existencia de um determinado nome
        let result = super.database.executeQuery(query, withArgumentsInArray: [name])
        
        if result != nil {
            if result!.next() {
                #if DEBUG
                    print("Giovani - VideoDatabase - checkName... -> O nome \(name) existe no DB")
                #endif
                return false
            }
            #if DEBUG
                print("Giovani - VideoDatabase - checkName... -> O nome \(name) NAAOO existe no DB")
            #endif
            // Avisa que o nome nao existe
            return true
        }
        #if DEBUG
            print("Giovani - VideoDatabase - checkName... -> Deu alguma treta na query do DB")
        #endif
        // Retorna false pq deu merda antes ?
        return false
    }
    
    //update no nome do video no DB
    func updateName(newName : String?, video : VideoModel?) -> Bool{
       //retorna sem fazer nada se o video vier null...
        if video == nil || newName == ""{
            return false
        }
        
        // Garantir que o db vai ser fechado
        defer {
            super.closeDatabase()
        }
        // Abrindo a conexao
        super.openDatabase()
        
        if checkNameInDatabase(newName!){
            
            //update no nomes dos arquivos tambem... pq nao sao independentes, pq somos burros.
            //nao sei pra q vou usar isso, se der merda aki, em algum momento, deu merda mesmo.. ai fudeu...
            let arq = VideoManager().updateVideoAndThumbnailNAMES(newName!, originalName: video!.name)
            
            if arq{
                let query = "UPDATE videos SET name = ? WHERE name = ?"
                
                #if DEBUG
                    print("camila - VideoDatabase - updateName... -> Executando query: \(query)")
                #endif
                
                // query para verificar a existencia de um determinado nome
                let result = super.database.executeUpdate(query, withArgumentsInArray: [newName!, video!.name])
                #if DEBUG
                    print("camila - VideoDatabase - updateName... ->update de \(video!.name) para \(newName!) = \(result)")
                #endif
                
                return result
            }
            
            return arq
        }
        
        return false

    }
    
    // Escrevendo essa funcao pra me sentir bem
    // Pq a situacao tava feia
    // Parece que nao adiantou de nada pq esse metodo nao deve ser usado
    // So nao vou exlcuir pq vai q precisa ne?
    private func checkVideoInDatabase(video: VideoModelShow) -> Bool {
        // Preparando a query
        let query = "SELECT * FROM videos WHERE id = ? AND name = ? LIMIT 1"
        
        #if DEBUG
            print("Giovani - VideoDatabase - checkVideo... -> Executando query: \(query)")
        #endif
        
        // query para verificar a existencia de um determinado nome
        let result = super.database.executeQuery(query, withArgumentsInArray: [NSNumber(int: video.videoID!), video.name])
        
        if result != nil {
            if result!.next() {
                #if DEBUG
                    print("Giovani - VideoDatabase - checkVideo... -> O video de id \(video.videoID!) ja existe no DB")
                #endif
                return false
            }
            #if DEBUG
                print("Giovani - VideoDatabase - checkVideo... -> O video de id \(video.videoID!) NAAOO existe no DB")
            #endif
            // Avisa que o nome nao existe
            return true
        }
        #if DEBUG
            print("Giovani - VideoDatabase - checkVideo... -> Deu alguma treta na query do DB")
        #endif
        // Retorna false pq deu merda antes ?
        return false
    }
    
    // MARK: Update
    func addVideo(video: VideoModelCamiTretas) -> Bool {
        // Usando o defer pra ver de qual é
        defer {
            // Fecha a conexao com o DB
            super.closeDatabase()
        }
        // Abre conexao com o DB
        super.openDatabase()
        
        #if DEBUG
            print("Giovani - VideoDatabase - addVideo -> Checando se o nome do video é valido...")
        #endif
        
        // Checa se o nome é valido
        if checkNameInDatabase(video.name) {
            #if DEBUG
                print("Giovani - VideoDatabase - addVideo -> Preparando pra inserir no banco")
            #endif
            // Insere no database
            return super.database.executeUpdate("INSERT INTO videos (name, level, time) VALUES (?,?,?)", withArgumentsInArray: [video.name, video.level.rawValue,  video.length.rawValue])
        }
        #if DEBUG
            print("Giovani - VideoDatabase - addVideo -> Abortada operacao de insercao: Nome nao é valido")
        #endif
        // O nome nao é valido
        return false
    }
    
    // Se essa merda nao for pra master agora - desculpa, vc nao
    func deleteVideo(video: VideoModelShow) -> Bool {
        // Defer mais uma vez
        defer {
            super.closeDatabase()
        }
        // Abre conexao
        super.openDatabase()
        
        // Preparando a query
        let query = "DELETE FROM videos WHERE id = ?"
        
        #if DEBUG
            print("Giovani - VideoDatabase - deleteVideo -> Executando query: \(query)")
        #endif
        
        // Tenta dar o update no db
        return super.database.executeUpdate(query, withArgumentsInArray: [NSNumber(int: video.videoID!)])
    }
    
    // E vc ow desgracadaa!!!! Se vc nao for pra master vai apanhas
    func deleteVideoName(video: String) -> Bool {
        // Defer mais uma vez
        defer {
            super.closeDatabase()
        }
        // Abre conexao
        super.openDatabase()
        
        // Preparando a query
        let query = "DELETE FROM videos WHERE name = ?"
        
        #if DEBUG
            print("Giovani - VideoDatabase - deleteVideo -> Executando query: \(query)")
        #endif
        
        // Tenta dar o update no db
        return super.database.executeUpdate(query, withArgumentsInArray: [video])
    }

}
