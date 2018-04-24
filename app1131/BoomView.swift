//
//  boomView.swift
//  app1131
//
//  Created by camila oliveira on 12/6/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

///Dicionario com o titulo do botao e a funcao que ele deve executar.
// se passar "cancel" como chave o botao eh de cancelar e foda-se
// e se for "skip" nao aparece mais tutoriais
class BoomView: UIView {
    ///get instance placed
    enum getBoom : CGFloat{
        case top
        case mid
        case bot
        
        func complete(rect : CGRect, buttons :  Dictionary<String, ()->()>, text : String) -> BoomView{
            let height = rect.height / 1.8
            let width = rect.width
            let tam = CGRectMake(0, 0, width, height)
            let bom  = BoomView(rect: tam, buttons: buttons, text: text)
            switch self{
            case .top : bom.frame.origin = CGPointMake(0, 0)
            case .mid : bom.center = CGPointMake(rect.width/2, rect.height/2)
            case .bot : bom.frame.origin = CGPointMake(0, rect.height - bom.frame.height * 1.1)
            }
            return bom
        }
        
        func boom(rect : CGRect) -> BoomView{
            let height = rect.height / 1.8
            let width = rect.width
            let tam = CGRectMake(0, 0, width, height)
            let bom  = BoomView(frame: tam)
            switch self{
            case .top : bom.frame.origin = CGPointMake(0, 0)
            case .mid : bom.center = CGPointMake(rect.width/2, rect.height/2)
            case .bot : bom.frame.origin = CGPointMake(0, rect.height - bom.frame.height * 1.1)
            }
            return bom
        }
    }
    private enum fonts{
        case title
        case text
        
        var font : UIFont{
            switch self{
            case .title : return ViewConfig.text.phrase.font
            case .text : return ViewConfig.text.phrase.font
            }
        }
    }
    private var buttonsSize : CGFloat{
        return self.frame.height * 0.12
    }
    var boomImg : UIImage{
        return UIImage(named: "boom")!
    }
    var boomImageView : UIImageView!
    var vText : UILabel!
    var arrayButtons : Array<UIButton>!
    
    convenience init(rect: CGRect, buttons :  Dictionary<String, ()->()>, text : String) {
        #if DEBUG
            print("camila - BoomView - init com a bagaça toda")
        #endif
        self.init(frame: rect)
        
        setText(text)
        setButtons(buttons)
    }
    
