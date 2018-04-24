//
//  CadastroViewController.swift
//  app1131
//
//  Created by camila oliveira on 12/4/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class CadastroViewController: GCGenericViewController {
    //MARK: IBOtlets
    //MARK: campos
    @IBOutlet weak var fieldUser: TextFieldGondig!
    @IBOutlet weak var fieldEmail: TextFieldGondig!
    @IBOutlet weak var fieldPass: TextFieldGondig!
    @IBOutlet weak var fieldPassConf: TextFieldGondig!
    override var fields : Array<TextFieldGondig> {
        return [fieldUser, fieldEmail, fieldPass, fieldPassConf]
    }
    
    //MARK: campos label
    @IBOutlet weak var labelUser: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPass: UILabel!
    @IBOutlet weak var labelPassConf: UILabel!
    var labels : Array<UILabel>{
        return [labelUser, labelEmail, labelPass, labelPassConf]
    }
    
    //MARK : titulos
    @IBOutlet weak var tituloGondig: UILabel!
    @IBOutlet weak var tituloNewUser: UILabel!
    @IBOutlet weak var tituloAllNeeded: UILabel!
    
    
    //MARK: confirm
    @IBOutlet weak var ButtonConfirm: UIButton!
    @IBOutlet weak var buttonCancel: CancelButton!
    
        //MARK : constraints
    @IBOutlet weak var stackViewFields: UIStackView!
    @IBOutlet weak var conLeading: NSLayoutConstraint!
    @IBOutlet weak var conDispanciaEntreTituloseCompos: NSLayoutConstraint!
    @IBOutlet weak var conTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var conTitutloTop: NSLayoutConstraint!
    override var getBg : GondigBG{
        return GCadastroView(rect: self.view.frame)
    }
    @IBOutlet weak var conBotaoTop: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        ButtonConfirm.enabled = false
        setTitles()
         setConstraints()
       
    }
    func setConstraints(){
        let w = self.view.frame.width
        let h = self.view.frame.height
        conLeading.constant = w * 0.05
        conTrailing.constant = w * 0.263
        conDispanciaEntreTituloseCompos.constant = h * 0.02
        conTitutloTop.constant = h * 0.25
        conBotaoTop.constant = h * 0.05
        if isCompactDevice{
            stackViewFields.spacing = 25
        }else{
            stackViewFields.spacing = 35
        }
        
    }
    
     func verifyFieldsToReactivateButton (){
        var ok = true
        for i in fields{
            ok = i.valid
            if !ok{
                break
            }
        }
        ButtonConfirm.enabled = ok
    }
    func setTitles (){
        labelUser.text = "username".localized
        labelEmail.text = "email".localized
        labelPass.text = "pass".localized
        labelPassConf.text = "passConfim".localized
        
        //SET NEXT TEXT FIELD
        fieldUser.nextField = fieldEmail
        fieldEmail.nextField = fieldPass
        fieldPass.nextField = fieldPassConf
        for v in fields{
//            v.nextField = i < fields.count ? fields[i] : nil
            v.parent = self
        }
        
        //CANCEL BUTTON
        buttonCancel.setTitle("cancel".localized, forState: UIControlState.Normal)
        buttonCancel.color = ViewConfig.color.color5.dark
        
        //BUTTON CONFIRM
        ButtonConfirm.setTitle("register".localized, forState: UIControlState.Normal)
        
        tituloAllNeeded.text = "allNeed".localized
        tituloNewUser.text = "newUser".localized

        tituloAllNeeded.font = ViewConfig.text.config.font
        tituloNewUser.font = ViewConfig.text.titleVideo.font
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getUser () -> UserModel{
        return UserModel(email: fieldEmail.text!, password:fieldPass.text!, username: fieldUser.text!)
    }
    
    //MARK: actions
    @IBAction func registerAction(sender: AnyObject) {
        //GIOVANI
        let user = getUser()
        
        let b = BackEnd()
        
        b.registerUser(user, completionHandler: { user in
            self.dismissViewControllerAnimated(true, completion: nil)
            self.logIn(user)
        })
    
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

}
