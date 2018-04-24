//
//  AfterConfirmVideoController.swift
//  app1131
//
//  Created by camila oliveira on 11/17/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit
let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
let root = appDelegate.window?.rootViewController as! CRPageViewController
let showAll = root.showAllVideosControll


class AfterConfirmVideoController: UIViewController {
    //get instancia da storyModel show

//    let originalCount = showAll.allVideosForCollection.count
    
    
    var storyModel : VideoModelShow!{
        didSet{
            #if DEBUG
                print("camila - AfterConfirmVideoController - setting storyModel SHOW, reabilitando botoes")
            #endif
            
            //quaaando terminar de exportar, seta eessa porra, 
            //quando setar essa porra ai habilita todos os botoes de compartilhar e tals e pah.... 
            shareAppButton.model = self.storyModel
            shareNormalButton.model = self.storyModel
            saveCameraRollButton.model = self.storyModel
            
            //setting controller
            shareAppButton.controller = self
            shareNormalButton.controller = self
            saveCameraRollButton.controller = self
            
            //make player
            playerThumbnailView.makePlayer(UITapGestureRecognizer(target: self, action: "makePlayer:"))
            
        }
    }
    var tretas : VideoModelCamiTretas?
    
    @IBOutlet weak var storyTitle: StoryTitleTextField!
    @IBOutlet weak var fowardButton: UIButton!
    @IBOutlet weak var playerThumbnailView: AfterVideoPlayer!
    @IBOutlet weak var barBG: BGBarControllerAfterVideoView!
    
    //botoes la..
    @IBOutlet weak var shareAppButton: AfterVideoButtonGeneric!
    @IBOutlet weak var shareNormalButton: AfterVideoButtonGeneric!
    @IBOutlet weak var saveCameraRollButton: AfterVideoButtonGeneric!
    var saveClass = Save()
    
    var timerReenableButtons : NSTimer?
    //buttons buttons and more buttons
    override func viewDidLoad() {
        
        if tretas == nil {
            #if DEBUG
                print("camila - AfterConfirmVideoController - viewDidLoad - THUMBNAIL NIL, seta antes da segue sua anta. ")
            #endif
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        //SALVAR VIDEO
        //save video
        self.saveClass.save(self.tretas!)
        
        //------------------- observer
        ViewConfig.root.showAll?.addObserver(self, forKeyPath: "allVideosForCollection", options: NSKeyValueObservingOptions.New, context: nil)
        teste = exportFinished
        //-----------------
        
        #if DEBUG
            print("camila - AfterConfirmVideoController - viewDidLoad - tudo certo, seguindo com o load. ")
        #endif
        
        super.viewDidLoad()
        
        //set thumbnaihl
        self.playerThumbnailView.thumbnail = self.tretas?.getThumbnailOfVideoAt()
        
        //title
        self.storyTitle.text = self.tretas?.name
        let gestureTitle = UITapGestureRecognizer(target: self, action: "changeTitle:")
        self.storyTitle.addGestureRecognizer(gestureTitle)
        self.storyTitle.enabled = true
        self.storyTitle.text = ""
        self.barBG.addGestureRecognizer(gestureTitle)
        
        //gesture no resto da tela pra caso clicado dar dismiss no teclado
        let dis = UITapGestureRecognizer(target: self, action: "keyboardDismiss:")
        self.view.addGestureRecognizer(dis)
        
        
        //addgesture to foward action
        let swipe = UISwipeGestureRecognizer(target: self, action: "fowardAction:")
        swipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipe)
        
        
        
        if ViewConfig.instructions.after.hasToShow {
            ViewConfig.instructions.after.set(false)
            self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                "skip" : {
                    self.storyTitle.becomeFirstResponder()
                },
                "next" : {
                    // Do any additional setup after loading the view.
                    self.storyTitle.becomeFirstResponder()
                }
                ], text: "inst_afterVideo1"))
        }else{
            // Do any additional setup after loading the view.
            self.storyTitle.becomeFirstResponder()
        }
        
        
    }
    
    func makePlayer(gesture : UIGestureRecognizer){
        if !storyTitle.enabled{
            self.performSegueWithIdentifier("playVideo", sender: nil)
        }else{
            storyTitle.enabled = false
        }
        
    }
 
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        #if DEBUG
            print("CAMILA - AfterConfirmVideoController - observeValueForKeyPath - terminou de exportar video, reabilitando as porra tudo ")
        #endif
        dispatch_async(dispatch_get_main_queue(), {
            self.teste()
        })
        
        
        ViewConfig.root.showAll?.removeObserver(self, forKeyPath:  "allVideosForCollection", context: nil)

    }
    var teste : (() -> ())!
    
    func exportFinished(){
        #if DEBUGhh
            print("camila - AfterConfirmVideoController - exportFinished  ")
        #endif
        
        if self.tretas?.getExportSession().status == AVAssetExportSessionStatus.Completed{
        
            #if DEBUG
                print("camila - AfterConfirmVideoController -  exportFinished COMPLETE")
            #endif
            
            self.playerThumbnailView.stopActivity()
            
        
            self.storyModel = showAll.allVideosForCollection[0]
            self.view.setNeedsDisplay()
        }
    }
    
    func keyboardDismiss(gesture : UIGestureRecognizer){
            self.storyTitle.enabled = false
//        self.storyTitle.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //faz teclado aparecer
//        self.storyTitle.becomeFirstResponder()
    }

    func changeTitle(gesture: UIGestureRecognizer) {
        self.storyTitle.enabled = true
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideo"{
            let player = segue.destinationViewController as! PlayerStoryViewController
            player.playerItem = self.storyModel
            player.storyTitleEnabled = false
        }

    }
    
    //MARK: Buttons clicked
    
    
    @IBAction func fowardAction(sender: AnyObject) {
        if !storyTitle.enabled{
            #if DEBUG
                print("camila - AfterConfirmVideoController - fowardAction")
            #endif
            if tretas?.name != storyTitle.text{
                if self.storyModel != nil{
                    #if DEBUG
                        print("camila - AfterConfirmVideoController - fowardAction - ja completou o export, mudando titulo")
                    #endif
                    
                    self.storyTitle.changedTitle(self.storyModel)
                    
                }else if tretas != nil{
                    #if DEBUG
                        print("camila - AfterConfirmVideoController - fowardAction - setando timer pra esperar o export terminar e mudar o titulo")
                    #endif
                    
                    self.timerReenableButtons?.invalidate()
                    
                    teste = changeTitleAsynchronous
                }
            }
            
            //dismiss all view controllers independente de onde estejam... ahahah
            //CAMILA tenta setar o pageIndex na mao para o da pagina q ta + 1 foward
//            ViewConfig.root.root?.setViewControllers([ViewConfig.root.showAll!], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
            self.view.window?.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
        }else{
            storyTitle.enabled = false
        }
        
        
    }
    
    func changeTitleAsynchronous (){
        #if DEBUG
            print("camila - AfterConfirmVideoController - changeTitleAsynchronous - virifing if export finished")
        #endif
        if tretas!.getExportSession().status == AVAssetExportSessionStatus.Completed{
            #if DEBUG
                print("camila - AfterConfirmVideoController - changeTitleAsynchronous - export session FINISHED , changing name to \(self.storyTitle.text)")
            #endif
            //para o timer
            
            //get instancia da storyModel show
            
            //muda o titulo...
            self.storyTitle.changedTitle(ViewConfig.root.showAll!.allVideosForCollection[0])
            
        }
    }
    
    

}
