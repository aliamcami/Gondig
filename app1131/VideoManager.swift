//
//  VideoManager.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/16/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class VideoManager: NSObject {
    // MARK: Propertys
    
    // MARK: Save Video in Roll
    // Verificar se o nome do video vai vir com a extensao .mp4 ou eu tenho que colocar aqui
    func saveVideoToCameraRoll(videoName: String){
        // Pega o path para o video
        let videoPath = Constants.path.videos + videoName + Constants.fileType.video
        // Salva o video no rolo da camera, acho que esse método foi mal construido, podia retornar um boolean, no mínimo
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil)
    }
    
    // MARK: Get Thumbnails
    // Funcao para pegar todo o conteudo dentro do diretorio
    func getAllThumbnails() -> Array<UIImage> {
        // Inicializando o array com as thumbnails
        var allThumb = Array<UIImage>()
        do {
            #if DEBUG
                print("Giovani - VideoManager - getAllThumbnail -> Iniciando a busca em disco")
            #endif
            // Buscando o nome de todos os arquivos no diretorio
            let contents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(Constants.path.thumbnails)
            // Buscando todas as imagens do diretorio
            for i in contents {
                // Buscando o binario da foto salva em Documents
                if let imgData = NSData(contentsOfFile: Constants.path.thumbnails + i) {
                    // Gerando a thumbnail
                    if let thumbnail = UIImage(data: imgData) {
                        #if DEBUG
                            print("Giovani - VideoManager - getAllThumbnail -> Thubmnail \(i) encontrada no disco")
                        #endif
                        // Adicionando a thumbnail ao array
                        allThumb.append(thumbnail)
                    }
                }
            }
        } catch {
            // Deu alguma treta com o gerenciador de arquivo e a busca falhou
            #if DEBUG
                print("Giovani - VideoManager - getAllThumbnail -> Deu treta no acesso ao disco")
            #endif
        }
        // Retorna as thumbnails
        return allThumb
    }
    
    // MARK: Write Video
    func writeVideoToDocuments(video: VideoModelCamiTretas) -> Bool {
        // Path pro diretorio
        var videopath = Constants.path.videos
        var thumbpath = Constants.path.thumbnails
        
        // Cria os diretorios: Videos e Thumbanil dentro da pasta Documents se nao existir ainda
        if !(NSFileManager.defaultManager().fileExistsAtPath(videopath) && NSFileManager.defaultManager().fileExistsAtPath(thumbpath)) {
            do{
                // Salvando o video no disco
                try NSFileManager.defaultManager().createDirectoryAtPath(videopath, withIntermediateDirectories: true, attributes: nil)
                #if DEBUG
                    print("Giovani - VideoManager - writeVideo... -> Diretorio /Documents/Videos criado com sucesso!")
                #endif
                
                // Salvando a thumbnail em disco
                try NSFileManager.defaultManager().createDirectoryAtPath(thumbpath, withIntermediateDirectories: true, attributes: nil)
                #if DEBUG
                    print("Giovani - VideoManager - writeVideo... -> Diretorio /Documents/Thumbnails criado com sucesso!")
                #endif
            } catch {
                // Avida das tretas
                #if DEBUG
                    print("Giovani - VideoManager - writeVideo... -> Deu merda criando os diretorios")
                #endif
                // Avisa que deu merda
                return false
            }
        }
        
        // Adiciona o nome do video ao path dos diretorios
        videopath += video.name + Constants.fileType.video
        thumbpath += video.name + Constants.fileType.thumbnail
        
        // Verificando a presenca da foto - Ou a possibilidade de falhar buscando o binario da foto
        if let photoData = UIImageJPEGRepresentation(video.thumbnail!, 1) {
            video.getExportSession().outputURL = NSURL(fileURLWithPath: videopath)
            video.getExportSession().exportAsynchronouslyWithCompletionHandler({
                #if DEBUG
                    print("Giovani - VideoManager - writeVideo... -> Finalizando ExportAsynchronous")
                #endif
            
                
                #if DEBUG
                    print("Camila - VideoManager - writeVideo... -> robei seu metodo. adicionando video na collection")
                #endif
                let show = ViewConfig.root.showAll
                if show == nil{
                    #if DEBUG
                        print("Camila - VideoManager - writeVideo... -> nao foi possivel adicionar na collection, showall nil")
                    #endif
                }else{
                    show!.addVideo(VideoModelShow(name: video.name, level: video.level, time: video.length))
                }
            })
            
            // Verifica se conseguiu escrever a thumbnail certinho
            if !photoData.writeToFile(thumbpath, atomically: true) {
                #if DEBUG
                    print("Giovani - VideoManager - writeVideo... -> Deu merda na hora de salvar a thumbnail no disco")
                #endif
                return false
            }
            #if DEBUG
                print("Giovani - VideoManager - writeVideo... -> SALVOOOOOOOOOOU")
            #endif
            // Se chegou ate aqui é pq deu tudo certo
            return true
        }
        // Avisa que deu merda
        #if DEBUG
            print("Giovani - VideoManager - writeVideo... -> Deu merda buscando o binario da imagem")
        #endif
        return false
    }
    
    // MARK:
    func deleteVideoInDocuments(video: VideoModelShow) -> Bool {
        // Tenta apagar os bagulhos
        do {
            // Removendo o video do disco
            try NSFileManager.defaultManager().removeItemAtPath(video.videoUrl!.path!)
            #if DEBUG
                print("Giovani - VideoManager - deleteVideo... -> Video removido do disco com sucesso!")
            #endif
            
            // Removendo a thumbnail do disco
            try NSFileManager.defaultManager().removeItemAtPath(video.thumbUrl!.path!)
            #if DEBUG
                print("Giovani - VideoManager - deleteVideo... -> Thumbnail removida do disco com sucesso!")
            #endif
        } catch {
            // A fim de debug somente, pq se der merda nisso eu nao sei como tratar em tempo de execucao
            #if DEBUG
                print("Giovani - VideoManager - deleteVideo... -> Deu merda na hora de remover do disco")
            #endif
            // Fala que deu merda
            return false
        }
        #if DEBUG
            print("Giovani - VideoManager - deleteVideo... -> Tudo certo! Video removido com sucesso do disco!")
        #endif
        // Se chegou ate aqui ta de boa
        return true
    }
    
    func updateVideoAndThumbnailNAMES(newName : String, originalName : String) -> Bool{
        #if DEBUG
            print("Giovani - VideoManager - updateVideoAndThumbnailNAMES... -> Tentando dar update nos nomes de arquivo... pq sim")
        #endif

        let originPathVideo = Constants.path.videos + originalName + Constants.fileType.video
        let destinationPathVideo =  Constants.path.videos + newName + Constants.fileType.video
        
        let originPathThumbail = Constants.path.thumbnails + originalName + Constants.fileType.thumbnail
        let destinationPathThumbail =  Constants.path.thumbnails + newName + Constants.fileType.thumbnail
        
        do {
           try NSFileManager.defaultManager().moveItemAtPath(originPathVideo,
                toPath: destinationPathVideo)
            try NSFileManager.defaultManager().moveItemAtPath(originPathThumbail ,
                toPath: destinationPathThumbail)
        }catch{
            // A fim de debug somente, pq se der merda nisso eu nao sei como tratar em tempo de execucao (2)
            #if DEBUG
                print("Camila - VideoManager - updateVideoAndThumbnailNAMES... -> Deu merda na hora de mudar nome de algum arquivo... sabe-se la qual =)")
            #endif
            // Fala que deu merda
            return false
        }
        
        #if DEBUG
             print("Camila - VideoManager - updateVideoAndThumbnailNAMES... -> parece que a mudanca dos nomes dos arquivos ta OK. ainda acho que era mais faicl criar um canto separado pro nome de arquivos na DB e esquecer que o nome do video eh o mesmo do nome do arquivo")
        #endif
        return true
   
        
    }
}

