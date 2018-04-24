//
//  CollectionCell.swift
//  app1131
//
//  Created by camila oliveira on 10/23/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CRCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteButton: DeleteButton!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var config: UILabel!
    @IBOutlet weak var lenght: UILabel!
    @IBOutlet weak var shareButton: ShareButton!
    @IBOutlet weak var continueAction: ContinueButton!
    var parent : CollectionView?
    
    private var dots : DotsFactory!
    
    var videoModel : VideoModelShow!{
        didSet{
            if videoModel != nil{
        
                thumbnail.image = videoModel.getThumbnail()
                
                title.text = videoModel.name
                config.text =  videoModel.length.description.capitalizedString + " / " + videoModel.level.description.uppercaseString
                lenght.text = videoModel.getVideoTime()
                continueAction.videoModel = self.videoModel
                
                deleteButton.color = self.videoModel.length.color.light
                dots?.color = self.videoModel.length.color.light
                
            }else{
                thumbnail.image = nil
                title.text = nil
                config.text = nil
                lenght.text = nil
            }
            
        }
    }
    private func getGradientbg(rect : CGRect) -> CAGradientLayer{
        let gd = CAGradientLayer()
        gd.colors = [ViewConfig.color.background.light.CGColor, ViewConfig.color.background.light.colorWithAlphaComponent(0).CGColor]
        gd.locations = [0.0 , 1.0]
        gd.frame = CGRectMake(0, 0, rect.width, rect.height)
        gd.startPoint = CGPointMake(0.6, 0)
        gd.endPoint = CGPointMake(0, 0)
        
        return gd
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.thumbnail.clipsToBounds = true
        deleteButton.setImgs()
        
        //add shadow na layer de tempo
        let bg = ViewConfig.color.background.light.colorWithAlphaComponent(0.6)
        self.lenght.backgroundColor = bg
        self.lenght.textColor = ViewConfig.text.time.color
        self.lenght.font = ViewConfig.text.time.font
        
        
        self.config.backgroundColor = bg
        self.config.textColor = ViewConfig.text.config.color
        self.config.font = ViewConfig.text.config.font
        
        self.title.backgroundColor = bg
        self.title.textColor = ViewConfig.text.titleVideo.color
        self.title.font = ViewConfig.text.titleVideo.font
        
        
        //border factory
        if dots == nil{
            let inst = BordersFactory(rect: self.frame)
            //get border
            let border = inst.getBorderOutsideIrregular()
            //get bg dots
            dots = getMaskedDots(rect, factory: inst)
            //insert into layer
            
            self.layer.insertSublayer(border, below: self.subviews.last?.layer)
            self.layer.insertSublayer(dots.layer, below: border)
            self.layer.insertSublayer(getGradientbg(rect), above: dots.layer)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: "performSegue")
        self.thumbnail.addGestureRecognizer(tap)
        self.thumbnail.userInteractionEnabled = true
        
    }
    
    private func getMaskedDots(rect : CGRect, factory : BordersFactory) -> DotsFactory{
        let dots = getDots().getByHeight(rect, color: self.videoModel.length.color.light)
        let mask = factory.getBorderOutsideIrregular()
        mask.borderColor = UIColor.clearColor().CGColor
        mask.fillColor = UIColor.blackColor().CGColor
        dots.layer.mask = mask
        return dots
    }
    private func getDots() -> DotsFactory.dots{
        let r = arc4random() % 2
        switch r{
        case 0 : return DotsFactory.dots.quadrado
        case 1 : return DotsFactory.dots.triangular
        default : return DotsFactory.dots.quadrado
        }

    }
    
    func performSegue() {
        
        parent?.performSegue(self.videoModel!)
    }
    
    override func prepareForReuse() {
        videoModel = nil

    }
    @IBAction func shareAction(sender: AnyObject) {
        #if DEBUG
            print("camila - CRCollectionCell- shareAction")
        #endif
        
        (sender as! ShareButton).share(self.videoModel)
    }
    
}

