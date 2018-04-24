//
//  AfterVideoBorderFrame.swift
//  app1131
//
//  Created by camila oliveira on 12/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class AfterVideoBorderFrame: BorderFrame {
    override var borda : CALayer?{
        didSet{
            //do nothing...  nao adiciona a borda
        }
    }
    @IBOutlet weak var bgBtSave: AfterVideoButtonSaveCamera!
    @IBOutlet weak var bgBar: BGBarControllerAfterVideoView!
    @IBOutlet weak var bgBtGondig: AfterVideoButtonGondig!
    @IBOutlet weak var bgBtShare: AfterVideoButtonShare!
    @IBOutlet weak var bgVideo: AfterVideoPlayer!
    
    
    @IBOutlet weak var ctVidoBotton: NSLayoutConstraint!
    @IBOutlet weak var ctVideoTop: NSLayoutConstraint!
    @IBOutlet weak var ctButtonsHeight: NSLayoutConstraint!
    @IBOutlet weak var ctGondigRIght: NSLayoutConstraint!
    @IBOutlet weak var ctShareRight: NSLayoutConstraint!
    

    
    override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
        let space : CGFloat
        let btHeight : CGFloat
        if isCompactDevice{
            space = 10
            btHeight = rect.height * 0.3
        }else{
            space = 15
            btHeight = rect.height * 0.3
        }
        
        ctButtonsHeight.constant = btHeight
        
        bgVideo.layer.masksToBounds = true
        
        ctVideoTop?.constant = space
        ctVidoBotton?.constant = space
        ctGondigRIght?.constant = space
        ctShareRight?.constant = space
        
        let margin = space * 0.6
        trailing?.constant += margin
        leading?.constant += margin
        botton?.constant += margin
        top?.constant += margin
        
        addDivisoes()
        
        layoutIfNeeded()
        setNeedsLayout()
    }
    
    private func addDivisoes(){
        addBorder(bgBar)
        addBorder(bgBtGondig)
        addBorder(bgBtSave)
        addBorder(bgBtShare)
        addBorder(bgVideo)
    }
    
    private func addBorder(tobe : UIView){
        tobe.layer.borderColor = ViewConfig.color.borderColor.light.CGColor
        tobe.layer.borderWidth = ViewConfig.widths.borderFrame
    }

}
