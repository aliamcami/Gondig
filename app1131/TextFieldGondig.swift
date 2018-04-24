//
//  TextFieldGondig.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class TextFieldGondig: UITextField, UITextFieldDelegate {
    var nextField : UITextField?
    var parent : CadastroViewController?
    var valid = true
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        self.delegate = self
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.borderStyle = UITextBorderStyle.None
        self.layer.borderWidth = 0.5
        self.layer.borderColor = ViewConfig.color.color5.light.CGColor
        self.font = ViewConfig.text.titleVideo.font
        self.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.delegate = self
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if nextField == nil{
            self.resignFirstResponder()
        }else{
            self.nextField?.becomeFirstResponder()
        }

        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.4, animations: {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, self.frame.height * 2)
        })
        setValid()
    }
    func setInvalid (){
        self.layer.borderColor = ViewConfig.color.color4.dark.CGColor
        self.layer.borderWidth = ViewConfig.widths.borderFrame * 0.5
    }
    func setValid (){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = ViewConfig.color.color5.light.CGColor
        parent?.verifyFieldsToReactivateButton()
    }
    
    func verify (){
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.4, animations: {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, self.frame.height / 2)
        })
        
        verify()
    }
    
}
