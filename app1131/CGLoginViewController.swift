//
//  CGLoginViewController.swift
//  app1131
//
//  Created by camila oliveira on 12/5/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CGLoginViewController: GCGenericViewController {
    
    override var getBg : GondigBG? {
        return  CGLoginView(rect: self.view.frame)
    }
    override var fields : Array<TextFieldGondig> {
        return [fieldUser, fieldPass]
    }
    override var subirKeyboardConstant : CGFloat {
        get{
            return 0
        }
    }
    //MARK: TITLES
    @IBOutlet weak var titleLogin: UILabel!
    @IBOutlet weak var titleGondig: UILabel!
    
    //MARK: Labels
    @IBOutlet weak var labelUser: UILabel!
    @IBOutlet weak var labelPass: UILabel!

    //MARK: fields
    @IBOutlet weak var fieldUser: TextFieldGondig!
    @IBOutlet weak var fieldPass: TextFieldGondig!
    
    //MARK: buttons
    @IBOutlet weak var buttonForgotPass: UIButton!
    @IBOutlet weak var buttonLogin: CGBTRegister!
    @IBOutlet weak var buttonNewUser: UIButton!
    
    //MARK: constraints
    @IBOutlet weak var conLogin: NSLayoutConstraint!
    @IBOutlet weak var conDistantciaEntreTituloECampos: NSLayoutConstraint!
    @IBOutlet weak var conRightMargin: NSLayoutConstraint!
    @IBOutlet weak var conTitutloCentralizado: NSLayoutConstraint!
    @IBOutlet weak var conleftMargin: NSLayoutConstraint!
   
    @IBOutlet weak var conUserMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var conNewSpaceBotton: NSLayoutConstraint!
    func setConstraints(){
        let w  = self.view.frame.width
        let h = self.view.frame.height
        conLogin.constant = w * 0.3
        conDistantciaEntreTituloECampos.constant = h * 0.05
        conRightMargin.constant = w * 0.05
        conleftMargin.constant = w * 0.23
        conTitutloCentralizado.constant = w * 0.08
        if isCompactDevice{
            conUserMarginLeft.constant = w * 0.04
        }else{
            conUserMarginLeft.constant = w * 0.1
        }
        
        conNewSpaceBotton.constant = h * 0.09 
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        setTitles()
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if ViewConfig.instructions.login.hasToShow{
            ViewConfig.instructions.login.set(false)
            self.view.addSubview(BoomView.getBoom.mid.complete(self.view.frame, buttons: [
                "skip": {},
                "next" : {}
                ], text: "inst_login"))
        }
    }
    
    //MARK : ACTIONS
    @IBAction func forgotPassAction(sender: AnyObject) {
        //GIOVANI, NAO SEI PRA ONDE ENVIAR ELE, OU MESMO SE TEMOS ISSO
        // Temos nao kkkk Tem que fazer depois
    }
    
    @IBAction func newUserAction(sender: AnyObject){
        self.performSegueWithIdentifier("newUser", sender: nil)
    }

    @IBAction func loginAction(sender: AnyObject) {
        //GIOVANI
        let u = self.getUser()
        
        let b = BackEnd()
        
        b.login(u, completionHandler: { user in
            self.dismissViewControllerAnimated(true, completion: nil)
            self.logIn(u)
        })
    }
    
    func getUser () -> UserModel{
        let user : UserModel
        if isEmail(fieldUser.text!) {
           user = UserModel(email: fieldUser.text!, password: fieldPass.text!)
        }else{
           user = UserModel(username: fieldUser.text!, password: fieldPass.text!)
        }
        return user
    }
    
    func isEmail(str : String) -> Bool {
        //GIOVANI
        // Pow, validacao eu ainda nao tenho nao
        return str.containsString("@") && str.containsString(".com")
    }
    func setTitles(){

        //titulo login
        titleLogin.text = "login".localized
        titleLogin.font = ViewConfig.text.titleVideo.font
        
        //Botao login
        buttonLogin.setTitle("login".localized, forState: UIControlState.Normal)
        buttonForgotPass.setTitle("forgotPassword".localized, forState: UIControlState.Normal)
        
        buttonNewUser.setTitle("newUser".localized, forState: UIControlState.Normal)
        buttonNewUser.titleLabel?.font = ViewConfig.text.buttons.font
        buttonNewUser.setTitleColor(ViewConfig.text.buttons.color, forState: UIControlState.Normal)
        
        
        //labels
        labelPass.text = "pass".localized
        labelUser.text = "username".localized + " / " + "email".localized
        
        fieldUser.nextField = fieldPass
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
