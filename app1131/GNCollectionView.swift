//
//  GNCollectionView.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class GNCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    var parentController : GNewsViewController?
    
    var allVideos : Array<VideoModelNetwork>?
    override func setNeedsLayout() {
        self.delegate = self
        self.dataSource = self
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return  10
    }
    
    //sections
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        #if DEBUG
            print("camila - GNCollectionView - numver of sections")
        #endif
        return 1
    }
    
    //items
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        #if DEBUG
            print("camila - GNCollectionView - numer of items ")
        #endif
        
        if self.allVideos == nil{
            return 0
        }else{
            return self.allVideos!.count
        }
    }
    
    //content
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        #if DEBUG
            print("camila - GNCollectionView - cellForItemAtIndexPath \(indexPath.row)")
        #endif
        
        //get cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell",forIndexPath: indexPath) as! GNewsCollectionViewCell
        
        cell.storyModel = self.allVideos![indexPath.row]
        cell.parent = self
        
        return cell
        
    }
    
    //cell size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var height : CGFloat
        var width : CGFloat
        //        self.layoutIfNeeded()
        if isCompactDevice {
            // Compact
            height = self.frame.height / 2
            width = self.frame.width 
        } else {
            // Regular
            width = (self.frame.width)
            //            width = (self.frame.width - spaceBetweenCells * 1.3) / 2
            //            width = self.frame.width * 0.9
            height = self.frame.height / 3
        }
        
        return CGSizeMake(width, height)
    }
    
    //PLAY NO VIDEO
    var selectedVideo : VideoModelShow?
    func performSegue(video : VideoModelShow) {
        #if DEBUG
            print("camila - GNCollectionView - performSegue ")
        #endif
        
        selectedVideo = video
        
        self.parentController?.performSegueWithIdentifier("playVideo", sender: nil)
    }


}
