//
//  GenericPicker.swift
//  app1131
//
//  Created by camila oliveira on 11/13/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class GenericPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    var selectedTitle : String!
    var parentController : CRCameraControlBridge!
    var font = ViewConfig.text.buttons.font

    
    //configs
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    //OVERRIDE
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //override
        return 0
        
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //override
        return  ""
        
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 70
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        let label = UILabel()
        label.font = self.font
        label.textColor = ViewConfig.text.buttons.color
        label.textAlignment = NSTextAlignment.Center

        label.layer.backgroundColor = ViewConfig.color.background.light.CGColor
        label.layer.borderWidth = ViewConfig.widths.borderFrame
        label.layer.borderColor = ViewConfig.color.borderColor.light.CGColor
        
        return label
    }
    
 
 
    


}
