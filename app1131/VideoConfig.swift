//
//  VideoConfig.swift
//  app1131
//
//  Created by Giovani Ferreira Silvério da Silva on 10/16/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class VideoConfig: NSObject {
    //user defaults VIDEO CONFIGURATIONS save
    static var defaults = NSUserDefaults.standardUserDefaults()
    
    
    //Pre defined video time in SECONDS, 0 means no limite.
    //MARK: lenght
    enum length : Int{
        case short
        case medium
        case long
        case infinite
        
        var color : ViewConfig.color{
            switch self{
                ///amarelo
            case .short : return ViewConfig.color.color1
                ///verde
            case .medium : return ViewConfig.color.color2
                ///azul
            case .long : return ViewConfig.color.color3
                ///vermelho
            case .infinite : return ViewConfig.color.color4
            }
        }
        
        ///all values of enum
        static let allValues :Array<VideoConfig.length> = [short, medium, long, infinite]
        
        ///camila - description of name of enum, no value included
        var description : String{
            switch self{
            case .infinite: return "no_limit".localized
            case .long: return "long".localized
            case .medium: return "medium".localized
            case .short: return "short".localized
            }
        }
        
        ///camila - value for video lenght reference
        var value : NSNumber{
            let base = 5
            switch self{
            case .short: return base
            case .medium: return base * 3
            case .long: return base * 6
            case .infinite: return 0
            }
        }
        
        ///camila - value (number) description of length
        var valueDescription : String{
            switch self{
            case .short: return "\(self.value) " + "sec".localized
            case .medium: return "\(self.value) " + "sec".localized
            case .long: return "\(self.value) " + "sec".localized
            case .infinite: return "infinite_Story_Length".localized
            }
        }
    }

    
    
    static var userLength : VideoConfig.length{
        get{
            let num = defaults.integerForKey("userLength")
            let len = VideoConfig.length(rawValue: num)
            if len == nil{
                return VideoConfig.length.short
            }
            return len!
        }
        set{
            defaults.setInteger(newValue.rawValue, forKey: "userLength")
        }
    }
    
    //MARK: phrase
    enum phraseStatus : Int{
        case on
        case off
        case long
        
        static let allValues :Array<VideoConfig.phraseStatus> = [off, on, long]
        
        var value : NSNumber{
            switch self{
            case .on: return 3
            case .off: return 0
            case .long: return 6
            }
        }
        
    }
    
    static var userPhraseStatus :  VideoConfig.phraseStatus {
        get{
            let len = VideoConfig.phraseStatus(rawValue: defaults.integerForKey("userPhraseStatus"))
            if len == nil{
                return VideoConfig.phraseStatus.on
            }
            return len!
        }
        set{
            defaults.setInteger(newValue.rawValue, forKey: "userPhraseStatus")
        }
    }
    
    //MARK: level
    enum level : Int{
        case light
        case easy
        case medium
        case hard
        case indef
        
        static let allValues :Array<VideoConfig.level> = [light,easy, medium, hard, indef]
        
        ///Camila - String localized description
        var description : String{
            switch self{
            case .light : return "light".localized
            case .easy: return "easy".localized
            case .medium: return "medium".localized
            case .hard: return "hard".localized
            case .indef: return "error".localized
            }
        }
        
        ///Camila - Value of enum for video imgs change use
        var value : NSNumber{
            let base = 10.0
            switch self{
            case .light : return base * 1.5
            case .easy: return base/2
            case .medium: return base/3
            case .hard: return base/4
            case .indef: return 0
            }
        }
        
    }
    
    //save
    static var userLevel :  VideoConfig.level {
        get{
            let len = VideoConfig.level(rawValue: defaults.integerForKey("userLevel"))
            if len == nil{
                return VideoConfig.level.easy
            }
            return len!
        }
        set{
            defaults.setInteger(newValue.rawValue, forKey: "userLevel")
        }
    }

    //MARK: animation size
    enum animationSize : Int{
        case medium
        case small
        case big
        case giant
        
        static let allValues :Array<VideoConfig.animationSize> = [small, medium, big, giant]
        
        var value : NSNumber{
            switch self{
            case .small: return 0.08
            case .medium: return 0.18
            case .big: return 0.36
            case .giant: return 0.5
            }
        }
        
        var borderAbsoluteMax: CGFloat{
            if isCompactDevice{
                switch self{
                case .small: return 5
                case .medium: return 10
                case .big: return 13
                case .giant: return 17
                }
            }else{
                switch self{
                case .small: return 10
                case .medium: return 15
                case .big: return 20
                case .giant: return 20
                }
            }
        }
        
    }
    
    //save
    static var userAnimationSize :  VideoConfig.animationSize {
        get{
            let len = VideoConfig.animationSize(rawValue: defaults.integerForKey("userAnimationSize"))
            if len == nil{
                return VideoConfig.animationSize.medium
            }
            return len!
        }
        set{
            defaults.setInteger(newValue.rawValue, forKey: "userAnimationSize")
        }
    }

    
    //MARK: imgs
    enum maxImages : Int{
        case minimun 
        case max
        
        static let allValues :Array<VideoConfig.maxImages> = [minimun, max]
        
        var value : NSNumber{
            switch self{
            case .minimun: return 1
            case .max: return 216

            }
        }
    }
    
    
    //MARK: funcs
    func getLevel(rawValue : NSNumber) -> level{
        let lvl = level(rawValue: rawValue.integerValue)
        if lvl == nil {
            return level.indef
        }
        return lvl!
    }
    
    func getLenght(rawValue : NSNumber) ->length {
        let leng = length(rawValue: rawValue.integerValue)
        if leng == nil {
            return length.infinite
        }
        return leng!
    }
    
    func getPhraseStatus (rawValue : NSNumber) -> phraseStatus{
        let ph = phraseStatus(rawValue: rawValue.integerValue)
        if ph == nil{
            return phraseStatus.on
        }
        return ph!
    }
    
    
}
