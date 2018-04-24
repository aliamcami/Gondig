//
//  BackButton.swift
//  app1131
//
//  Created by camila oliveira on 12/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class BackButton: FowardButton {

    override func drawRect(rect: CGRect) {
        self.setImage(UIImage(named: "Back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
    }

}