    override init(frame: CGRect) {
        #if DEBUG
            print("camila - BoomView - init padrao")
        #endif
        super.init(frame: frame)
        self.layer.masksToBounds = true
        //addBoom primeiro pra n da merda
        self.addBoom()
        self.backgroundColor = UIColor.clearColor()

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setButtons(var buttons :  Dictionary<String, ()->()>){
        #if DEBUG
            print("camila - BoomView - setButtons")
        #endif
        if arrayButtons != nil{
            for i in arrayButtons{
                i.removeFromSuperview()
            }
        }
        // se existir um botao cancelar, entao atribui funcao pra ele
        if buttons["cancel"] != nil {
            let old = buttons["cancel"]
            buttons.updateValue({
                old!()
                self.removeFromSuperview()
                }, forKey: "cancel")
        }
        if buttons["skip"] != nil{
            let old = buttons["skip"]
            buttons.updateValue({
                old!()
                self.removeFromSuperview()
                for i in ViewConfig.instructions.allValues{
                    i.set(false)
                }
                }, forKey: "skip")
        }
        if buttons["next"] != nil{
            let old = buttons["next"]
            buttons.updateValue({
                old!()
                self.removeFromSuperview()
                }, forKey: "next")
        }
        
        self.addButtons(buttons)
        
        
    }
    
    func setText(text : String){
        #if DEBUG
            print("camila - BoomView - setText")
        #endif
        vText?.removeFromSuperview()
        self.addText(text)
    }
    private func addText(text : String){
        #if DEBUG
            print("camila - BoomView - addText")
        #endif
        //tenho que fazer com que o texto fique somente dentro do boom
        //fuck

        var rect = CGRectMake(0, 0, self.frame.width * 0.5, (self.frame.height - buttonsSize) * 0.7)
        let textY = (self.frame.height - buttonsSize)/2 - (rect.height/2)
        rect.origin = CGPointMake(self.frame.width/2 - rect.width/2, textY)
        
        let texto = myLabel(frame: rect, font: fonts.text.font, text: text)
        texto.layer.cornerRadius = rect.height * 0.5
        texto.numberOfLines = 0

        self.vText = texto
        self.addSubview(texto)

    }
    
    private func addButtons(dict :  Dictionary<String, ()->()>){
        #if DEBUG
            print("camila - BoomView - addButtons")
        #endif
        if dict.count == 0 {
            return
        }
        //quantidade de botoes
        let count = CGFloat(dict.count)
        //espaco entre botoes
        let space = VideoConfig.animationSize.small.borderAbsoluteMax
        //largura de um botao
        var width = self.frame.width * 0.25
        if isCompactDevice{
            width = self.frame.width / 3
        }
        //espaco total que todos os botoes vao gastar juntos
        let totalSpace = ((count - 1) * space) + (width * count)
        //Ponto inicial do botao
        let pontoXInicial = self.frame.width/2 - totalSpace/2
        //maximo de botoes por linha
        let maxPerLine = self.frame.width / width
        
        //contador de botoes
        var aux : CGFloat = 0
        var array = Array<UIButton>()
        for  (t, f) in dict {
            //ponto y
            var y = self.frame.height - buttonsSize - 10
            
            //pula de linha se tiver botao d mais.. sei la neh.. vai q, mas n serve pra porra nenhuma pq nao dei espaco pra segunda linha
            if aux > maxPerLine {
                y += buttonsSize + space
                aux = 0
            }
           
            //instancia botoa
            let rect = CGRectMake(
                pontoXInicial + (aux++ * (space + width)),
                y,
                width,
                buttonsSize)
            let button = myButton(frame: rect, action: f, title: t)
            array.append(button)
            self.insertSubview(button, belowSubview: boomImageView)
        }
    
    }
    
    private func addBoom (){
        #if DEBUG
            print("camila - BoomView - addBoom")
        #endif
        let rect = CGRectMake(0, 0, self.frame.width, self.frame.height - buttonsSize)
        let imgV = UIImageView(frame: rect)
        imgV.image = boomImg
        imgV.layer.masksToBounds = true
        imgV.contentMode = UIViewContentMode.ScaleAspectFit
        boomImageView = imgV
        self.addSubview(imgV)
    }
    
    ///BUtton personalizado pra porra do boom, e se for classe privada da merda, mt merda
    class myButton : UIButton{
        var action : () -> ()? = {print("pq?... PORQUE????? nao consigo se eu nao inicilar ela direto?? serio??? q porra eh essa!?!??! ")}
        
        init(frame: CGRect, action : () -> (), title : String) {
            super.init(frame: frame)

            self.action = action
            
            let tap = UITapGestureRecognizer(target: self, action: "executeAction")
            self.addGestureRecognizer(tap)
            
            //shadow
            self.layer.shadowColor = ViewConfig.color.borderColor.dark.CGColor
            self.layer.shadowOpacity = 1
            self.layer.shadowRadius = 4
            self.layer.shadowOffset = CGSizeMake(3, 3)
            
            //title
            self.setTitle(title.localized, forState: UIControlState.Normal)
            self.setTitle(title.localized, forState: UIControlState.Highlighted)
            self.setTitleColor(ViewConfig.color.color3.dark, forState: UIControlState.Normal)
            self.setTitleColor(ViewConfig.color.color5.dark, forState: UIControlState.Highlighted)
            
            //background
            self.backgroundColor = ViewConfig.color.background.dark
            self.setBackgroundColor(ViewConfig.color.color3.light, forState: UIControlState.Highlighted)
            
            //border
            self.layer.borderColor = ViewConfig.color.borderColor.dark.CGColor
            self.layer.borderWidth = ViewConfig.widths.borderFrame
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func executeAction (){
            self.action()
        }
        
    }
    
    ///label personalizado 
    private class myLabel : UILabel{
        convenience init(frame: CGRect, font : UIFont, text : String) {
            self.init(frame : frame)
            self.textAlignment = NSTextAlignment.Center
            self.font = font
            self.text = text.localized
//            self.layer.borderColor = UIColor.blackColor().CGColor
//            self.layer.borderWidth = 2
            self.textColor = ViewConfig.color.borderColor.dark
            self.backgroundColor = UIColor.clearColor()
        }
        
    }


}
