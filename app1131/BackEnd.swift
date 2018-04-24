//
//  BackEnd.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 11/23/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//
//  Coloquei o nome de backend pq eu nao tinha ideia melhor kkkkkkkkkkkkk
//  Essa classe aqui vai fazer a abstracao de tudo para a camila

class BackEnd: NSObject {
    
    // MARK: Abstraction
    // Pra acessar ambos os servicos
    let request = Request()
    let amazon = AmazonManager()
    
    // MARK: ID do usuario
    // Queria iniciar ela com um operador ternario, mas nao sei como fazer isso em swift
    // let userID = NSUserDefaults...NomeDaVarDoID ? valor do que ta no user defaults : nil
    func getUserID() -> Int{
        // Buscar do NSUserDefaults
        return NSUserDefaults.standardUserDefaults().integerForKey("userid")
    }
    
    // MARK: User
    // Me questiono da utilidade desse metodo
    func getUserInformation(user: UserModel, completionHandler:(UserModel) -> ()){
        self.request.getUserInformations(user, completionHandler: completionHandler)
    }
    
    func registerUser(user: UserModel, completionHandler:(UserModel) -> ()) {
        // Simplesmente chama o metodo la, Faz isso pra tudo ser abstraido nesse classe
        self.request.newUser(user, completionHandler: completionHandler)
    }
    
    // "Loga" um usuario ja cadastrado no sistema
    func login(user: UserModel, completionHandler:(UserModel) -> ()){
        self.request.loginUser(user, completionHandler: completionHandler)
    }
    
    func deactivateAccount(completionHandler:() -> ()){
        // Mesma coisa da de cima
        self.request.deactivateAccount(self.getUserID(), completionHandler: completionHandler)
    }
    
    func updateUserInformation(user: UserModel, completionHandler:() -> ()){
        // Tudo relacionado a usuario nao tem mto o que fazer nao, é isso msm
        self.request.updateAccount(user, completionHandler: completionHandler)
    }
    
    // MARK: User - Followers
    // Retorna os seguidores de um usuario
    func getUserFollowers(user: UserModel, completionHandler:(Array<UserModel>) -> ()){
        self.request.getFollowers(user, completionHandler: completionHandler)
    }
    
    // Retorna quem o usuario esta seguindo
    func getUserFollows(user: UserModel, completionHandler:(Array<UserModel>) -> ()){
        self.request.getFollowing(user, completionHandler: completionHandler)
    }
    
    // Segue outro usuario
    func follow(user: UserModel, completionHandler:() -> ()){
        self.request.followUser(self.getUserID(), user: user, completionHandler: completionHandler)
    }
    
    // Deixa de seguir um usuario
    func unfollow(user: UserModel, completionHandler:() -> ()){
        self.request.unfollowUser(self.getUserID(), user: user, completionHandler: completionHandler)
    }
    
    // MARK: Video
    func uploadStoryContinuation(video: VideoModelShow, parent: VideoModelNetwork, completionHandler:(Float) -> ()){
        #if DEBUG
            print("Giovani - BackEnd - uploadStoryContinuation -> Setando o parent do video")
        #endif
        // Downcast para modelNetwork
        let vid = video as! VideoModelNetwork
        vid.parent = parent
        
        #if DEBUG
            print("Giovani - BackEnd - uploadStoryContinuation -> Comecando requisicao pro nosso server")
        #endif
        // Faz o cadastro no nosso db
        self.request.newVideo(self.getUserID(), video: vid, completionHandler: { vidID in
            #if DEBUG
                print("Giovani - BackEnd - uploadStoryContinuation -> Iniciando bloco de complemento do Giovani")
                print("Giovani - BackEnd - uploadStoryContinuation -> Comecando o upload do video de id \(vidID) para a amazon")
            #endif
            
            // manda fazer o upload para a amazon
            self.amazon.uploadVideoForKey(video, key: vidID, completionHandler: completionHandler)
            
            #if DEBUG
                print("Giovani - BackEnd - uploadStoryContinuation -> Comecando o upload da thumbnail do video de id \(vidID) para a amazon")
            #endif
            
            // Fazendo o upload da thumbnail do video
            
        })
    }
    // Upload de video sem ser continuacao
    func uploadNewStory(video: VideoModelShow, completionHandler:(Float) -> ()){
        let vid = VideoModelNetwork(name: video.name, level: video.level, time: video.length)
        
        #if DEBUG
            print("Giovani - BackEnd - uploadNewStory -> Comecando requisicao pro nosso server")
        #endif
        
        // Cadastra no nosso server
        self.request.newVideo(self.getUserID(), video: vid, completionHandler: { vidID in
            #if DEBUG
                print("Giovani - BackEnd - uploadNewStory -> Iniciando bloco de complemento do Giovani")
                print("Giovani - BackEnd - uploadNewStory -> Comecando o upload do video de id \(vidID) para a amazon")
            #endif
            // manda fazer o upload
            self.amazon.uploadVideoForKey(video, key: vidID, completionHandler: completionHandler)
        })
    }
    
    // Busca todos os videos que sao filhos do video desejado
    func getSubVideosFromVideo(video: VideoModelNetwork, completionHandler:(Array<VideoModelNetwork>) -> ()){
        self.request.getFilhos(video, completionHandler: completionHandler)
    }
    
    // Busca todos os videos de um usuario
    func getUserVideos(user: UserModel, completionHandler:(Array<VideoModelNetwork>) -> ()){
        self.request.getUserVideos(user, completionHandler: completionHandler)
    }
    
    // Buscar o video na amazon
    func downloadVideo(video: VideoModelNetwork, completionHandler:(VideoModelNetwork) -> ()){
        self.amazon.downloadVideo(video, completionHandler: completionHandler)
    }
    
    // Download da thumbnail
    func downloadThumbnailOfVideo(video: VideoModelNetwork, completionHandler:(VideoModelNetwork) -> ()){
        self.amazon.downloadThumbnailOfVideo(video, completionHandler: completionHandler)
    }
    
    // Esse eu nao preciso fazer mta coisa pq vou tentar fazer a comunicacao entre os servidores
    func deleteVideo(video: VideoModelNetwork, completionHandler:() -> ()){
        self.request.deleteVideo(self.getUserID(), video: video, completionHandler: completionHandler)
    }
    
    func getVideosFromFollowedUsers(completionHandler:(Array<VideoModelNetwork>) -> ()){
        self.request.getFeed(self.getUserID(), completionHandler: completionHandler)
    }
    
    // Esse metodo vai servir pra quando buscar todos os videos de um usuario e a pessoa escolher assistir um video
    // Pq ai vai precisar das informacoes do pai e etc do video
    func getVideoInformation(video: VideoModelNetwork, completionHandler:(VideoModelNetwork) -> ()){
        self.request.findVideoByID(video, completionHandler: completionHandler)
    }
    
}
