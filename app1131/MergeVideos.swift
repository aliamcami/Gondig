//
//  MergeViedoes.swift
//  app1131
//
//  Created by camila oliveira on 11/3/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class MergeVideos: NSObject {

    
    
    func exportVideo(outputUrl:String, movies : Array<VideoModelShow>) -> VideoModelCamiTretas{
        #if DEBUG
            print("camila - MergeVideos - exportVideo - merging....")
        #endif
        
        let composition = AVMutableComposition()
        let trackVideo:AVMutableCompositionTrack = composition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: CMPersistentTrackID())
        let trackAudio:AVMutableCompositionTrack = composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        var insertTime = kCMTimeZero
        


            for i in movies {

//                let moviePathUrl = NSURL(fileURLWithPath: moviePath)
                let moviePathUrl = i.videoUrl
                let sourceAsset = AVURLAsset(URL: moviePathUrl!, options: nil)
                
                let tracks = sourceAsset.tracksWithMediaType(AVMediaTypeVideo)
                let audios = sourceAsset.tracksWithMediaType(AVMediaTypeAudio)
                
                if tracks.count > 0{
                    let assetTrack : AVAssetTrack = tracks[0]
                    try! trackVideo.insertTimeRange(
                        CMTimeRange(start: kCMTimeZero, duration: sourceAsset.duration),
                        ofTrack: assetTrack,
                        atTime: insertTime)
                    
                    let assetTrackAudio:AVAssetTrack = audios[0] as AVAssetTrack
                    try! trackAudio.insertTimeRange(CMTimeRange(start: kCMTimeZero, duration: sourceAsset.duration),
                        ofTrack: assetTrackAudio,
                        atTime: insertTime)
                    
                    insertTime = CMTimeAdd(insertTime, sourceAsset.duration)
                }
            }
        
        
    
        let exporter = AVAssetExportSession(
                asset: composition,
                presetName: AVAssetExportPresetMediumQuality)
                
            exporter!.outputURL = NSURL(fileURLWithPath: outputUrl)
            exporter!.outputFileType = AVFileTypeMPEG4 //AVFileTypeQuickTimeMovie
        
        let firstVideo = movies[0]
        let tretas = VideoModelCamiTretas(lenght: firstVideo.length, level: firstVideo.level, animationSize: VideoConfig.animationSize.medium, phrase: VideoConfig.phraseStatus.off)
        tretas.thumbnail = movies.last?.thumbnail
        tretas.exportSession = exporter
        
        return tretas
        
        }
}
