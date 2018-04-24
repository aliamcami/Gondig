//
//  AfterVideoPlayer.swift
//  app1131
//
//  Created by camila oliveira on 11/17/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class AfterVideoPlayer: UIView {
    private var activityIndic = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    var thumbnail : UIImage?
    private var thumb : CALayer!
    private var  imgv : UIImageView!
    override func drawRect(rect: CGRect) {
        layoutIfNeeded()
        
        
        //add thumbnail image
        if thumbnail != nil{
            imgv = UIImageView(frame: rect)
            imgv.image = thumbnail
            imgv.contentMode = UIViewContentMode.ScaleAspectFill
            imgv.layer.masksToBounds = true
            imgv.alpha = 0.6
            self.addSubview(imgv)

        }
        
        //set activity size
        activityIndic.hidden = false
        activityIndic.center = CGPointMake(self.frame.width/2, self.frame.height/2)
        activityIndic.startAnimating()
        self.addSubview(activityIndic)

    }
    
    func makePlayer(gesture : UIGestureRecognizer){
        self.addGestureRecognizer(gesture)
        self.imgv.alpha = 1
        //adicionar botao na parada
        
        let play = UIImageView(image: UIImage(named: "Play")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        play.alpha = 0.6
        play.center = CGPointMake(imgv.frame.width/2, imgv.frame.height/2)
        imgv.addSubview(play)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clearColor()
        self.bringSubviewToFront(activityIndic)
    }
    
    func stopActivity (){
        self.activityIndic.stopAnimating()
        self.activityIndic.hidden = true
    }
    

}
