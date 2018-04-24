//
//  CRCameraControlBridge.swift
//  T1_TesteCamera1131app
//
//  Created by camila oliveira on 10/14/15.
//  Copyright © 2015 camila oliveira. All rights reserved.
//

import UIKit
import AVKit

class CRCameraControlBridge: AAPLCameraViewController, Pageble,UIPickerViewDelegate {
    var storyModel = VideoModelCamiTretas()
    var sublayer = CALayer()
    private var factoryShow : FactoryAnimationShow!
    private var timerStoryFinished : NSTimer?
    private var timerCountDown : NSTimer?
    private var pInd : NSNumber?
    var parentController : UIViewController?
    @IBOutlet weak var ContainerConfig: UIView!
    
    @IBOutlet weak var confiButtonBackground: ConfigButtonsBackground!
    @IBOutlet weak var showLevelButton: ConfigShowButton!
    @IBOutlet weak var showLenghtButton: ConfigShowButton!
    @IBOutlet weak var lenghPicker: LenghPicker!
    @IBOutlet weak var levelPicker: LenghPicker!
    
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
    
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    @IBOutlet weak var startsButton: UIButton!
    var cancelled = false
    
    @IBAction func startAction(sender: AnyObject) {
        if !isRecording(){
            if ViewConfig.instructions.recordInfinite.hasToShow {
                activateFunctionalities(false)
                ViewConfig.instructions.recordInfinite.set(false)
                
                self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                    "skip" : {
                        self.theStart()
                        self.activateFunctionalities(true)
                    },
                    "next" : {
                        self.theStart()
                        self.activateFunctionalities(true)
                    }
                    
                    ], text: "inst_recTimedStory"))
            }else if ViewConfig.instructions.recordTimed.hasToShow {
                activateFunctionalities(false)
                ViewConfig.instructions.recordTimed.set(false)
                
                self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                    "skip" : {
                        self.theStart()
                        self.activateFunctionalities(true)
                    },
                    "next" : {
                        self.theStart()
                        self.activateFunctionalities(true)
                    }
                    ], text: "inst_recYouDecide"))
            }else{
                self.theStart()
            }
        }else{
            self.theStart()
        }
        
        
        
    }
    
    private func theStart(){
        
        if !isRecording(){
            #if DEBUG
                print("camila - CRCameraControlBidge - StartAction - Start Record")
            #endif
            storyModel = getNewInstance()
            
            //instantiate factoryShow and insert animations into the animationLayerHolder
            self.factoryShow = FactoryAnimationShow(storyModel: self.storyModel, viewSize: self.sublayer.frame.size)
            self.factoryShow.insertAnimationInLayer(self.sublayer)
            
            
            self.recordStory()
            
            if !self.storyModel.isInfinite(){
                self.currentCount = Int(self.storyModel.length.value.doubleValue + self.storyModel.phraseStatus.value.doubleValue) - 1
            }
            self.startsButton.setTitle("\(self.currentCount)", forState: UIControlState.Normal)
            
            cancelled = false
            
            //hide screen stuff
            hideConfigStuff(true)
            
        }else{
            #if DEBUG
                print("camila - CRCameraControlBidge - StartAction - Stop Record, record was cancelled")
            #endif
            
            //stops new elements
            self.factoryShow.timer?.invalidate()
            
            //stops story timer
            self.timerStoryFinished?.invalidate()
            
            //set cancel or stops
            if self.storyModel.length != VideoConfig.length.infinite{
                cancelled = true
            }else{
                cancelled =  false
                self.circularProgressView.progressInsideFillColor = actualColor.light
            }
            
            
            //I want to cancel, not stop
            stopsRecord()
            
            //stop circular indicator
            resetCircularIndicador()
            
            //hide screen stuff
            hideConfigStuff(false)
            
        }

    }
    
    func getNewInstance() -> VideoModelCamiTretas{
        return VideoModelCamiTretas()
    }
    func hideConfigStuff(hide : Bool){
        confiButtonBackground.hidden = hide
        showLenghtButton.hidden = hide
        showLevelButton.hidden = hide
        cameraButton?.hidden = hide
        //disable page view
        if hide {
            ViewConfig.root.root?.dataSource = nil
        }else{
            activateCiruclarProgrees(true)
            ViewConfig.root.root?.dataSource = ViewConfig.root.root
        }
        
        
        //always hide
            levelPicker.hidden = true
            lenghPicker.hidden = true

    }
    
    @IBAction func showLengthPickerAction(sender: AnyObject) {
        //clica no botao, ele se esconde e mostra a picker
        editLength(true)
        activateCiruclarProgrees(false)
    }
    
    func activateFunctionalities(activate : Bool){
        //PORQUE ESSA PORRA NAO FUNCIONA?
        self.ContainerConfig.userInteractionEnabled = activate
        self.previewView?.userInteractionEnabled = activate
        
        activateCiruclarProgrees(activate)
        
    }
    func activateCiruclarProgrees(ativa : Bool){
        circularProgressView.userInteractionEnabled = ativa
        startsButton.enabled = ativa
        if ativa{
            circularProgressView.alpha = 1
        }else{
            circularProgressView.alpha = 0.4
        }
    }
    func editLength(edit : Bool){
        self.lenghPicker.hidden = !edit
        self.showLenghtButton.hidden = edit
        if edit{
            editLevel(false)
        }
    }
    
    
    @IBAction func showLevelPickerAction(sender: AnyObject) {
        //clica no botao, ele se esconde e mostra a picker
        
//        activateCiruclarProgrees(false)
        self.activateFunctionalities(false)
        //QUARTA
        if ViewConfig.instructions.level.hasToShow{
            ViewConfig.instructions.level.set(false)
            self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                "skip" : {
                    self.activateFunctionalities(true)
                    self.editLevel(true)
                },
                "next" : {
                    self.activateFunctionalities(true)
                    self.editLevel(true)
                }
                
                ], text: "inst_record2"))//FIM 4
        }else{
            self.activateFunctionalities(true)
            self.editLevel(true)
        }
        
    }
    
    func editLevel(edit : Bool){
        self.levelPicker.hidden = !edit
        self.showLevelButton.hidden = edit
        if edit{
            editLength(false)
        }
        
    }

    
    //BOTOES PARA SETAR COISAS
    //O ULTIMO ATIVA O START BUTTON e instancia o storyModel
    //PRIMEIRO timed
    //SEGUNDO - level
    

