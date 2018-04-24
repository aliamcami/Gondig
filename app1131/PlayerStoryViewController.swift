//
//  PlayerStoryViewController.swift
//  app1131
//
//  Created by camila oliveira on 11/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class PlayerStoryViewController: UIViewController {
    var player = AVPlayer()
    let layer = AVPlayerLayer()
    var timeObserverToken: AnyObject?
    var playerItem : VideoModelShow?
    var storyTitleEnabled : Bool?
    
    @IBOutlet weak var shareButton: ShareButton!
    @IBOutlet weak var continueButton: ContinueButton!
    @IBOutlet weak var gondigButton: UIButton!

    @IBOutlet weak var backButton: BackButton!
    @IBOutlet weak var controlView: ControlViewContainer!

    
    var currentTime: Double {
        get {
            return CMTimeGetSeconds(player.currentTime())
        }
        
        set {
            let newTime = CMTimeMakeWithSeconds(newValue, 1)
            player.seekToTime(newTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        }
    }
    let timeRemainingFormatter: NSDateComponentsFormatter = {
        let formatter = NSDateComponentsFormatter()
        formatter.zeroFormattingBehavior = .Pad
        formatter.allowedUnits = [.Minute, .Second]
        
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            print("camila - PlayerStoryViewController - ViewDidLoad")
        #endif
        //verify storyTitle
        if storyTitleEnabled == false {
            controlView.storyTitleView.userInteractionEnabled = false
            controlView.storyTitleView.hidden = true
        }
        
        setNewVideo(self.playerItem)
        layer.player = player
        layer.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        self.view.layer.addSublayer(layer)
        
        //bring things to front
        self.view.bringSubviewToFront(controlView)
        self.controlView.parentController = self
        self.controlView.timeSlider.parentController = self

        
        //make it so video loops forever
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: self.player.currentItem)
        
        //insert gesture recognizer
        let gesture = UITapGestureRecognizer(target: self, action: "hiddeControlls:")
        self.view.addGestureRecognizer(gesture)
        
        //adicionando um tap gesture aki soh pra qnd ele clicar nao vai pra ou lugar
        let teste = UITapGestureRecognizer(target: self.controlView, action: "enableChangeTitle:")
        self.controlView.topView.addGestureRecognizer(teste)
        
        //swipe para voltar
        //let swipe = UISwipeGestureRecognizer(target: self, action: "backAction:")
        //swipe.direction = UISwipeGestureRecognizerDirection.Right
        //self.view.addGestureRecognizer(swipe)
        
        //setando cor dos elementos de acordo com a cor do video
        shareButton.tintColor = self.playerItem?.length.color.light
        continueButton.tintColor = self.playerItem?.length.color.light
        gondigButton.tintColor = self.playerItem?.length.color.light
//        controlView.storyTitleView.textColor = self.playerItem?.length.color.light
        backButton.tintColor = self.playerItem?.length.color.light
    }

    
    
    func hiddeControlls(sener: UIGestureRecognizer){
        if !self.controlView.isHide {
            self.controlView.hide()
        }else{
            self.controlView.show()
        }
    }

    func setNewVideo(video: VideoModelShow?){
        #if DEBUG
            print("camila - PlayerStoryViewController - setNewVideo")
        #endif
        
        if (video != nil) {
            let item = AVPlayerItem(URL: video!.videoUrl!)
            if ((player.currentItem) == nil) {
                player = AVPlayer(playerItem: item)
            }else{
                player.replaceCurrentItemWithPlayerItem(item)
                self.playerItem = video
            }
            
            //set max slider duration from video.
            controlView.videoTotalTime.text = "\(createTimeString(Float(video!.getAssetDuration())))"
            controlView.timeSlider.maximumValue = Float(video!.getAssetDuration())
            
            //set storyTitle
            controlView.storyTitleView.text = self.playerItem?.name
            controlView.storyTitleView.textColor = ViewConfig.color.color6.dark
            controlView.storyTitleView.font = ViewConfig.text.titleVideo.font
            
            player.play()
        }
        
    }
    

    override func viewDidAppear(animated: Bool) {
        #if DEBUG
            print("camila - PlayerStoryViewController - viewDidAppear")
        #endif
        let interval = CMTimeMake(1, 1)
        timeObserverToken = player.addPeriodicTimeObserverForInterval(interval, queue: dispatch_get_main_queue()) { [unowned self] time in
            self.controlView.timeSlider.value = Float(ceil(self.player.currentTime().seconds))
            self.controlView.startTimeLabel.text = self.createTimeString(Float(ceil(self.player.currentTime().seconds)))
            
        }

        //make gradient views
        controlView.bottonView.makeGradientBG()
        
    }

    var itemDidEnd = false
    func playerItemDidReachEnd (notification : NSNotification){
        #if DEBUG
            print("camila - PlayerStoryViewController - playerItemDidReachEnd")
        #endif
        player.pause()
        itemDidEnd = true
        self.controlView.playPauseButton.pause()
        self.controlView.show()
        
    }

    
    
    func createTimeString(time: Float) -> String {
        let components = NSDateComponents()
        components.second = Int(max(0.0, time))
        
        return timeRemainingFormatter.stringFromDateComponents(components)!
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        #if DEBUG
            print("camila - PlayerStoryViewController - prepare for segue \(segue.identifier)")
        #endif
        
        if segue.identifier == "cameraMerge"{
            let camera = segue.destinationViewController as! CRCameraMerge
            camera.firstVideo = self.playerItem
        }
        
    }
    
    //MARK: actions

    
    @IBAction func timeSliderDidChange(sender: UISlider) {
        currentTime = Double(sender.value)
    }

    @IBAction func shareAction(sender: AnyObject) {
        let btn = (sender as! ShareButton)
        btn.share(self.playerItem!)
        btn.controller = self
    }
    
    @IBAction func continuarAction (sender: AnyObject) {
        self.controlView.pause()
        
        let btn = (sender as! ContinueButton)
        btn.continueVideo(self.playerItem!, controller: self)
        
    }
    override func viewDidDisappear(animated: Bool) {
        player.pause()
    }
    
    @IBAction func backAction(sender: AnyObject?) {
        self.controlView.changedTitle()
        self.dismissViewControllerAnimated(false, completion: nil)
    }

    
    
    
    
}
