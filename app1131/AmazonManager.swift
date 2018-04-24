//
//  AmazonManager.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 11/10/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

//import UIKit

// Abstrair qualquer treta da Amazon aqui
class AmazonManager: NSObject {
    // MARK: Upload
    // Faz o upload de um video pra os servers da amazon
    // Coloquei o upload do video e da thumbnail junto por preguica de fzr outro msm
    func uploadVideoForKey(video: VideoModelShow, key: String, completionHandler:(Float) -> ()){
        #if DEBUG
            print("Giovani - AmazonManager - uploadVideoForKey -> Configurando parametros para enviar video")
        #endif
        
        // Upload do video
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest.bucket = Constants.amazon.bucket
        uploadRequest.key = key + Constants.fileType.video
        uploadRequest.body = video.videoUrl
        
        #if DEBUG
            print("Giovani - AmazonManager - uploadVideoForKey -> Comecando o upload do video")
        #endif
        AWSS3TransferManager.defaultS3TransferManager().upload(uploadRequest).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: {
            (task: AWSTask!) -> AWSTask! in
            
            #if DEBUG
                print("Giovani - AmazonManager - uploadVideoForKey -> Comecando a executar o bloco de continuacao do video")
            #endif
            
            if ((task.error) != nil) {
                #if DEBUG
                    print("Giovani - AmazonManager - uploadVideoForKey -> Algum erro aconteceu durante o upload do video")
                #endif
                
                if task.error.domain == AWSS3TransferManagerErrorDomain{
                    switch (task.error.code) {
                    case AWSS3TransferManagerErrorType.Cancelled.rawValue:
                        #if DEBUG
                            print("Giovani - AmazonManager - uploadVideoForKey -> Upload do video cancelado")
                        #endif
                        break
                    case AWSS3TransferManagerErrorType.Paused.rawValue:
                        #if DEBUG
                            print("Giovani - AmazonManager - uploadVideoForKey -> Upload do video Pausado")
                        #endif
                        break
                    default:
                        #if DEBUG
                            print("Giovani - AmazonManager - uploadVideoForKey -> Erro nao tratado: \(task.error)")
                        #endif
                        break;
                    }
                } else {    // Erro desconhecido
                    #if DEBUG
                        print("Giovani - AmazonManager - uploadVideoForKey -> Erro desconhecido: \(task.error)")
                    #endif
                }
            }
            // Ver o que da pra fazer com o output
            if ((task.result) != nil) {
                #if DEBUG
                    print("Giovani - AmazonManager - uploadVideoForKey -> Upload do video feito com sucesso!")
                #endif
                
                let uploadOutput = task.result as! AWSS3TransferManagerUploadOutput
                // The file uploaded successfully.
                #if DEBUG
                    print(uploadOutput)
                #endif
            }
            #if DEBUG
                print("Giovani - AmazonManager - uploadVideoForKey -> Fim do bloco de continuacao do video")
            #endif
            
            return nil
        })
        
        #if DEBUG
            print("Giovani - AmazonManager - uploadVideoForKey -> Configurando parametros para enviar a thumbnail")
        #endif
        
        let thumbRequest = AWSS3TransferManagerUploadRequest()
        thumbRequest.bucket = Constants.amazon.bucket
        thumbRequest.key = key + Constants.fileType.thumbnail
        thumbRequest.body = video.thumbUrl
        