//MARK: views load
    var actualColor : ViewConfig.color{
        return VideoConfig.userLength.color
    }
    override func viewDidLoad() {
        #if DEBUG
            print("camila - CRCameraControlBidge - viewDidLoad")
        #endif
        super.viewDidLoad()
        
//        VideoConfig.userPhraseStatus = VideoConfig.phraseStatus.on
        //set Circular progress color
        changeColors()
        
        sublayer.frame = self.view.layer.frame
        self.view.layer.addSublayer(sublayer)
        changeCamera()
        
        
        //add focus gesture to container
        ContainerConfig?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "focusAndExposeTap:"))
        
//        self.previewView?.layer.mask = (self.view as! BorderFrame).contentLayer
        
    }
  
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        #if DEBUG
            print("camila - CRCameraControlBidge - viewDidAppear ")
        #endif
        //INSTRUCAO AO USUARIO
        
        //PRIMEIRA
        if ViewConfig.instructions.start.hasToShow {
            activateFunctionalities(false)
            ViewConfig.instructions.start.set(false)
            
            self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                "skip" : {self.activateFunctionalities(true)},
                "next" : {
                    //SEGUNDA
                    self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                        "skip" : {self.activateFunctionalities(true)},
                        "next" : {
                            //TERCEIRA
                            self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                                "skip" : {self.activateFunctionalities(true)},
                                "next" : {self.activateFunctionalities(true)
                                    
                                }
                                
                                ], text: "inst_record1"))//FIM 3
                            
                        }
                        
                        ], text: "inst_swipeToNavigate")) //FIM 2
                    
                }
                ], text: "inst_start")) //FIM 1
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        #if DEBUG
            print("camila - CRCameraControlBidge - viewWillAppear ")
        #endif
        super.viewWillAppear(animated)
         initialConfigButtonsShowPicker()
        
    }

    override func focusAndExposeTap(gestureRecognizer: UIGestureRecognizer!) {
        #if DEBUG
            print("camila - CRCameraControlBidge - focusAndExposeTap ")
        #endif
        
        
        super.focusAndExposeTap(gestureRecognizer)
        
        if !isRecording(){

            hideConfigStuff(false)
        }
        
    }
    func initialConfigButtonsShowPicker(){
        #if DEBUG
            print("camila - CRCameraControlBidge - configurando botoes de configuracao ")
        #endif
        
        
        //set data sorce e delegate da picker
        lenghPicker.parentController = self
        lenghPicker.dataSource = lenghPicker
        lenghPicker.delegate = lenghPicker
        
        levelPicker.parentController = self
        levelPicker.dataSource = levelPicker
        levelPicker.delegate = levelPicker
        
        //configuracao dos botoes de show config
        showLenghtButton.picker = lenghPicker
        showLevelButton.picker = levelPicker

        
        hideConfigStuff(false)
  

    }
    //MARK: segue play video
    override func playVideo(url : NSURL) {
 
        if cancelled{
            #if DEBUG
                print("camila - CRCameraControlBidge - playVideo - video cancelled")
            #endif
            
            //stop all timers
            self.timerCountDown?.invalidate()
            self.timerStoryFinished?.invalidate()
            self.factoryShow?.timer?.invalidate()
            
            //stop circular indicator
            resetCircularIndicador()
            self.reloadInputViews()
            
        }else{
            #if DEBUG
                print("camila - CRCameraControlBidge - playVideo - perform segue to play video")
            #endif
            
            //store origin URL on storyModel instance
            self.storyModel.originURL = url

            self.performSegueWithIdentifier("confirmVideo", sender: nil)
        }
       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        #if DEBUG
            print("camila - CRCameraControlBidge - prepareForSegue - to \(segue.identifier)")
        #endif
        
        if segue.identifier == "confirmVideo"{
            let conf = segue.destinationViewController as! AfterConfirmVideoController
            conf.tretas = self.storyModel
        }
        
        
    }

