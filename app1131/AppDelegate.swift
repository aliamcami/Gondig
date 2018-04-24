//
//  AppDelegate.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/7/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit
import Foundation

infix operator ~> {}
//serial dispatch queue use by ~>
let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)
//execute the left closure on background then the left on main thread

//QUERIA MUITO ter aprendido isso antes
func ~> (
    backgroundClosure : () -> (),
    mainClosure : () -> ()){
        dispatch_async(queue){
            backgroundClosure()
            dispatch_async(dispatch_get_main_queue(), mainClosure)
            
        }
}

let  isloggedIn  = BackEnd().getUserID() == 0 ? false : true
var isCompactDevice : Bool{
    if (ViewConfig.root.root?.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact) {
        // Compact
        return true
    } else {
        // Regular
       return false
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Printa todos os diretorios que serão usados
        #if DEBUG
            print("Giovani - AppDelegate -> Path para os videos: " + Constants.path.videos)
            print("Giovani - AppDelegate -> Path para as thumbnails: " + Constants.path.thumbnails)
            print("Giovani - AppDelegate -> Path para o banco de dados:" + Constants.path.database)
            print("Giovani - AppDelegate -> Tipo dos arquivos de video: " + Constants.fileType.video)
            print("Giovani - AppDelegate -> Tipo dos arquivos de imagem: " + Constants.fileType.thumbnail)
            
            // Seta as tretas da amazon para logarem tudo
            // Comentei pq é log demais
//            AWSLogger.defaultLogger().logLevel = .Verbose
        #endif
        
        //TIRAR ISSO
//        VideoConfig.userPhraseStatus = VideoConfig.phraseStatus.on
//        VideoConfig.userAnimationSize = VideoConfig.animationSize.medium
//        ViewConfig.defaults.setObject(nil, forKey: "instructions")
//        ViewConfig.defaults.removeObjectForKey("userid")
        
        print("---> \(VideoDatabase().getAllVideoNames())")
        
        

//        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Copia o banco de dados na primeira vez que executa a aplicacao
        copyIfNeeded("SemNome", type: "sqlite", toPath: Constants.path.database)
        
        // Tretas da Amazon - Seta as configuracoes - Preciso testar pra ver se funciona beleza sem internet
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: Constants.amazon.region, identityPoolId: Constants.amazon.identityPoolId)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = AWSServiceConfiguration(region: Constants.amazon.region, credentialsProvider: credentialsProvider)
        
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
            print("Giovani - AppDelegate - copyIfNeeded -> Verificando a existencia do arquivo no path... \(toPath + fileName + ".\(type)")")
        #endif
        // Verifica se o arquivo ainda não existe
        if !NSFileManager.defaultManager().fileExistsAtPath(toPath + fileName + ".\(type)") {
            do {
                #if DEBUG
                    print("Giovani - AppDelegate - copyIfNeeded -> Arquivo nao existe")
                    print("Giovani - AppDelegate - copyIfNeeded -> Preparando para criar o diretorio...")
                #endif
                // Cria os diretórios para o arquivo se necessário
                try NSFileManager.defaultManager().createDirectoryAtPath(toPath, withIntermediateDirectories: true, attributes: nil)
                #if DEBUG
                    print("Giovani - AppDelegate - copyIfNeeded -> Diretorio criado!")
                    print("Giovani - AppDelegate - copyIfNeeded -> Buscando o resource no bundle...")
                #endif
                // Busca o resource escolhido no bundle
                if let sourcePath = NSBundle.mainBundle().pathForResource(fileName, ofType: type) {
                    try NSFileManager.defaultManager().createDirectoryAtPath(toPath, withIntermediateDirectories: true, attributes: nil)
                    #if DEBUG
                        print("Giovani - AppDelegate - copyIfNeeded -> Resource buscado com sucesso!")
                        print("Giovani - AppDelegate - copyIfNeeded -> Preparando para copiar o resource para o diretorio...")
                    #endif
                    // Seta o nome do arquivo que sera copiado
                    let path = toPath + "\(fileName)" + ".\(type)"
                    // Copia o arquivo do bundle para o local selecionado
                    try NSFileManager.defaultManager().copyItemAtPath(sourcePath, toPath: path)
                    #if DEBUG
                        print("Giovani - AppDelegate - copyIfNeeded -> Copiou para o path: " + path)
                    #endif
                    // Avisa que foi salvo com sucesso
                    return true
                }
                #if DEBUG
                    print("Giovani - AppDelegate - copyIfNeeded -> Nao achou o resource no bundle")
                #endif
                // Se chegou aqui é pq deu ruim
                return false
            // Tratar caso nao de certo a copia
            } catch {
                #if DEBUG
                    print("Giovani - AppDelegate - copyIfNeeded -> Deu alguma treta no acesso ao disco")
                #endif
                // Nao sei o que por aqui, se der erro é pq deu alguma merda que a gente nao tem como arrumar em tempo de execucao kkkk
                return false
            }
        }
        #if DEBUG
            print("Giovani - AppDelegate - copyIfNeeded -> O arquivo ja existe")
        #endif
        // O arquivo já existe
        return true
    }
    
}

extension String {
    var localized : String{
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}

//queria ter aprendido isso antes
extension UIImage {
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
//        let radiansToDegrees: (CGFloat) -> CGFloat = {
//            return $0 * (180.0 / CGFloat(M_PI))
//        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
        let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        CGContextScaleCTM(bitmap, yFlip, -1.0)
        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

//queria ter aprendido isso antes
extension UIButton {
    func setBackgroundColor(color: UIColor, forState : UIControlState) {
        let rect = CGRectMake(0, 0, self.frame.width, self.frame.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        self.setImage(image, forState: forState)
    }
}





