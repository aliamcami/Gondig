//
//  GondigBG.swift
//  app1131
//
//  Created by camila oliveira on 12/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class GondigBG: UIView {
    var azul : CAShapeLayer!
    var vermelho : CAShapeLayer!
    var amarelo : CAShapeLayer!
    var verde : CAShapeLayer!
    
    var factory : BordersFactory!
    
    
    var w : CGFloat!
    var y : CGFloat!
    
    enum tipo{
        ///Quadro 1
        case azul
        ///Quadro 2 - Login
        case login
        ///Quadro 3
        case news
        ///Quadro 4 - cadastro
        case cadastro
        ///visao total
        case total
        
        var startMultiplier :  (x : CGFloat, y : CGFloat){
            switch self{
            case .azul : return (0, 0)
            case .login : return (-0.35, -0.06)
            case .news : return(-0.5, -0.43)
            case .cadastro : return (-0.14, -0.43)
            case .total : return (0,0)
            }
        }
        
        var rectMultiplier : (x : CGFloat, y : CGFloat){
            let mult = (CGFloat(2), CGFloat(1.78))
            switch self{
            case .azul : return mult
            case .login : return mult
            case .news : return mult
            case .cadastro : return mult
            case .total : return (1,1)
            }
        }
 
    }
    
    
    init(rect: CGRect, tipo : GondigBG.tipo) {
//        super.init(frame: rect)
        
        
        let size = CGSizeMake(rect.width * tipo.rectMultiplier.x, rect.height * tipo.rectMultiplier.y)
        let start = CGPointMake(size.width * tipo.startMultiplier.x, size.height * tipo.startMultiplier.y)
        let frame = CGRect(origin: start, size: size)
        super.init(frame: frame)
        self.frame.origin = start
        self.layer.masksToBounds = true
        self.factory = BordersFactory(rect: frame)
        w = frame.width
        y = frame.height
        
        self.azul = getAzul()
        self.vermelho = getVermelho()
        self.amarelo = getAmarelo()
        self.verde = getVerde()
        
        self.layer.addSublayer(self.azul)
        self.layer.addSublayer(self.vermelho)
        self.layer.addSublayer(self.amarelo)
        self.layer.addSublayer(self.verde)
        
//        addDots()
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func point(w : CGFloat, y : CGFloat) -> CGPoint{
        return CGPointMake(self.w * w/100, self.y * y/100)
    }
    func addDots (){
        
        //PORQUE ESSA PORRA NAO FUNCIONA??!?!?!?! EU FIZ A MESMA MERDA OUTRAS PARTES DO APP E FUNCIONA...
        // AAAAAAAAAAAAAAAAAAAHHH
        //SOCORRO!!!!
        //PQP
        //2 HORAS NISSO... SERIO?!?!?
        //ta... desisto... foda-se
        let red = DotsFactory.dots.circular.getByWidth(CGRectMake(0, 0, self.frame.width * 0.46, self.frame.width * 0.46), color: ViewConfig.color.color4.dark)
        red.center = point(44, y: 48.6)
        
        let mask = getVermelho()

        mask.fillColor = UIColor.blackColor().CGColor
        mask.backgroundColor = UIColor.blackColor().CGColor

//        self.layer.addSublayer(mask)
        red.layer.mask = mask
        self.layer.addSublayer(red.layer)
//        self.layer.addSublayer(mask)
//        self.layer.addSublayer(red.layer)
        
//        self.addSubview(red)
        
    }

    //MARK: SHAPES
    func getVerde() -> CAShapeLayer{
        let points = [
            point(54.3, y: 47.8),
            point(100, y: 37.8),
            point(100, y: 100),
            point(54.3, y: 100)
        ]
        let shape = factory.getShappedLayer(points)
        shape.strokeColor = ViewConfig.color.borderColor.dark.CGColor
        shape.fillColor = UIColor.clearColor().CGColor

        return shape
    }
    func getAmarelo() -> CAShapeLayer{
        let points = [
            point(0, y: 59),
            point(53, y: 48),
            point(53, y: 100),
            point(0, y: 100)
        ]
        let shape = factory.getShappedLayer(points)
        shape.strokeColor = ViewConfig.color.borderColor.dark.CGColor
        shape.fillColor = UIColor.clearColor().CGColor
        return shape
    }
    
    func getVermelho() -> CAShapeLayer{
        let points = [
            point(46, y: 0),
            point(100, y: 0),
            point(100, y: 37),
            point(44, y: 48.6)
        ]
        let shape = factory.getShappedLayer(points)
        shape.strokeColor = ViewConfig.color.borderColor.dark.CGColor
        shape.fillColor = UIColor.clearColor().CGColor
        return shape
    }
    func getAzul() -> CAShapeLayer{
        let points = [
            point(0, y: 0),
            point(43, y: 0),
            point(42, y: 49),
            point(0, y: 58)
        ]
        print(points)
        let shape = factory.getShappedLayer(points)
        shape.strokeColor = ViewConfig.color.borderColor.dark.CGColor
        shape.fillColor = UIColor.clearColor().CGColor
        return shape
        
    }
}