//MARK: my functionalities
    //If its already recording its stops and saves
    //if its NOT recording then its starts recording
    private func record(){
        #if DEBUG
        print("camila - CRCameraControlBidge - record")
        #endif
        
        //chamado soh de dentro de outros metodos
        self.toggleMovieRecording(nil)
    }
    
    override var isFrontCamera : Bool{
        didSet{
            let btn = (cameraButton as! SwitchCameraButton)
            !isFrontCamera ? btn.setForFrontCamera() : btn.setForBackCamera()
        }
    }
    
    func changeCamera (){
        #if DEBUG
            print("camila - CRCameraControlBidge - changeCamera")
        #endif
        
        self.changeCamera(nil)
    }
    
    private func stopsRecord (){
        #if DEBUG
            print("camila - CRCameraControlBidge - stopsRecord \(isRecording())")
        #endif
        
        if isRecording(){
            record()
            sublayer.sublayers = nil
        }
    }
    
    private func startRecord(){
        #if DEBUG
            print("camila - CRCameraControlBidge - startRecord \(!isRecording())")
        #endif
        
        if !isRecording(){
            record()
            
        }
    }
    
//MARK: record

    func recordStory(){
        #if DEBUG
            print("camila - CRCameraControlBidge - recordStory - pass on the time to be recorded and start progress counter")
        #endif
        
        //adicionando frases
        if !self.storyModel.isInfinite(){
            recordFor(storyModel.totalTime)
        }else{
            startRecord()
            self.circularProgressView.progressInsideFillColor = UIColor.clearColor()
        }
        
        startProgressCounter()

    }
    
    
    private func recordFor(seconds : NSNumber){
        
        #if DEBUG
            print("camila - CRCameraControlBidge - recordFor - seconds: \(seconds)")
        #endif
        
        startRecord()
        self.timerStoryFinished = NSTimer.scheduledTimerWithTimeInterval(seconds.doubleValue, target: self, selector: Selector("storyTimesUp:"), userInfo: nil, repeats: false)
        
    }
    
    
    func storyTimesUp (timer : NSTimer){
        #if DEBUG
            print("camila - CRCameraControlBidge - storyTimesUp - time for timed story ended")
        #endif
        
        self.timerCountDown?.invalidate()
        self.storyModel.timesUp = true
        self.factoryShow.timer?.invalidate()
        self.timerStoryFinished?.invalidate()
        self.stopsRecord()
        self.resetCircularIndicador()
    }
    
    
    var currentCount = 0
    func startProgressCounter() {
        #if DEBUG
            print("camila - CRCameraControlBidge - startProgressCounter")
        #endif
        
        if !self.storyModel.isInfinite(){
            
            self.startsButton.setTitle("\(self.currentCount)", forState: UIControlState.Normal)
            
            //start animation
            self.timerCountDown = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateCountDown:"), userInfo: nil, repeats: true)
            self.circularProgressView.animateToAngle(360, duration: NSTimeInterval((self.storyModel.length.value.doubleValue + self.storyModel.phraseStatus.value.doubleValue) - 1),
                completion: {_ in
                    self.timerCountDown?.invalidate()
                    self.factoryShow.timer?.invalidate()
                    self.currentCount = 0
            })
        }else{
            self.resetCircularIndicador()
            self.currentCount = 1
            self.timerCountDown = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateCountDownUP:"), userInfo: nil, repeats: true)
        }
        
        
        
        
    }
    
    
    func updateCountDown(timer: NSTimer){
        #if DEBUG
            print("camila - CRCameraControlBidge - updateCountDown")
        #endif
        currentCount--
        
        self.startsButton.setTitle("\(self.currentCount)", forState: UIControlState.Normal)
    }
    func updateCountDownUP(timer: NSTimer){
        #if DEBUG
            print("camila - CRCameraControlBidge - updateCountDownUP")
        #endif
        currentCount++
        
        self.startsButton.setTitle("\(self.currentCount)", forState: UIControlState.Normal)
    }
    
    func resetCircularIndicador() {
        #if DEBUG
            print("camila - CRCameraControlBidge - resetCircularIndicator ")
        #endif
        
        currentCount = 0

        self.timerCountDown?.invalidate()
        circularProgressView.stopAnimation()
        circularProgressView.animateFromAngle(circularProgressView.angle, toAngle: 0, duration: 0.2, completion: nil)
        self.startsButton.setTitle("", forState: UIControlState.Normal)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        #if DEBUG
            print("camila - CRCameraControlBidge - view did desappeear ")
        #endif

        initialConfigButtonsShowPicker()

        
    }
  
    override func viewWillDisappear(animated: Bool) {
        #if DEBUG
            print("camila - CRCameraControlBidge - view will desappeear ")
        #endif
        super.viewWillDisappear(animated)
        
        self.cancelled = true
        self.timerCountDown?.invalidate()
        self.timerStoryFinished?.invalidate()
        self.stopsRecord()
        self.factoryShow?.timer?.invalidate()
        
    }
    
    //GARANTIR Q A PORRA DAS CORES MUDA COMA CONFIG
    func reloadViews(){
        self.performSelectorOnMainThread("changeColors", withObject: nil, waitUntilDone: false)
        
    }
    
    func changeColors(){
        #if DEBUG
            print("camila - CRCameraControlBidge - changeColors")
        #endif
        self.circularProgressView?.trackColor = ViewConfig.color.color6.light
        self.circularProgressView?.progressInsideFillColor = actualColor.light
        self.circularProgressView?.progressColors = [actualColor.dark]
        startsButton?.setTitleColor(actualColor.dark, forState: UIControlState.Normal)
        startsButton?.setTitleShadowColor(ViewConfig.color.color5.dark, forState: UIControlState.Normal)
        
        self.cameraButton?.setNeedsDisplay()
        self.showLenghtButton?.setNeedsDisplay()
        self.lenghPicker?.setNeedsDisplay()
        self.view?.reloadInputViews()
        
//        ativateCiruclarProgrees(true)
        
    }
    
    
    
   
}
