//
//  GNewsViewController.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class GNewsViewController: GCGenericViewController {
    override var getBg : GondigBG{
        return GCNewsView(rect: self.view.frame)
    }

    @IBOutlet weak var dotsBordaSuperior: UIImageView!
    @IBOutlet weak var collectionView: GNCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.parentController = self
        self.view.sendSubviewToBack(dotsBordaSuperior)
        dotsBordaSuperior.layer.masksToBounds = true
        dotsBordaSuperior.backgroundColor = ViewConfig.color.color2.dark
        self.view.bringSubviewToFront(collectionView)
        self.view.layer.borderWidth = ViewConfig.widths.borderFrame
        self.view.layer.borderColor = ViewConfig.color.borderColor.dark.CGColor
        
        
        
        //
        let b = BackEnd()
        b.getVideosFromFollowedUsers({ videos in
            self.collectionView.allVideos = videos
            self.collectionView.reloadSections(NSIndexSet(index: 0))
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if ViewConfig.instructions.news.hasToShow{
            ViewConfig.instructions.news.set(false)
            self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                "skip": {},
                "next" : {}
                ], text: "inst_shelf"))
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideo"{
            let player = segue.destinationViewController as! PlayerStoryViewController
            player.playerItem = self.collectionView.selectedVideo
        }
    }

}
