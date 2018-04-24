//
//  AppDelegate.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/7/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Copia o banco de dados na primeira vez que executa a aplicacao
        copyIfNeeded("SemNome", type: "sqlite", toPath: Constants.path.database)
        
        let cami = VideoModelCamiTretas(name: "musica", level: VideoConfig.level.hard, time: VideoConfig.length.infinite)
        let vdao = VideoDAO()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: Copying Itens
    // Copia um determinado resource para um determinado path selecionado
    func copyIfNeeded(fileName: String, type: String, toPath: String) -> Bool{
        #if DEBUG
            print(toPath)
        #endif
        // Verifica se o arquivo ainda não existe
        if !NSFileManager.defaultManager().fileExistsAtPath(toPath) {
            do {
                // Cria os diretórios para o arquivo se necessário
                try NSFileManager.defaultManager().createDirectoryAtPath(toPath, withIntermediateDirectories: true, attributes: nil)
                // Busca o resource escolhido no bundle
                if let sourcePath = NSBundle.mainBundle().pathForResource(fileName, ofType: type) {
                    // Seta o nome do arquivo que sera copiado
                    let path = toPath + "/\(fileName)" + ".\(type)"
                    #if DEBUG
                        print(path)
                    #endif
                    // Copia o arquivo do bundle para o local selecionado
                    try NSFileManager.defaultManager().copyItemAtPath(sourcePath, toPath: path)
                    // Avisa que foi salvo com sucesso
                    return true
                }
                // Se chegou aqui é pq deu ruim
                return false
            // Tratar caso nao de certo a copia
            } catch {
                // Nao sei o que por aqui, se der erro é pq deu alguma merda que a gente nao tem como arrumar em tempo de execucao kkkk
                return false
            }
        }
        // O arquivo já existe
        return true
    }
}

