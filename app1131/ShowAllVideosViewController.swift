//
//  ShowAllVideosViewController.swift
//  app1131
//
//  Created by camila oliveira on 10/23/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ShowAllVideosViewController: UIViewController, Pageble {
    dynamic var allVideosForCollection : Array<VideoModelShow>!{
        didSet{
            print("set")
        }
    }
    var parentController : UIViewController?
    //to pass on to the merge
    private var firstVideo : VideoModelShow!
    
    @IBOutlet weak var topCollection: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    private var pInd : NSNumber?
    var pageIndex : Int{
        get{
            if pInd == nil {
                return 0
            }
            return (self.pInd?.integerValue)!
        }
        set{
            pInd = NSNumber(integer: newValue)
        }
    }
    
    
    @IBOutlet weak var collectionViewCR: CollectionView!
    //adicionar video direto na collection
   
    func addVideo(model : VideoModelShow){
        #if DEBUG
            print("camila - ShowAllVideosViewController - addVideo")
        #endif
        
        //se nao der dispatch na nao funciona.
        let original = allVideosForCollection.count
        
        self.allVideosForCollection.insert(model, atIndex: 0)
        let i = self.collectionViewCR
        if allVideosForCollection.count > original && i.isLoaded{
            dispatch_async(dispatch_get_main_queue(),{
                i.insertItemsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)])
            })
        }
    }
    override func viewDidLoad() {
        
        #if DEBUG
            print("camila - ShowAllVideosController - ViewDidLoad")
        #endif
        self.collectionViewCR.parentController = self
        self.view.backgroundColor = ViewConfig.color.background.light
        self.collectionViewCR.backgroundColor = ViewConfig.color.background.light
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        let fact = BordersFactory(rect: self.view.frame)
        let margin : CGFloat
        if isCompactDevice{
            margin = 5
        }else{
            margin = 10
        }
        topCollection.constant =  margin
        trailing.constant = margin
        leading.constant = margin
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if ViewConfig.instructions.show.hasToShow{
            ViewConfig.instructions.show.set(false)
            self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                "skip": {},
                "next" : {}
                ], text: "inst_show1"))
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        #if DEBUG
            print("camila - ShowAllVideosController - prepareForSegue - to \(segue.identifier)")
        #endif
        
        if segue.identifier == "cameraMerge"{
            let camera = segue.destinationViewController as! CRCameraMerge
            camera.firstVideo = firstVideo
        }else if segue.identifier == "playVideo"{
            let player = segue.destinationViewController as! PlayerStoryViewController
            player.playerItem = self.collectionViewCR.selectedVideo
        }

    }
    
    
    
    func continueVideo(sender: AnyObject){
        self.firstVideo = (sender as! ContinueButton).videoModel
        (sender as! ContinueButton).continueFrom(self)
    }
    
}
