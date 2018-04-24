//
//  LenghPicker.swift
//  app1131
//
//  Created by camila oliveira on 11/11/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class LenghPicker: GenericPicker {
    
    override var selectedTitle : String! {
        didSet{
            //seta o titulo no botao
            self.parentController.showLenghtButton.setTitle(self.selectedTitle, forState: UIControlState.Normal)
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        //garante o que que estiver selecionado anteriormente venha selecionado inicialmente
        let row = VideoConfig.userLength.rawValue
        self.selectRow(row, inComponent: 0, animated: false)
        selectedTitle = comps[row].valueDescription
        self.parentController.showLenghtButton.color = self.comps[row].color
        super.drawRect(rect)
    }
    
    private var comps = VideoConfig.length.allValues
        
    override func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.comps.count
        
    }
    override func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return  self.comps[row].description
        
    }
    override func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {

        let label = (super.pickerView(pickerView, viewForRow: row, forComponent: component, reusingView: view)) as! UILabel

        label.text = "\(self.comps[row].valueDescription)"
//        label.textColor = self.comps[row].color.dark
        label.backgroundColor = self.comps[row].color.light
        
        return label
    }
    
    //delegate PICKER VIEW
    //chama essa funcao quando termina de selecionar
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       //mostra botao
        parentController.editLength(false)
        parentController.activateCiruclarProgrees(true)
        
        //esconde a picker
//        self.hidden = true
        
        //seta nova configuracao na storyModel
        self.parentController.storyModel.length = comps[row]
        ViewConfig.root.camera?.reloadViews()
        
        //salvar nova config na userDefaults
        VideoConfig.userLength = comps[row]
        
        //set selected title
        selectedTitle = self.comps[row].valueDescription
        
        
    }
    
    
    
    
}
