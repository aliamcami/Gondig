//
//  MergeSave.swift
//  app1131
//
//  Created by camila oliveira on 11/3/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class MergeSave: Save {
    var firstVideo : VideoModelShow!
    var controller : UIViewController!
    
    init(firstVideo : VideoModelShow, controller: UIViewController) {
        super.init()
        self.firstVideo = firstVideo
        self.controller = controller
    }
    override func save (storyModel : VideoModelCamiTretas){
        #if DEBUG
            print("camila - MergeSave - save - merge video and save")
        #endif
        
        let path = "\(Constants.path.tmp)\(storyModel.name)\(Constants.fileType.video)"
        storyModel.getExportSession().outputURL = NSURL(fileURLWithPath: path)
        storyModel.getExportSession().exportAsynchronouslyWithCompletionHandler({
            #if DEBUG
                print("camila - MergeSave - save - export second video completed, start mergin")
            #endif
            
            let secondVideo = VideoModelShowTMP(videoID: 0, name: storyModel.name, level: storyModel.level, time: storyModel.length)
            secondVideo.thumbnail = storyModel.thumbnail
            let merged = MergeVideos().exportVideo("\(Constants.path.videos)\(storyModel.name)\(Constants.fileType.video)", movies: [self.firstVideo, secondVideo])
            
            storyModel.exportSession = merged.exportSession
            let save = Save()
            save.save(merged)
            
        })
    }
    
}