        #if DEBUG
            print("Giovani - AmazonManager - uploadVideoForKey -> Comecando o upload da thumbnail")
        #endif
        AWSS3TransferManager.defaultS3TransferManager().upload(thumbRequest).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: {
            (task: AWSTask!) -> AWSTask! in
            
            #if DEBUG
                print("Giovani - AmazonManager - uploadVideoForKey -> Comecando a executar o bloco de continuacao da thubmanil")
            #endif
            
            if ((task.error) != nil) {
                #if DEBUG
                    print("Giovani - AmazonManager - uploadVideoForKey -> Algum erro aconteceu durante o upload da thumbnail")
                #endif
                
                if task.error.domain == AWSS3TransferManagerErrorDomain{
                    switch (task.error.code) {
                    case AWSS3TransferManagerErrorType.Cancelled.rawValue:
                        #if DEBUG
                            print("Giovani - AmazonManager - uploadVideoForKey -> Upload da thubmnail cancelado")
                        #endif
                        break
                    case AWSS3TransferManagerErrorType.Paused.rawValue:
                        #if DEBUG
                            print("Giovani - AmazonManager - uploadVideoForKey -> Upload da thumbnail Pausado")
                        #endif
                        break
                    default:
                        #if DEBUG
                            print("Giovani - AmazonManager - uploadVideoForKey -> Erro nao tratado: \(task.error)")
                        #endif
                        break;
                    }
                } else {    // Erro desconhecido
                    #if DEBUG
                        print("Giovani - AmazonManager - uploadVideoForKey -> Erro desconhecido: \(task.error)")
                    #endif
                }
            }
            // Ver o que da pra fazer com o output
            if ((task.result) != nil) {
                #if DEBUG
                    print("Giovani - AmazonManager - uploadVideoForKey -> Upload da thumbnail feito com sucesso!")
                #endif
                
                let uploadOutput = task.result as! AWSS3TransferManagerUploadOutput
                // The file uploaded successfully.
                #if DEBUG
                    print(uploadOutput)
                #endif
            }
            #if DEBUG
                print("Giovani - AmazonManager - uploadVideoForKey -> Fim do bloco de continuacao da thumbnail")
            #endif
            
            return nil
        })
    }
    
    // MARK: Download
    // Ja o download vai ser separado
    // Esse aqui baixa so o video
    func downloadVideo(video: VideoModelNetwork, completionHandler:(VideoModelNetwork) -> ()){
        #if DEBUG
            print("Giovani - AmazonManager - downloadVideo -> Configurando parametros para fazer download video")
        #endif
        
        // Configurando aonde o video vai ser armazenado
        // let downloadingFilePath = video.videoUrl!.path!   // URL de download do video
        let downloadingFileUrl = video.videoUrl!
        
        // Download Request
        let downloadRequest = AWSS3TransferManagerDownloadRequest()
        
        downloadRequest.bucket = Constants.amazon.bucket
        downloadRequest.key = String(video.videoID!) + Constants.fileType.video           // Key do video
        downloadRequest.downloadingFileURL = downloadingFileUrl
        
        #if DEBUG
            print("Giovani - AmazonManager - downloadVideo -> Preparando para baixar o video para \(video.videoUrl!)")
        #endif
        // Faz o download
        AWSS3TransferManager.defaultS3TransferManager().download(downloadRequest).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withSuccessBlock: {
            (task: AWSTask!) -> AWSTask! in
            
            #if DEBUG
                print("Giovani - AmazonManager - downloadVideo -> Comecando a executar o bloco de continuacao da amazon")
            #endif
            
            if ((task.error) != nil) {
                #if DEBUG
                    print("Giovani - AmazonManager - downloadVideo -> Algum erro aconteceu")
                #endif
                
                if task.error.domain == AWSS3TransferManagerErrorDomain{
                    switch (task.error.code) {
                    case AWSS3TransferManagerErrorType.Cancelled.rawValue:
                        #if DEBUG
                            print("Giovani - AmazonManager - downloadVideo -> Download cancelado")
                        #endif
                        break
                    case AWSS3TransferManagerErrorType.Paused.rawValue:
                        #if DEBUG
                            print("Giovani - AmazonManager - downloadVideo -> Download pausado")
                        #endif
                        break
                    default:
                        #if DEBUG
                            print("Giovani - AmazonManager - downloadVideo -> Erro nao tratado: \(task.error)")
                        #endif
                        break;
                    }
                } else {
                    // Unknown error.
                    #if DEBUG
                        print("Giovani - AmazonManager - downloadVideo -> Erro desconhecido: \(task.error)")
                    #endif
                }
            }
            // Download feito com sucesso
            if ((task.result) != nil) {
                // The file downloaded successfully.
                let downloadOutput = task.result as! AWSS3TransferManagerDownloadOutput
                #if DEBUG
                    print("Giovani - AmazonManager - downloadVideo -> Download relizado com sucesso")
                    print(downloadOutput)
                    print("Giovani - AmazonManager - downloadVideo -> Chamando o bloco da Camila")
                #endif
                
                // Chamando o bloco da camila
                completionHandler(video)
            }
            #if DEBUG
                print("Giovani - AmazonManager - downloadVideo -> Fim do bloco de continuacao da amazon")
            #endif
            
            return nil
        })
    }
    
    // E esse aqui baixa só a thumbnail
    func downloadThumbnailOfVideo(video: VideoModelNetwork, completionHandler:(VideoModelNetwork) -> ()){
        #if DEBUG
            print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Configurando parametros para fazer download da thumbnail")
        #endif
        
        // Configurando aonde o video vai ser armazenado
        // let downloadingFilePath = video.videoUrl!.path!   // URL de download do video
        let downloadingFileUrl = video.thumbUrl!
        
        // Download Request
        let downloadRequest = AWSS3TransferManagerDownloadRequest()
        
        downloadRequest.bucket = Constants.amazon.bucket
        downloadRequest.key = String(video.videoID!) + Constants.fileType.thumbnail            // Key do video
        downloadRequest.downloadingFileURL = downloadingFileUrl
        
        #if DEBUG
            print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Preparando para baixar a thubmnail para \(video.thumbUrl!)")
        #endif
        // Faz o download
        AWSS3TransferManager.defaultS3TransferManager().download(downloadRequest).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withSuccessBlock: {
            (task: AWSTask!) -> AWSTask! in
            
            #if DEBUG
                print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Comecando a executar o bloco de continuacao da amazon")
            #endif
            
            if ((task.error) != nil) {
                #if DEBUG
                    print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Algum erro aconteceu")
                #endif
                
                if task.error.domain == AWSS3TransferManagerErrorDomain{
                    switch (task.error.code) {
                    case AWSS3TransferManagerErrorType.Cancelled.rawValue:
                        #if DEBUG
                            print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Download cancelado")
                        #endif
                        break
                    case AWSS3TransferManagerErrorType.Paused.rawValue:
                        #if DEBUG
                            print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Download pausado")
                        #endif
                        break
                    default:
                        #if DEBUG
                            print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Erro nao tratado: \(task.error)")
                        #endif
                        break;
                    }
                } else {
                    // Unknown error.
                    #if DEBUG
                        print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Erro desconhecido: \(task.error)")
                    #endif
                }
            }
            // Download feito com sucesso
            if ((task.result) != nil) {
                // The file downloaded successfully.
                let downloadOutput = task.result as! AWSS3TransferManagerDownloadOutput
                #if DEBUG
                    print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Download relizado com sucesso")
                    print(downloadOutput)
                    print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Chamando o bloco da Camila")
                #endif
                
                // Chamando o bloco da camila
                completionHandler(video)
            }
            #if DEBUG
                print("Giovani - AmazonManager - downloadThumbnailOfVideo -> Fim do bloco de continuacao da amazon")
            #endif
            
            return nil
        })
    }
}
