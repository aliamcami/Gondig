//
//  LevelPicker.swift
//  app1131
//
//  Created by camila oliveira on 11/12/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit

class LevelPicker: GenericPicker {
    override var selectedTitle : String! {
        didSet{
            //seta o titulo no botao
            self.parentController.showLevelButton.setTitle(self.selectedTitle, forState: UIControlState.Normal)
        }
    }
    
    private var comps = VideoConfig.level.allValues
    
    override func drawRect(rect: CGRect) {
        
        //garante o que que estiver selecionado anteriormente venha selecionado inicialmente
        let row = VideoConfig.userLevel.rawValue
        self.selectRow(row, inComponent: 0, animated: false)
        selectedTitle = comps[row].description
        
        
        super.drawRect(rect)
        
    }
    
    override func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.comps.count - 1
        
    }
    override func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  self.comps[row].description
        
    }
    override func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        let label = (super.pickerView(pickerView, viewForRow: row, forComponent: component, reusingView: view)) as! UILabel
        label.text = self.comps[row].description

        
        return label
    }
    
    //delegate PICoverride KER VIEW
    //chama essa funcao quando termina de selecionar
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //mostra botao
        parentController.editLevel(false)
        parentController.activateCiruclarProgrees(true)
        
        //esconde a picker
        self.hidden = true
        
        //salvar nova config na userDefaults
        VideoConfig.userLevel = comps[row]
        
        //seta nova configuracao na storyModel
        self.parentController.storyModel.level = comps[row]
        
        //set selected title
        selectedTitle = self.comps[row].description
    }
    
    
    


}
