//
//  GCNewsCollectionViewCell.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class GNewsCollectionViewCell: UICollectionViewCell {
    var parent : GNCollectionView!
    @IBOutlet weak var titleVideo: UILabel!
    @IBOutlet weak var extraInfoVideo: UILabel!
    @IBOutlet weak var videoPlaceHolder: UIImageView!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var videoPlayerBG: UIView!
    @IBOutlet weak var buttonUserLink: UIButton!
    @IBOutlet weak var stackViewConfig: UIStackView!
    @IBOutlet weak var stackViewInfo: UIStackView!
    
    var storyModel : VideoModelShow?{
        didSet{
            titleVideo.text = storyModel!.name
            extraInfoVideo.text = "\(storyModel!.length.valueDescription) / \(storyModel!.level.description) - "
            buttonUserLink.setTitle("@UserName", forState: UIControlState.Normal)
            length.text = storyModel!.getVideoTime()
            videoPlaceHolder.image = storyModel?.getThumbnail()
        }
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        videoPlaceHolder.layer.masksToBounds = true
        
        titleVideo.font = ViewConfig.text.titleVideo.font
        titleVideo.numberOfLines = 3
        
        extraInfoVideo.font = ViewConfig.text.config.font
        extraInfoVideo.textColor = ViewConfig.text.config.color
        
//        self.layer.borderColor = ViewConfig.color.borderColor.dark.CGColor
//        self.layer.borderWidth = ViewConfig.widths.borderFrame
        
        let tap = UITapGestureRecognizer(target: self, action: "performSegue")
        self.videoPlayerBG.addGestureRecognizer(tap)
        
        self.layer.addSublayer(getDiv())
 
    }
    func getDiv () -> CAShapeLayer{
        let path = UIBezierPath()
        let x = self.frame.width
        let y = self.frame.height
        path.moveToPoint(CGPointMake(x * 0.1, y))
        path.addLineToPoint(CGPointMake(x * 0.9, y))

        let shape = CAShapeLayer()
        shape.path = path.CGPath
        shape.strokeColor = ViewConfig.color.borderColor.dark.CGColor
        shape.lineWidth = 1
        
        return shape
    }
    override func setNeedsLayout() {
        super.setNeedsLayout()
//        backgroundColor = ViewConfig.color.background.light
        if !isCompactDevice{
            titleVideo.textAlignment = NSTextAlignment.Left
            extraInfoVideo.textAlignment = NSTextAlignment.Left
            stackViewConfig.axis = UILayoutConstraintAxis.Vertical
            stackViewConfig.alignment = UIStackViewAlignment.Leading
            stackViewInfo.alignment = UIStackViewAlignment.Leading
        }
    }
    
    func performSegue() {
       parent.performSegue(self.storyModel!)
        
    }

}
