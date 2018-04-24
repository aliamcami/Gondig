//
//  DotsFactory.swift
//  app1131
//
//  Created by camila oliveira on 12/2/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class DotsFactory: UIImageView {
    var color : UIColor!{
        didSet{
            self.tintColor = self.color
            self.setNeedsDisplay()
        }
    }
    
    enum dots{
        case circular
        case triangular
        case quadrado
        
        func getByWidth(rect : CGRect, color : UIColor) -> DotsFactory{
            switch self{
            case .circular : return DotsFactory(frame: rect, image: UIImage(named: "dots-Circulo")!, color: color)
            case .quadrado : return DotsFactory(frame: rect, image: UIImage(named: "dots-Quadrado")!,color: color)
            case .triangular : return DotsFactory(frame: rect, image: UIImage(named: "dots-Triangulo")!, color: color)
            }
        }
        
        func getByHeight(rect : CGRect, color : UIColor) -> DotsFactory{
            switch self{
            case .circular : return DotsFactory(rect: rect, image: UIImage(named: "dots-Circulo")!, color: color)
            case .quadrado : return DotsFactory(rect: rect, image: UIImage(named: "dots-Quadrado")!,color: color)
            case .triangular : return DotsFactory(rect: rect, image: UIImage(named: "dots-Triangulo")!, color: color)
            }
        }
    }
    
    //set img to width
    init(frame: CGRect, image : UIImage, color : UIColor) {
        super.init(frame: frame)
        self.image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.layer.masksToBounds = true
        self.color = color
        self.tintColor = self.color
    }
    
    //resize img to height
    init(rect: CGRect, image : UIImage, color : UIColor) {
        
        let width = (image.size.width * rect.height) / image.size.height
        let frame = CGRectMake(rect.origin.x, rect.origin.y, width, rect.height)
        super.init(frame: frame)
        self.image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.layer.masksToBounds = true
        self.color = color
        self.tintColor = self.color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setNeedsDisplay() {
//        self.tintColor = self.color
//    }
//    
    func rotate(graus : CGFloat){
        self.image = self.image?.imageRotatedByDegrees(graus, flip: false).imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    }
    
    func scale (scale :  CGFloat){
        self.transform = CGAffineTransformScale(self.transform, scale, scale)
    }
    
}
