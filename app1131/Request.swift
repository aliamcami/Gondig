//
//  Request.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 11/18/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import Alamofire

class Request: NSObject {
    // Constante do link do servidor
    let server : String = "http://172.16.2.113:3000/"
    
    // MARK: GET
    // Busca as informações de um determinado video(?)
    // Nao sei se é necessário, mas como disponibilizei no server, vou utilizar aqui
    // /videos/:id
    func findVideoByID(video: VideoModelNetwork, completionHandler:(VideoModelNetwork) -> ()){
        // Adicionando os endpoints do video
        let url = self.server + "videos/\(video.videoID!)"
        
        #if DEBUG
            print("Giovani - Request - findVideobyID -> Realizando GET em \(url)")
        #endif
    
        // Realizando uma requisicao get ao server buscando informacoes do video pelo id
        Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - findVideobyID -> Requisicao finalizada! Executando bloco de complemento!")
            #endif
        
            if let JSON = response.result.value {
                #if DEBUG
                    print("Giovani - Request - findVideobyID -> Iniciando o parse do JSON")
                #endif
                
                let video = self.parseVideosJson(JSON as! Dictionary<String, NSObject>)
                
                #if DEBUG
                    print("Giovani - Request - findVideobyID -> Finalizado o parse do JSON")
                    print("Giovani - Request - findVideobyID -> Chamando o bloco da Camila")
                #endif
                
                // Passa pra camila as tretas parseadas
                completionHandler(video)
                
                #if DEBUG
                    print("Giovani - Request - findVideobyID -> Fim da execucao do bloco da camila")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - findVideobyID -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // Busca todos os filhos de um determinado video
    func getFilhos(video: VideoModelNetwork, completionHandler:(Array<VideoModelNetwork>) -> ()){
        // Adicionando os endpoits necessarios a url
        let url = self.server + "videos/\(video.videoID!)/subs"
        
        #if DEBUG
            print("Giovani - Request - getFilhos -> Realizando GET em \(url)")
        #endif
        
        Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - getFilhos -> Requisicao finalizada! Executando bloco de complemento.")
            #endif
            
            if let JSON = response.result.value {
                #if DEBUG
                    print("Giovani - Request - getFilhos -> Iniciando o parse do JSON")
                #endif
                
                let x = JSON as! Array<Dictionary<String, NSObject>>
                var videos = Array<VideoModelNetwork>()
                
                // Acessando todos os videos
                for video in x {
                    // Parseando o video
                    videos.append(self.parseVideosJson(video))
                }
                
                #if DEBUG
                    print("Giovani - Request - getFilhos -> Finalizado o parse do JSON")
                    print("Giovani - Request - getFilhos -> Chamando o bloco da Camila")
                #endif
                
                // Passa pra camila as tretas parseadas
                completionHandler(videos)
                
                #if DEBUG
                    print("Giovani - Request - getFeed -> Fim da execucao do bloco da camila")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - getFilhos -> Fim do bloco de complemento.")
            #endif
        })
    }
    
    // /users/:user_id/followers
    func getFollowers(user: UserModel, completionHandler:(Array<UserModel>) -> ()){
        // Adicionando os endpoints para busca
        let url = self.server + "users/\(user.userID!)/followers"
        
        #if DEBUG
            print("Giovani - Request - getFollowers -> Realizando GET em \(url)")
        #endif
        
        // Realizando uma requisicao get ao server buscando informacoes do video pelo id
        Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - getFollowers -> Query finalizada! Executando bloco de complemento!")
            #endif
            
            if let JSON = response.result.value {
                #if DEBUG
                    print("Giovani - Request - getFollowers -> Iniciando o parse do JSON")
                #endif
                
                let x = JSON as! Array<Dictionary<String, NSObject>>
                var users = Array<UserModel>()
                
                // Acessando todos os videos
                for usuario in x {
                    // Parseando o id do video
                    let uid = usuario["id"] as! Int
                    
                    #if DEBUG
                        print("Giovani - Request - getFollowers -> Parseando o user de id \(uid)")
                    #endif
                    
                    // Parseando as outras informacoes
                    let username = usuario["username"] as! String
                    
                    let u = UserModel(userID: uid, username: username)
                    users.append(u)
                    
                    #if DEBUG
                        print("Giovani - Request - getFollowers -> Finalizado o parse do usuario de id \(uid)")
                    #endif
                }
                
                #if DEBUG
                    print("Giovani - Request - getFollowers -> Finalizado o parse do JSON")
                    print("Giovani - Request - getFollowers -> Chamando o bloco da Camila")
                #endif
                
                // Passa pra camila as tretas parseadas
                completionHandler(users)
                
                #if DEBUG
                    print("Giovani - Request - getFollowers -> Fim da execucao do bloco da camila")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - getFollowers -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // /users/:user_id/following
    func getFollowing(user: UserModel, completionHandler:(Array<UserModel>) -> ()){
        // Adicionando os endpoints para busca
        let url = self.server + "users/\(user.userID!)/following"
        
        #if DEBUG
            print("Giovani - Request - getFollowing -> Realizando GET em \(url)")
        #endif
        
        // Realizando uma requisicao get ao server buscando informacoes do video pelo id
        Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - getFollowing -> Query finalizada! Executando bloco de complemento!")
            #endif
            
            if let JSON = response.result.value {
                #if DEBUG
                    print("Giovani - Request - getFollowing -> Iniciando o parse do JSON")
                #endif
                
                let x = JSON as! Array<Dictionary<String, NSObject>>
                var users = Array<UserModel>()
                
                // Acessando todos os videos
                for usuario in x {
                    // Parseando o id do video
                    let uid = usuario["id"] as! Int
                    
                    #if DEBUG
                        print("Giovani - Request - getFollowing -> Parseando o user de id \(uid)")
                    #endif
                    
                    // Parseando as outras informacoes
                    let username = usuario["username"] as! String
                    
                    let u = UserModel(userID: uid, username: username)
                    users.append(u)
                    
                    #if DEBUG
                        print("Giovani - Request - getFollowing -> Finalizado o parse do usuario de id \(uid)")
                    #endif
                }
                
                #if DEBUG
                    print("Giovani - Request - getFollowing -> Finalizado o parse do JSON")
                    print("Giovani - Request - getFollowing -> Chamando o bloco da Camila")
                #endif
                
                // Passa pra camila as tretas parseadas
                completionHandler(users)
                
                #if DEBUG
                    print("Giovani - Request - getFollowing -> Fim da execucao do bloco da camila")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - getFollowing -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // /users/:id/feed
    // Busca todo o feed de videos
    // Ou seja, busca todos os videos produzidos pelos seguidores
    func getFeed(userID: Int, completionHandler:(Array<VideoModelNetwork>) -> ()){
        // Adicionando os endpoits para buscar o feed
        let url = self.server + "users/\(userID)/feed"
        
        #if DEBUG
            print("Giovani - Request - getFeed -> Realizando GET em \(url)")
        #endif
        
        Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - getFeed -> Inicio da execucao do bloco de complemento")
            #endif
        
            if let JSON = response.result.value {
                #if DEBUG
                    print("Giovani - Request - getFeed -> Iniciando o parse do JSON")
                #endif
                
                let x = JSON as! Array<Dictionary<String, NSObject>>
                var videos = Array<VideoModelNetwork>()
                
                // Acessando todos os videos
                for video in x {
                    // Parseando o video
                    videos.append(self.parseVideosJson(video))
                }
                
                #if DEBUG
                    print("Giovani - Request - getFeed -> Finalizado o parse do JSON")
                    print("Giovani - Request - getFeed -> Chamando o bloco da Camila")
                #endif
                
                // Passa pra camila as tretas parseadas
                completionHandler(videos)
                
                #if DEBUG
                    print("Giovani - Request - getFeed -> Fim da execucao do bloco da camila")
                #endif
            }
            #if DEBUG
                print("Giovani - Request - getFeed -> Fim da execucao do bloco de complemento")
            #endif
        })
    }
    
    // Buscar as informacoes de um determinado usuario
    // Nao sei se esse metodo vai ser utilizado em algum momento, mas to dando suporte
    // Vai que precisa ne?
    // /users/:id
    func getUserInformations(user: UserModel, completionHandler:(UserModel) -> ()){
        // Adicionando os endpoits
        let url = self.server + "users/\(user.userID!)"
        
        #if DEBUG
            print("Giovani - Request - getUserInformations -> Realizando GET em \(url)")
        #endif
        
        Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - getUserInformations -> Query finalizada! Executando bloco de complemento!")
            #endif
            
            if let JSON = response.result.value {
                let u = UserModel(userID: JSON["id"] as! Int, username: JSON["username"] as! String)
                
                #if DEBUG
                    print("Giovani - Request - getUserInformations -> Chamando o bloco da camila")
                #endif
                
                // Chamando o bloco da camila
                completionHandler(u)
                
                #if DEBUG
                    print("Giovani - Request - getUserInformations -> Fim do bloco da camila")
                #endif
            }
            // Tratar erro se pá
            #if DEBUG
                print("Giovani - Request - getUserInformations -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // /users/:id/videos
    func getUserVideos(user: UserModel, completionHandler:(Array<VideoModelNetwork>) -> ()){
        // Adicionando os endpoints
        let url = self.server + "users/\(user.userID!)/videos"
        
        #if DEBUG
            print("Giovani - Request - getUserVideos -> Realizando GET em \(url)")
        #endif
        
        Alamofire.request(.GET, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - getUserVideos -> Query finalizada! Executando bloco de complemento!")
            #endif
            
            if let JSON = response.result.value{
                #if DEBUG
                    print("Giovani - Request - getUserVideos -> Iniciando o parse do JSON")
                #endif
                
                let x = JSON as! Array<Dictionary<String, NSObject>>
                var videos = Array<VideoModelNetwork>()
                
                // Acessando todos os videos
                for video in x {
                    // Parseando o id do video
                    let vid = video["id"] as! Int
                    
                    #if DEBUG
                        print("Giovani - Request - getUserVideos -> Parseando o video de id \(vid)")
                    #endif
                    
                    // Parseando as outras informacoes
                    let name = video["name"] as! String
                    let level = video["level"] as! Int
                    let length = video["length"] as! Int
                    
                    let v = VideoModelNetwork(videoID: Int32(vid), name: name, level: VideoConfig.level(rawValue: level)!, time: VideoConfig.length(rawValue: length)!)
                    
                    videos.append(v)
                    
                    #if DEBUG
                        print("Giovani - Request - getUserVideos -> Finalizado o parse do video de id \(vid)")
                    #endif
                }
                #if DEBUG
                    print("Giovani - Request - getUserVideos -> Chamando o bloco da camila")
                #endif
                
                // Chamando o bloco da camila
                completionHandler(videos)
                
                #if DEBUG
                    print("Giovani - Request - getUserVideos -> Fim do bloco da camila")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - getUserVideos -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // MARK: POST
    // Cadastra o video no servidor
    // /users/:id/videos
    func newVideo(userID: Int, video: VideoModelNetwork, completionHandler:(String) -> ()){
        // Setando os endpoits
        let url = self.server + "users/\(userID)/videos"
        
        #if DEBUG
            print("Giovani - Request - newVideo -> Realizando POST em \(url)")
        #endif
        
        Alamofire.request(.POST, url, parameters: video.classDictionary(), encoding: .JSON).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - newVideo -> Requisicao finalizada! Executando bloco de complemento!")
                print("Giovani - Request - newVideo -> Comecando a parsear o JSON")
            #endif
            
            if let JSON = response.result.value {
                // Parseando só o id por enquanto, pq é o identificador que to usando
                let vid = JSON["id"] as! Int
                
                #if DEBUG
                    print("Giovani - Request - newVideo -> Chamando o bloco de complemento do Giovani")
                #endif
                
                // Chamando o meu bloco e fazendo essa treta para transformar o numero em string
                completionHandler("\(vid)")
                
                #if DEBUG
                    print("Giovani - Request - newVideo -> Fim do bloco de complemento do Giovani")
                #endif
            }
            #if DEBUG
                print("Giovani - Request - newVideo -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // /users/:user_id/follows
    func followUser(userID: Int, user: UserModel, completionHandler:() -> ()){
        // Setando os endpoints
        let url = self.server + "users/\(userID)/follows"
        
        let parameters = ["end_user":user.userID!]
        
        #if DEBUG
            print("Giovani - Request - followUser -> Realizando POST em \(url)")
        #endif
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - followUser -> Requisicao finalizada! Executando bloco de complemento!")
                print("Giovani - Request - followUser -> Analisando o retorno da requisicao")
            #endif
            
            if response.response?.statusCode == 201 {
                // Criou com sucesso
                #if DEBUG
                    print("Giovani - Request - followUser -> Chamando o bloco da Camila")
                #endif
                
                // Chamando o bloco da camila
                completionHandler()
                
                #if DEBUG
                    print("Giovani - Request - followUser -> Fim do bloco da Camila")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - followUser -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // /users
    func newUser(user: UserModel, completionHandler:(UserModel) -> ()){
        // Adicionando os endpoints para cadastro de usuario
        let url = self.server + "users"
        
        #if DEBUG
            print("Giovani - Request - newUser -> Realizando POST em \(url)")
        #endif
        
        Alamofire.request(.POST, url, parameters: user.dictForQuery(), encoding: .JSON).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - newUser -> Query finalizada! Executando bloco de complemento!")
                print("Giovani - Request - newUser -> Comecando a parsear o JSON")
            #endif
            
            if let JSON = response.result.value {
                // Colocando o id no user defaults pra facilitar nossa vida e a do userMacaco
                NSUserDefaults.standardUserDefaults().setInteger(JSON["id"] as! Int, forKey: "userid")
                
                let u = UserModel(userID: JSON["id"] as! Int, username: JSON["username"] as! String)
                #if DEBUG
                    print("Giovani - Request - newUser -> Usuário de id \(u.userID!) parseado")
                    print("Giovani - Request - newUser -> Fim do parse do JSON")
                    print("Giovani - Request - newUser -> Chamando o bloco da camila")
                #endif
                
                // Chamando o complemento da camila
                completionHandler(u)
                
                #if DEBUG
                    print("Giovani - Request - newUser -> Fim do bloco da camila")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - newUser -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // Realiza o "login" caso o usuario tenha removido o app
    // user/login
    func loginUser(user: UserModel, completionHandler:(UserModel) -> ()){
        // Adicionando os endpoints para a url
        let url = self.server + "user/login"
        
        #if DEBUG
            print("Giovani - Request - loginUser -> Realizando POST em \(url)")
        #endif
        
        Alamofire.request(.POST, url, parameters: user.dictForQuery(), encoding: .JSON).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - loginUser -> Requisicao finalizada! Executando bloco de complemento.")
                print("Giovani - Request - loginUser -> Comecando a parsear o JSON")
            #endif
            
            if let JSON = response.result.value {
                // Colocando o id no user defaults pra facilitar nossa vida e a do userMacaco
                NSUserDefaults.standardUserDefaults().setInteger(JSON["id"] as! Int, forKey: "userid")
                
                let u = UserModel(userID: JSON["id"] as! Int, username: JSON["username"] as! String)
                
                #if DEBUG
                    print("Giovani - Request - loginUser -> Usuário de id \(u.userID!) parseado")
                    print("Giovani - Request - loginUser -> Fim do parse do JSON")
                    print("Giovani - Request - loginUser -> Chamando o bloco da camila")
                #endif
                
                // Chamando o complemento da camila
                completionHandler(u)
                
                #if DEBUG
                    print("Giovani - Request - loginUser -> Fim do bloco da camila")
                #endif
            }
            #if DEBUG
                print("Giovani - Request - loginUser -> Fim do bloco de Complemento")
            #endif
        })
    }
    
    // MARK: PATCH - UPDATE
    /*
     Atualizar qualquer treta dele
     O servidor dá suporte ao update com PUT tbm
     Mas como nao vai fzr muita diferenca, vou deixar o update so PATCH msm
    
     Vale lembrar que o servidor so permite atualizacao de:
            - email
            - password
            - username
    
     /users/:id
    */
    func updateAccount(user: UserModel, completionHandler: () -> ()){
        // adicionando os endpoints
        let url = self.server + "users/\(user.userID!)"
        
        #if DEBUG
            print("Giovani - Request - updateAccount -> Realizando PATCH em \(url)")
        #endif
        
        Alamofire.request(.PATCH, url, parameters: user.dictForQuery(), encoding: .JSON).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - updateAccount -> Query finalizada! Executando bloco de complemento!")
            #endif
            // 204 - No content
            if response.response?.statusCode == 204 {
                #if DEBUG
                    print("Giovani - Request - updateAccount -> Status code: \(204)")
                    print("Giovani - Request - updateAccount -> Chamando o bloco da camila")
                #endif
                // Chama o handler da camila
                completionHandler()
                
                #if DEBUG
                    print("Giovani - Request - updateAccount -> Fim do bloco da camila")
                #endif
            }else{
                #if DEBUG
                    print("Giovani - Request - updateAccount -> A requisicao falhou")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - updateAccount -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // MARK: DELETE
    // /users/:id/videos/:id
    func deleteVideo(userID: Int, video: VideoModelNetwork, completionHandler:() -> ()){
        // Adicionando os endpoits a query
        let url = self.server + "users/\(userID)/videos/\(video.videoID!)"
        
        #if DEBUG
            print("Giovani - Request - deleteVideo -> Realizando DELETE em \(url)")
        #endif
        
        Alamofire.request(.DELETE, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - deleteVideo -> Requisicao finalizada! Executando bloco de complemento!")
            #endif
            
            if response.response?.statusCode == 204 {
                #if DEBUG
                    print("Giovani - Request - deleteVideo -> Chamando bloco da camila")
                #endif
                
                // Chamando o bloco da camila
                completionHandler()
                
                #if DEBUG
                    print("Giovani - Request - deleteVideo -> Fim do bloco da camila")
                #endif
            } else {
                #if DEBUG
                    print("Giovani - Request - deleteVideo -> Requisicao falhou")
                #endif
                
                // Se pa mostrar um alerta de que falhou
            }
            
            #if DEBUG
                print("Giovani - Request - deleteVideo -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // /users/:user_id/follows
    func unfollowUser(userID: Int, user: UserModel, completionHandler:() -> ()){
        // Setando os endpoints
        let url = self.server + "users/\(userID)/follows"
        
        let parameters = ["end_user":user.userID!]
        
        #if DEBUG
            print("Giovani - Request - unfollowUser -> Realizando POST em \(url)")
        #endif
        
        Alamofire.request(.DELETE, url, parameters: parameters, encoding: .JSON).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - unfollowUser -> Requisicao finalizada! Executando bloco de complemento!")
                print("Giovani - Request - unfollowUser -> Analisando o retorno da requisicao")
            #endif
            
            if response.response?.statusCode == 200 {
                // Criou com sucesso
                #if DEBUG
                    print("Giovani - Request - unfollowUser -> Chamando o bloco da Camila")
                #endif
                
                // Chamando o bloco da camila
                completionHandler()
                
                #if DEBUG
                    print("Giovani - Request - unfollowUser -> Fim do bloco da Camila")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - unfollowUser -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // Desativar a conta dele
    // /users/:id
    func deactivateAccount(userID: Int, completionHandler:() -> ()){
        // Adicionando os endpoints necessarios
        let url = self.server + "users/\(userID)"
        
        #if DEBUG
            print("Giovani - Request - deactivateAccount -> Realizando DELETE em \(url)")
        #endif
        
        Alamofire.request(.DELETE, url).responseJSON(completionHandler: { response in
            #if DEBUG
                print("Giovani - Request - deactivateAccount -> Query finalizada! Executando bloco de complemento!")
            #endif
            
            // 200 - OK
            if response.response?.statusCode == 200 {
                #if DEBUG
                    print("Giovani - Request - deactivateAccount -> Status code: \(200)")
                    print("Giovani - Request - deactivateAccount -> Chamando o bloco da camila")
                #endif
                // Chama o handler da camila
                completionHandler()
                
                #if DEBUG
                    print("Giovani - Request - deactivateAccount -> Fim do bloco da camila")
                #endif
            } else {
                #if DEBUG
                    print("Giovani - Request - deactivateAccount -> Requisicao falhou")
                #endif
            }
            
            #if DEBUG
                print("Giovani - Request - deactivateAccount -> Fim do bloco de complemento")
            #endif
        })
    }
    
    // MARK: Private
    // Parseia Jsons com varios videos
    private func parseVideosJson(JSON: Dictionary<String, NSObject>) -> VideoModelNetwork {
        // Parseando o id do video
        let vid = JSON["id"] as! Int
        
        #if DEBUG
            print("Giovani - Request - parseVideosJson -> Parseando o video de id \(vid)")
        #endif
        
        // Pega os atributos basicos de um video
        let name = JSON["name"] as! String
        let length = JSON["length"] as! Int
        let level = JSON["level"] as! Int
        
        // Instancia o video
        let v = VideoModelNetwork(videoID: Int32(vid), name: name, level: VideoConfig.level(rawValue: level)!, time: VideoConfig.length(rawValue: length)!)
        
        #if DEBUG
            print("Giovani - Request - parseVideosJson -> Parseando o autor do video de id \(vid)")
        #endif
        
        // Variavel auxiliar para parsear o usuario
        let auxAut = JSON["author"] as! Dictionary<String, NSObject>
        
        // Atributos basicos do json dos usuarios
        let uid = auxAut["id"] as! Int
        let username = auxAut["username"] as! String
        // Instancia o usuario
        let u = UserModel(userID: uid, username: username)
        
        // Seta o author do video
        v.author = u
        
        #if DEBUG
            print("Giovani - Request - parseVideosJson -> Fim do parse do autor do video de id \(vid)")
        #endif
        
        // Caso o video tenha pai
        if (JSON["parent"] as? Dictionary<String, NSObject>)  != nil {
            #if DEBUG
                print("Giovani - Request - parseVideosJson -> Parseando o pai do video de id \(vid)")
            #endif
            
            v.parent = parseVideosJson(JSON["parent"] as! Dictionary<String, NSObject>)
            
            #if DEBUG
                print("Giovani - Request - parseVideosJson -> Finalizado o parse do pai do video de id \(vid)")
            #endif
        }
        
        #if DEBUG
            print("Giovani - Request - parseVideosJson -> Finalizado o parse do video de id \(vid)")
        #endif
        
        return v
    }
    
}
