//
//  BordesFactory.swift
//  app1131
//
//  Created by camila oliveira on 12/2/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class BordersFactory: NSObject {
    var minn : CGFloat!
    var maxx : CGFloat!
    private var rect : CGRect!
    private let borderColor = ViewConfig.color.borderColor.light.CGColor
    private let fillColor = ViewConfig.color.background.light.CGColor
    private var irregularFactory : BordersFactory?
    //margins
    var leftMargin : CGFloat!
    var rightMargin : CGFloat!
    var bottonMargin : CGFloat!
    var topMargin : CGFloat!
    
    private var margins : Array<CGFloat>!
    
    //MARK: INITS
    private func inicializa (var rect : CGRect, min : CGFloat, max: CGFloat){
        if rect.width == 0 {
            #if DEBUG
                print("camila - BordersFactory - inits - rect width 0, setting new default rect you stupid")
            #endif
            
            rect = CGRectMake(0, 0, 100, 100)
        }
        
        self.rect = rect
        self.minn = min
        self.maxx = max
        makeMargins()
    }
    init(rect : CGRect) {
        super.init()
        inicializa(rect, min: rect.width * 0.016, max: rect.width  * 0.021)
        
    }
     init(rect : CGRect, minPercent : CGFloat, maxPercent : CGFloat) {
        super.init()
        inicializa(rect, min: rect.width * minPercent, max: rect.width * maxPercent)
    }
    
    init(rect : CGRect, minAbsolute : CGFloat, maxAbsolute : CGFloat) {
        super.init()
        inicializa(rect, min: minAbsolute, max: maxAbsolute)

    }
    
    init(rect : CGRect, minPercent : CGFloat, maxAbsolute : CGFloat) {
        super.init()
        inicializa(rect, min: rect.width * minPercent, max: maxAbsolute)
    }
    
    init(rect : CGRect, minAbsolute : CGFloat, maxPercent : CGFloat) {
        super.init()
        inicializa(rect, min: minAbsolute, max: rect.width * maxPercent)
    }
    
    //MARK: FACTORY
    //MARK : Border
    func getBorderInside() -> CAShapeLayer{
        #if DEBUG
            print("camila - BordersFactory - getBorderInside")
        #endif
        
        let shape = getShappedLayer(getInnerPoints())
 
        shape.strokeColor = borderColor
        shape.fillColor = UIColor.clearColor().CGColor
        
        return shape
    }
    
    func getBorderOutsideSquare() -> CAShapeLayer{
        #if DEBUG
            print("camila - BordersFactory - getBorderOutsideSquare")
        #endif
        
        let shape = getShappedLayer(getExternPoints())
        
        shape.strokeColor = borderColor
        shape.fillColor = UIColor.clearColor().CGColor
        
        return shape
    }
    
    func getBorderOutsideIrregular() -> CAShapeLayer{
        #if DEBUG
            print("camila - BordersFactory - getBorderOutsideSquare")
        #endif
        
        let shape = getShappedLayer(getExternIrregularPoints())
        
        shape.strokeColor = borderColor
        shape.fillColor = UIColor.clearColor().CGColor
        
        return shape
    }
    
    func getBordersSquare() -> CAShapeLayer{
        #if DEBUG
            print("camila - BordersFactory - getBordersSquare")
        #endif
        
        let shape = getBorderOutsideSquare()
        shape.addSublayer(getBorderInside())
        
        return shape
    }
    
    func getBordersIrregular() -> CAShapeLayer{
        #if DEBUG
            print("camila - BordersFactory - getBordersIrregular")
        #endif
        
        let shape = getBorderOutsideIrregular()
        shape.addSublayer(getBorderInside())
        
        return shape
    }

    
    //MARK: fill
    func getFillRegular() -> CAShapeLayer{
        #if DEBUG
            print("camila - BordersFactory - getFillRegular")
        #endif

        var array = getInnerPoints()
        array.append(getInnerPoints().first!)
        array.appendContentsOf(getExternPoints())
        array.append(getExternPoints().first!)
        
        let shape = getShappedLayer(array)
        shape.fillColor = fillColor
        shape.strokeColor = UIColor.clearColor().CGColor
        
        return shape
    }
    
    func getFillIrregular() -> CAShapeLayer{
        #if DEBUG
            print("camila - BordersFactory - getFillIrregular")
        #endif
        
        var array = getInnerPoints()
        array.append(getInnerPoints().first!)
        array.appendContentsOf(getExternIrregularPoints())
        array.append(getExternIrregularPoints().first!)

        let shape = getShappedLayer(array)
        shape.fillColor = fillColor
        shape.strokeColor = UIColor.clearColor().CGColor
        
        return shape
    }

    //MARK: filled bordered
    
    func getFilledWithInsideBorder() -> CAShapeLayer{
        let shape = getFillRegular()
        shape.addSublayer(getBorderInside())
        return shape
    }
    
    func getFilledWithOutsideBorder() -> CAShapeLayer{
        let shape = getFillRegular()
        shape.addSublayer(getBorderOutsideSquare())
        return shape
    }
    
    func getFilledWithBorders() -> CAShapeLayer{
        let shape = getFillRegular()
        shape.strokeColor = borderColor
        let border = self.getBorderInside()
        shape.addSublayer(border)
        return shape
    }
    
    func getFilledWithIrregularBorders() -> CAShapeLayer{
        let shape = getFillIrregular()
        shape.strokeColor = borderColor
        return shape
    }


    
    //MARK: UTIL
    private func getRandom() -> CGFloat{
        let rand = Int(arc4random()) % Int(ceil(maxx))
        return (CGFloat(rand) + ceil(minn))
    }
    
    private func makeMargins(){
        #if DEBUG
            print("camila - BorderFactory - makePoints")
        #endif
        
        margins = Array<CGFloat>()
        for _ in 0...8{
            margins.append(getRandom())
        }

        leftMargin = min(margins[0], margins[1])
        rightMargin = min(margins[2], margins[3])
        bottonMargin = min(margins[4], margins[5])
        topMargin = min(margins[6], margins[7])

    }
    
    private func getInnerPoints () -> Array<CGPoint> {
        //sentido contra relogio
        return [
            CGPointMake(margins[0], margins[6]), //topo esquerdo
            CGPointMake(margins[1], rect.height - margins[4]), //botton esquerdo
            CGPointMake(rect.width - margins[2], rect.height - margins[5]), //botton direito
            CGPointMake(rect.width - margins[3], margins[7]) //topo direito
        ]
    }
    
    private func getExternPoints () -> Array<CGPoint> {
        //sentindo relogio
        return [
            CGPointMake(0, 0),
            CGPointMake(rect.width, 0),
            CGPointMake(rect.width, rect.height),
            CGPointMake(0, rect.height)
        ]
    }
    
    private func getExternIrregularPoints()  -> Array<CGPoint> {
        if irregularFactory == nil{
           irregularFactory = BordersFactory(
                rect: self.rect,
                minAbsolute: ViewConfig.widths.borderFrame * 0.3,
                maxAbsolute: ViewConfig.widths.borderFrame * 1
            )
        }
        
        return irregularFactory!.getInnerPoints()
    }
    
    func getShappedLayer (points : Array<CGPoint> ) -> CAShapeLayer{
        
        let bordaPath = UIBezierPath()
        
        for i in points{
            if i == points.first {
                bordaPath.moveToPoint(i)
            }else{
                bordaPath.addLineToPoint(i)
            }
        }
        bordaPath.closePath()
        
        let shape = CAShapeLayer()
        shape.path = bordaPath.CGPath
        shape.lineWidth = ViewConfig.widths.borderFrame
        
        return shape

    }

}
