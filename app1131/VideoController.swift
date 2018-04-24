//
//  VideoController.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/7/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class VideoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate {
    
    let picker = UIImagePickerController()
    var btn = UIButton()
    
    // VideoDAO - Pra testes
    let videoDiskManager = VideoManager()
    let vdao = VideoDAO()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.btn.frame = CGRectMake(0, 0, 100, 100)
        self.btn.center = CGPointMake(self.view.center.x, self.view.center.y)
        self.btn.backgroundColor = UIColor.blackColor()
        self.btn.addTarget(self, action: "selectVideo", forControlEvents: .TouchUpInside)
//        self.view.addSubview(self.btn)
        
        self.picker.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: AQUI CAMILA
        let v = self.vdao.getAllVideos().first!
        let interaction = UIDocumentInteractionController(URL: v.videoUrl!)
        interaction.UTI = "public.movie"
        interaction.delegate = self
        if interaction.presentOpenInMenuFromRect(CGRectZero, inView: super.view, animated: true){
            print("Foi")
        }
    }
    

    // MARK: Support Methods
    func selectVideo(){
        self.picker.allowsEditing = false
        self.picker.sourceType = .PhotoLibrary
        self.picker.mediaTypes = [kUTTypeMovie as String]
        // Se pa incluir mediatype
        presentViewController(self.picker, animated: true, completion: nil)
    }


    // Retorna a thumbnail de um determinado video em uma determinada url
    func getThumbnailOfVideoAt(url: NSURL) -> UIImage{
        // Gera um AVAsset baseado na url
        let asset = AVURLAsset(URL: url)
        
        // Cria um gerador de imagem baseado no Asset de cima
        let generator = AVAssetImageGenerator(asset: asset)
        
        // Setando um tamanho maximo pra thumbnail 
        let maxSize = CGSizeMake(200, 113)
        generator.maximumSize = maxSize
        
        // Nao entendi o que essa budega faz
        let time = CMTimeMake(1, 60)
        
        // Inicia a imagem pq genialmente tudo que é criado dentro do do-try-catch só existe dentro do escopo do Do (Du'oh)
        var image = UIImage()
        
        // Iniciando a linda estrutura do do-try-catch
        do {
            // Gerando a referencia para a imagem atraves do gerador
            let imgRef = try generator.copyCGImageAtTime(time, actualTime: nil)
            
            // Pegando a imagem atraves da referencia
            image = UIImage(CGImage: imgRef)
        // Tenho que tratar os erros direito
        } catch {
            print("Erro durante a captura da CGImage")
        }
        // Retorna a imagem
        return image
    }
}
