//
//  BorderFrame.swift
//  app1131
//
//  Created by camila oliveira on 12/1/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class BorderFrame: UIView {
    var borda : CALayer?{
        didSet{
            self.layer.addSublayer(borda!)
        }
    }
    
    @IBOutlet var contentView : UIView!
    override func drawRect(rect: CGRect) {
        #if DEBUG
                print("camila - BorderFrame - drawRect")
        #endif
        //garante que as constraints foram aplicadas
        self.layoutIfNeeded()
        
        let factory = BordersFactory(rect: rect)
        if borda == nil{
            borda = factory.getFilledWithInsideBorder()
        }

        changeConstraints(factory)
        
        self.layoutIfNeeded()
    }
    
    func changeConstraints(factory : BordersFactory){
        if !isCompactDevice{
            trailing?.constant = factory.rightMargin
            leading?.constant = factory.leftMargin
            botton?.constant = factory.bottonMargin
            top?.constant = factory.topMargin
        }
    }
        
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var botton: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    
    
    
}
