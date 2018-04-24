//
//  CollectionView.swift
//  app1131
//
//  Created by camila oliveira on 10/23/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit
import AVKit


class CollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var isLoaded = false
    private var spaceBetweenCells : CGFloat{
        get{
            if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact) {
                // Compact
                return 5
            } else {
                // Regular
                return 8
            }
        }
    }
    private var allVideos : Array<VideoModelShow>!{
        get{
            let av = parentController?.allVideosForCollection
            if av == nil {
                return Array<VideoModelShow>()
            }
            return av
        }
    }
    var parentController : ShowAllVideosViewController?
    
    override func drawRect(rect: CGRect) {
        #if DEBUG
            print("camila - CollectionView - DrawRect - set delegate datasorce")
        #endif
        isLoaded = true

        //set deletage
        self.delegate = self
        self.dataSource = self
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return self.spaceBetweenCells
    }
    
    //deletar video
    func delVideo (indexPath : NSIndexPath){
        
        #if DEBUG
            print("camila - CollectionView - DELVIDEO - \(indexPath.row)")
        #endif
        
        //deleta do banco
        VideoDAO().deleteVideoName(allVideos[indexPath.row])
        
        //deleta do array
        parentController?.allVideosForCollection.removeAtIndex(indexPath.row)
        
        //deleta da collection
        self.deleteItemsAtIndexPaths([indexPath])
        //reload

    }
    
    
    @IBAction func delAction(sender: AnyObject) {
        #if DEBUG
            print("camila - CollectionView - delAction")
        #endif

        //get index path
        let btn = sender as! DeleteButton
        let path = self.indexPathForCell(btn.cell)
        if path != nil {
            displayAlert(self.allVideos[path!.row].name, index: path!)
        }
        
        
//        delVideo(path!)
        
    }
   
    func displayAlert (text : String, index : NSIndexPath){
        let alert = UIAlertController(title: "confirm_deletion_video".localized, message: text, preferredStyle: UIAlertControllerStyle.Alert)
        let confirm = UIAlertAction(title: "yes".localized, style: .Default, handler: {
            _ in
            self.delVideo(index)
        })
        let cancel = UIAlertAction(title: "cancel".localized, style: .Cancel, handler: nil)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        self.parentController!.presentViewController(alert, animated: true, completion: nil)
    }

    
    
    //sections
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        #if DEBUG
            print("camila - CollectionView - numver of sections")
        #endif
        return 1
    }
    
    //items
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        #if DEBUG
            print("camila - CollectionView - numer of items ")
        #endif
        
        return self.allVideos.count
    }
    
    //content
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        #if DEBUG
            print("camila - CollectionView - cellForItemAtIndexPath \(indexPath.row)")
        #endif
        
        //get cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell",forIndexPath: indexPath) as! CRCollectionCell
        
        //set video model
        cell.videoModel = allVideos[indexPath.row]
        //set cell reference in button
        cell.deleteButton.cell = cell
        //set super view controller in share button
        cell.shareButton.controller = self.parentController
        //set background color
        cell.backgroundColor = UIColor.clearColor()
        //parent
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
            height = self.frame.height / 4
            width = self.frame.width * 0.98
        } else {
            // Regular
            width = (self.frame.width - 13) / 2
//            width = (self.frame.width - spaceBetweenCells * 1.3) / 2
//            width = self.frame.width * 0.9
            height = self.frame.height / 5
        }
        
        return CGSizeMake(width, height)
    }
    
    
    //PLAY NO VIDEO
    var selectedVideo : VideoModelShow?
    func performSegue(video : VideoModelShow) {
        #if DEBUG
            print("camila - CollectionView - didSelectItemAtIndexPath ")
        #endif
        
        selectedVideo = video
        
        self.parentController?.performSegueWithIdentifier("playVideo", sender: nil)
    }

    //set To merge
    
    @IBAction func continueAction(sender: AnyObject) {
        parentController?.continueVideo(sender)
    }
}
