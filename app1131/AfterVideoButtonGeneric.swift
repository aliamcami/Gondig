//
//  AfterVideoButtonGeneric.swift
//  app1131
//
//  Created by camila oliveira on 11/17/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class AfterVideoButtonGeneric: UIView {
    @IBOutlet weak var icone : UIImageView!
    @IBOutlet weak var labelTxt : UILabel!
    @IBOutlet weak var dotsView : UIImageView!
    
    var controller : UIViewController?
    var model : VideoModelShow?{
        didSet{
            #if DEBUG
                print("camila - AfterVideoButtonGeneric - setando videoModel show, reabilitando ")
            #endif
            
            //allow user interaction and return alpha normal
            self.userInteractionEnabled = true
            self.alpha = 1
        }
    }
    var image : UIImage?{
        return nil
    }
    var title : String?{
        return nil
    }
    var bgColor : UIColor?{
        return nil
    }
    var dotsColor :UIColor?{
        return nil
    }
    
    var dots : DotsFactory?{
        let cc : UIColor
        if self.dotsColor == nil{
            cc = ViewConfig.color.background.light
        }else{
            cc = self.dotsColor!
        }
        let dot = DotsFactory.dots.quadrado.getByWidth(self.frame, color: cc)
        dot.rotate(-90)
        return dot
    }
    
    override func drawRect(rect: CGRect) {
        
        let myDots : DotsFactory? = self.dots
        if myDots != nil{
            self.dotsView?.image = myDots!.image
            self.dotsView?.tintColor = myDots!.tintColor
            self.dotsView?.contentMode = myDots!.contentMode
        }
        
        //if model nil then no user interaction enabled
        if model == nil {
            self.userInteractionEnabled = false
            self.alpha = 0.3
        }
        
        //image settings
        icone?.tintColor = ViewConfig.color.borderColor.dark
        icone?.contentMode = UIViewContentMode.Center
        icone?.backgroundColor = UIColor.clearColor()
       
        //design config
        self.icone.image = self.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.labelTxt.text = self.title?.localized
 
        //title settings
        labelTxt?.textColor = ViewConfig.text.buttons.color
        labelTxt?.font = ViewConfig.text.buttons.font
        
        //gesture
        let gest = UITapGestureRecognizer(target: self, action: "clickAction:")
        self.addGestureRecognizer(gest)
        
        self.layer.masksToBounds = true
        self.sendSubviewToBack(self.dotsView)
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        self.backgroundColor = self.bgColor
        
    }
    
    func clickAction(gesture : UIGestureRecognizer?){
        #if DEBUG
            print("camila - AfterVideoButtonGeneric - clicked ")
        #endif
        
        mark(false)
    }
    
    //MUDAR AQUI
    private var marked = false
    private func mark(on : Bool){
        if on && !marked{
          
            self.dotsView.tintColor = ViewConfig.color.borderColor.dark
            self.labelTxt.textColor = ViewConfig.color.background.dark
 
            marked = true
        }else if !on && marked{
            self.dotsView.tintColor = dotsColor
            self.labelTxt.textColor = ViewConfig.text.buttons.color
            
            marked = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        mark(true)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchInside(touches, actionTrue: {self.clickAction(nil)}, actionFalse: {})
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchInside(touches, actionTrue: {self.mark(true)}, actionFalse: {self.mark(false)})
    }
    
    private func touchInside (touches: Set<UITouch>, actionTrue : ()->(), actionFalse : ()->()){
        let point = (touches.first?.locationInView(self))!
        if self.pointInside(point, withEvent: nil) {
            
            actionTrue()
        }else{
           
            actionFalse()
        }
    }
}
