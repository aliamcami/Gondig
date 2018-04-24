//
//  VideoDAO.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/16/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class VideoDAO: NSObject {
    
    // Referencia ao gerenciador de disco e gerenciador de db
    let disk = VideoManager()
    let database = VideoDatabase()
    
    // MARK: Save
    func saveVideo(video: VideoModelCamiTretas) -> Bool {
        #if DEBUG
            print("Giovani - VideoDAO - saveVideo -> Preparando para salvar o video no database...")
        #endif
        if self.database.addVideo(video) {
            #if DEBUG
                print("Giovani - VideoDAO - saveVideo -> Video salvo no database!")
                print("Giovani - VideoDAO - saveVideo -> Preparando pra salvar o video no disco...")
            #endif
            if self.disk.writeVideoToDocuments(video) {
                #if DEBUG
                    print("Giovani - VideoDAO - saveVideo -> O Video \(video.name) foi salvo com sucesso no database e no disco!")
                #endif
                return true
            }
        }
        #if DEBUG
            print("Giovani - VideoDAO - saveVideo -> O Video \(video.name) NAAAAO foi salvo!!!!")
        #endif
        // Se chegar aqui deu merda
        return false
    }
    
    // MARK: Delete
    func deleteVideo(video: VideoModelShow) -> Bool {
        #if DEBUG
            print("Giovani - VideoDAO - deleteVideo -> Preparando para deletar o video no database...")
        #endif
        if self.database.deleteVideo(video) {
            #if DEBUG
                print("Giovani - VideoDAO - deleteVideo -> Video deletado do database!")
                print("Giovani - VideoDAO - deleteVideo -> Preparando para deletar o video no disco...")
            #endif
            if self.disk.deleteVideoInDocuments(video) {
                #if DEBUG
                    print("Giovani - VideoDAO - deleteVideo -> O Video \(video.name) foi deletado com sucesso!")
                #endif
                return true
            }
        }
        #if DEBUG
            print("Giovani - VideoDAO - deleteVideo -> O Video \(video.name) NAAAO foi deletado!!!!")
        #endif
        return false
    }
    
    
    /* porque?
    porque por enquanto eu to adicionando direto um video la na collection sem pegar o ID dele do banco
    logo eu nao posso enviar pro seu deleteVideo pq ele deleta por ID... entao criei um outro q deleta do banco por nome.. sry
    que na verdade soh muda uma linha... LOL
    */
    func deleteVideoName(video: VideoModelShow) -> Bool {
        #if DEBUG
            print("Giovani - VideoDAO - deleteVideo -> Preparando para deletar o video no database...")
        #endif
        //soh chamei aki... por nome... =D
        if self.database.deleteVideoName(video.name) {
            #if DEBUG
                print("camila - VideoDAO - deleteVideo -> Video deletado do database!")
                print("camila - VideoDAO - deleteVideo -> Preparando para deletar o video no disco...")
            #endif
            if self.disk.deleteVideoInDocuments(video) {
                #if DEBUG
                    print("Giovani - VideoDAO - deleteVideo -> O Video \(video.name) foi deletado com sucesso!")
                #endif
                return true
            }
        }
        #if DEBUG
            print("Giovani - VideoDAO - deleteVideo -> O Video \(video.name) NAAAO foi deletado!!!!")
        #endif
        return false
    }
    
    // MARK: Retrieve
    func getAllThumbnails() -> Array<UIImage>? {
        return self.disk.getAllThumbnails()
    }
    
    // Retorna todos os videos
    func getAllVideos() -> Array<VideoModelShow> {
        return self.database.getAllVideos()
    }

}
