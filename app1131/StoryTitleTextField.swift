//
//  StoryTitleTextView.swift
//  app1131
//
//  Created by camila oliveira on 11/7/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class StoryTitleTextField: UITextField, UITextFieldDelegate {
    

    private var originalName : String!
    
    override var enabled : Bool{
        didSet{
            if enabled{
                self.originalName = self.text
                self.textColor = ViewConfig.text.titleVideo.color
                self.borderStyle = UITextBorderStyle.RoundedRect
            }else if !enabled{
                self.resignFirstResponder()
                self.textColor = ViewConfig.color.color6.dark
                self.borderStyle = UITextBorderStyle.None
                
                if self.text == ""{
                    self.text = originalName
                }
                
            }
        }
    }
  
    
    
    override func setNeedsDisplay() {
        self.delegate = self
        self.allowsEditingTextAttributes = true
        self.userInteractionEnabled = true
        self.tintColor = ViewConfig.text.titleVideo.color
        self.font = ViewConfig.text.titleVideo.font
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        self.enabled = false
        return false
    }

    
    func changedTitle(videoModel : VideoModel){
        dispatch_async(dispatch_get_main_queue(), {
            #if DEBUG
                print("camila - ControLViewContainer - changedTitle - desabilitando a edicao do titulo ")
            #endif
            
            // volta com titulo nao editavel, mas matem o mesmo titulo de antes
            self.enabled = false
//            self.borderStyle = UITextBorderStyle.None
            
            
            //verifica se o titulo mudou
            let original = videoModel.name
            if original == self.text{
                #if DEBUG
                    print("camila - ControLViewContainer - Changed title -> titulo nao mudou, retornando")
                #endif
                return
            }
            
            #if DEBUG
                print("camila - ControLViewContainer - Changed title -> titulo Mudou, tentando dar update")
            #endif
            
            self.changeTitle(videoModel, newName: self.text!)
            
        })
    }
    
    private func changeTitle(videoModel : VideoModel, newName : String){
        #if DEBUG
            print("camila - ControLViewContainer - changeTitle - de \(videoModel.name) to \(newName)")
        #endif
        
        
        let original = videoModel.name
        
        var updateSuccess = false
        var name = newName
        for i in 2...20{
            //titulo mudou, tentando dar update
            updateSuccess = VideoDatabase().updateName(name, video: videoModel)
            if updateSuccess {
                self.text = name
                break;
            }else{
                name = newName
            }
            
            name = name +  ("_\(i)")
        }
        
        
        if updateSuccess{
            #if DEBUG
                print("camila - ControLViewContainer - Changed title -> Update OK \(original) -> \(self.text)")
            #endif
            //seta novo titulo
            videoModel.name = name
            
            
            //update na collection!
            let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
            let root = appDelegate.window?.rootViewController as! CRPageViewController
            let showAll = root.showAllVideosControll
            let collecion = showAll.collectionViewCR
            collecion?.reloadSections(NSIndexSet(index: 0))
            
        }else{
            #if DEBUG
                print("camila - ControLViewContainer - Changed title -> update falhou, retornando para titulo original \(original)")
            #endif
            
            self.text = original
        }

    }
    

}

