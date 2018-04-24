//
//  BottonContainerView.swift
//  app1131
//
//  Created by camila oliveira on 11/6/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class BottonContainerView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        
//    }
    func getGradientBG()-> CAGradientLayer{
        
        let clear = UIColor.blackColor().CGColor
        let  black = UIColor.clearColor().CGColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [clear, black]
        gradient.locations = [0.0 , 1.0]
        
        return gradient
        
    }
    
    var gl : CAGradientLayer!
    
    func makeGradientBG(){
        gl.frame = CGRectMake(0, 0, self.frame.width, self.bounds.size.height)
        self.layer.insertSublayer(gl, atIndex: 0)
    }
    override func setNeedsDisplay() {
        self.backgroundColor = UIColor.clearColor()
        gl = getGradientBG()
        gl.startPoint = CGPointMake(0, 1)
        gl.endPoint = CGPointMake(0, 0)

//        self.layer.insertSublayer(gl, atIndex: 0)
    }
    

    

}

