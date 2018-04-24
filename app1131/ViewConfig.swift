//
//  ColorConfig.swift
//  app1131
//
//  Created by camila oliveira on 12/1/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class ViewConfig: NSObject {
    
    //user defaults VIDEO CONFIGURATIONS save
    static var defaults = NSUserDefaults.standardUserDefaults()

    class func RGB (red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    struct widths {
        static let borderFrame : CGFloat = 4
    }
    enum color{
        ///Amarelo - Yellow
        case color1
        
        ///Verde - Green
        case color2
        
        ///Azul - Blue
        case color3
        
        ///Vermelho - Red
        case color4
        
        ///Preto - Black
        case color5
        
        ///Branco - White
        case color6
        
        ///Atualmente é branco
        case background
        
        ///Atualmente é Preto
        case borderColor
        
        var light : UIColor{
            switch self{
            case .color1 : return ViewConfig.RGB(236, green: 190, blue: 0)
            case .color2 : return ViewConfig.RGB(84, green: 169, blue: 72)
            case .color3 : return ViewConfig.RGB(80, green: 149, blue: 204)
            case .color4 : return ViewConfig.RGB(222, green: 43, blue: 56)
            case .color5 : return ViewConfig.RGB(51, green: 51, blue: 51)
            case .color6 : return ViewConfig.RGB(248, green: 248, blue: 248)
            case .background : return ViewConfig.color.color6.light
            case .borderColor : return ViewConfig.color.color5.light
                
            }
        }
        
        var dark : UIColor{
            switch self{
            case .color1 : return ViewConfig.RGB(234, green: 173, blue: 0)
            case .color2 : return ViewConfig.RGB(62, green: 151, blue: 46)
            case .color3 : return ViewConfig.RGB(62, green: 131, blue: 179)
            case .color4 : return ViewConfig.RGB(199, green: 25, blue: 32)
            case .color5 : return UIColor.blackColor()
            case .color6 : return ViewConfig.RGB(230, green: 230, blue: 230)
            case .background : return ViewConfig.color.color6.dark
            case .borderColor : return ViewConfig.color.color5.dark
                
            }
        }
        
    }
    
    enum text {
        case time
        case config
        case titleVideo
        case buttons
        case phrase
        case gondig
        
        
        var font : UIFont{
            if isCompactDevice {
                ///compact
                switch self{
                case .time : return UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
                case .config : return UIFont.systemFontOfSize(13, weight: UIFontWeightLight)
                case .titleVideo : return UIFont.systemFontOfSize(18, weight: UIFontWeightSemibold)
                case .buttons : return UIFont.systemFontOfSize(18, weight: UIFontWeightSemibold)
                case .phrase : return UIFont.systemFontOfSize(18, weight: UIFontWeightRegular)
                case .gondig : return UIFont.systemFontOfSize(80, weight: UIFontWeightRegular)
                }
            }else{
                ///regular
                switch self{
                case .time : return UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
                case .config : return UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
                case .titleVideo : return UIFont.systemFontOfSize(19, weight: UIFontWeightSemibold)
                case .buttons : return UIFont.systemFontOfSize(23, weight: UIFontWeightSemibold)
                case .phrase : return UIFont.systemFontOfSize(18, weight: UIFontWeightRegular)
                case .gondig : return UIFont.systemFontOfSize(80, weight: UIFontWeightRegular)
                }
            }
            
        }
        
        var color : UIColor{
                switch self{
                    //Cinza
                case .time : return ViewConfig.RGB(80, green: 80, blue: 80)
                    //Cinza = do time
                case .config : return ViewConfig.text.time.color
                    //Preto dark
                case .titleVideo : return ViewConfig.color.color5.dark
                    //Preto dark
                case .buttons : return ViewConfig.color.color5.dark
                    //Preto dark
                case .phrase : return ViewConfig.color.color5.dark
                //Preto
                case .gondig : return ViewConfig.color.color5.dark
                }

            
        }
    }
    
    struct root {
        static let appDelegate  = UIApplication.sharedApplication().delegate as? AppDelegate
        static let root = appDelegate?.window?.rootViewController as? CRPageViewController
        static let showAll = root?.showAllVideosControll
        static let camera = root?.cRCameraControll
        static let gondig = root?.gondigController
    }
    
    func getRandom(min : NSNumber, max : NSNumber) -> NSNumber{
        let rand = Int(arc4random()) % Int(ceil(max.doubleValue))
        return rand + min.integerValue
    }
    
    
    ///set of instructions - TRUE has to show, FALSE not show
    enum instructions : String{
        case start
        case recordInfinite
        case recordTimed
        case level
        case show
        case after
        case login
        case news
        
        var hasToShow : Bool{
            
                var dict = ViewConfig.instructions.instructionDictionary
                let value = dict[self.rawValue]
                return value as! Bool
                
                
        }
        
        func set(value : Bool){
            var dict = ViewConfig.instructions.instructionDictionary
            dict.updateValue(value as AnyObject, forKey: self.rawValue)
            ViewConfig.defaults.setObject(dict, forKey: "instructions")
        }
        
        static var allValues = [start, recordInfinite, recordTimed, level, show, after, login, news]
        
        static var instructionDictionary : Dictionary<String, AnyObject> {
            let dict = ViewConfig.defaults.dictionaryForKey("instructions")
            if dict == nil{
                let novo : Dictionary<String, AnyObject> = [
                    ViewConfig.instructions.start.rawValue : true,
                    ViewConfig.instructions.recordInfinite.rawValue : true,
                    ViewConfig.instructions.recordTimed.rawValue : true,
                    ViewConfig.instructions.level.rawValue : true,
                    ViewConfig.instructions.show.rawValue : true,
                    ViewConfig.instructions.after.rawValue : true,
                    ViewConfig.instructions.login.rawValue : true,
                    ViewConfig.instructions.news.rawValue : true
                ]
                ViewConfig.defaults.setObject(novo, forKey: "instructions")
                return novo
            }else{
                return dict!
            }
        }

        
    }
    
    
    
}