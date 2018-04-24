//
//  CRPageViewController.swift
//  app1131
//
//  Created by camila oliveira on 10/23/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit


class CRPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var aviewControllers = Array<Pageble>()
    
    let cRCameraControll = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Camera") as! CRCameraControlBridge
    let showAllVideosControll = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ShowAllVideos") as! ShowAllVideosViewController
    var gondigController : GCGenericViewController!
    
    
    override func viewDidLoad() {
        #if DEBUG
            print("camila - CRPageViewController - ViewDidLoad")
        #endif
        super.viewDidLoad()
        
        let isCamera = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        if !isCamera{
            #if DEBUG
                print("camila - CRPageViewController - ViewDidLoad - NO CAMERA AVAILABLE")
            #endif
            let dd = UIStoryboard(
                    name: "Main",
                    bundle: nil
                ).instantiateViewControllerWithIdentifier("noCamera")
            
            self.setViewControllers([dd],
                direction: UIPageViewControllerNavigationDirection.Forward,
                animated: false,
                completion: nil)
            
        }else{
            //VERIFICA SE TA LOGADO, SE NAO TIVER MOSTRA TELA DE LOGIN, SE TIVER MOSTRA SHELF
            if isloggedIn {
                gondigController = UIStoryboard(name: "Network", bundle: nil).instantiateViewControllerWithIdentifier("shelf") as! GCGenericViewController
            }else{
                gondigController = UIStoryboard(name: "Network", bundle: nil).instantiateViewControllerWithIdentifier("loginView") as! GCGenericViewController
            }
            
            
            
            self.dataSource = self
            self.delegate = self
            
            showAllVideosControll.allVideosForCollection = VideoDAO().getAllVideos()
            cRCameraControll.parentController = self
            showAllVideosControll.parentController = self
            
            aviewControllers = [cRCameraControll, showAllVideosControll, gondigController]
            
            //LARGA ISSO AKI, PRA DAR UM PRE LOAD NA PAGINA E NAO DA ERRO QUANDO EU TENTAR ACESSAR AS PARADAS, ANTES DE OFICIALMENTE IR PRA PAGINA. serio, nao tira, da merda. 
            let _ = self.showAllVideosControll.view
            self.showAllVideosControll.loadViewIfNeeded()
            
            self.setViewControllers([aviewControllers[0] as! UIViewController],
                direction: UIPageViewControllerNavigationDirection.Forward,
                animated: false,
                completion: nil)
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func instantiateView(pageIndex : Int)-> UIViewController{
        #if DEBUG
            print("camila - CRPageViewController - instantiateView")
        #endif
        
        var pg = (self.aviewControllers[pageIndex])
        pg.pageIndex = pageIndex
        
        return pg as! UIViewController
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
      
        var index = (viewController as! Pageble).pageIndex
        index++
        if index == aviewControllers.count {
            index = 0
        }
        
        #if DEBUG
            print("camila - CRPageViewController - view after \(index):\(aviewControllers[index])")
        #endif
        
        return instantiateView(index)
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! Pageble).pageIndex
        if index == 0{
            index = aviewControllers.count
        }
        index--
        
        #if DEBUG
            print("camila - CRPageViewController - view before \(index):\(aviewControllers[index])")
        #endif
        
        
        return instantiateView(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        #if DEBUG
            print("camila - CRPageViewController - didFinshAnimating")
        #endif
        
    }
    
    func changeGondigViewTo(newView : GCGenericViewController){
        newView.pageIndex = self.gondigController.pageIndex
        
        //Reseta a view controller para ser a shelf
        self.gondigController = newView
        
        //seta os arrays para nao dar bug escroto e a tela de login continuar existindo
        self.aviewControllers.removeLast()
        self.aviewControllers.append(newView)
        
        //passa a pagina
       self.setViewControllers([newView], direction: UIPageViewControllerNavigationDirection.Reverse, animated: false, completion: nil)
    }
    
    
}
