//
//  GCGenericViewController.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class GCGenericViewController: UIViewController, Pageble {
    //pagable
    private var pInd : NSNumber?
    var pageIndex : Int{
        get{
            if pInd == nil {
                return 0
            }
            return (self.pInd?.integerValue)!
        }
        set{
            pInd = NSNumber(integer: newValue)
        }
    }
    

    
    var fields : Array<TextFieldGondig>{
        return []
    }
    var getBg : GondigBG? {
        return nil
    }
    var bg : GondigBG!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bg = self.getBg!
        self.view.addSubview(bg)
        self.view.sendSubviewToBack(bg)
        self.view.layer.masksToBounds = true
        self.view.layer.borderColor = ViewConfig.color.borderColor.dark.CGColor
        self.view.layer.borderWidth = ViewConfig.widths.borderFrame
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        let tap = UITapGestureRecognizer(target: self, action: "hideKeyBoard")
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func hideKeyBoard(){
        for i in fields{
            i.resignFirstResponder()
        }
    }
    
    var subirKeyboardConstant : CGFloat {
        get{
            if isCompactDevice{
                return 150
            }else{
                return 0
            }
        }
    }
    private var hasKeyboard = false
    func keyboardWillShow(sender: NSNotification) {
        if !hasKeyboard{
            UIView.animateWithDuration(0.5, animations: {
                self.view.frame.origin.y -= self.subirKeyboardConstant
                self.hasKeyboard = true
            })
        }
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if hasKeyboard{
            UIView.animateWithDuration(0.5, animations: {
                self.view.frame.origin.y += self.subirKeyboardConstant
                self.hasKeyboard = false
            })
        }
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func logIn (user : UserModel)  -> Bool {
        #if DEBUG
            print("camila GCGenericViewController - tentando LOG IN")
        #endif

        #if DEBUG
            print("camila GCGenericViewController - log in - todos os fields  OK, seguindo em frente")
        #endif
       
        ViewConfig.root.root?.changeGondigViewTo(UIStoryboard(name: "Network", bundle: nil).instantiateViewControllerWithIdentifier("shelf") as! GCGenericViewController)
       
        return true
    }

    func logOut() -> Bool{
        //GIOVANI
        // É só tirar o id do nsuserdefaults kkkk pq isso é o nosso login kkkkkkk
        // Mas deixa sem nada msm
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}