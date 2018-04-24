//
//  FactoryRandomFrases.swift
//  app1131
//
//  Created by camila oliveira on 10/29/15.
//  Copyright © 2015 Giovani Ferreira Silvério da Silva. All rights reserved.
//

import UIKit


var firstItem : String!

//0 - must be first item or not appear - MUST BE FIRST CATEGORIE IN ARRAY
var youAreBean : Array<String>!

//1 - if this is second then "and" mus appear
var youHave : Array<String>!

//2 - if first then "are / está" must appear
var youArePlace : Array<String>!

//3 - if second then " , " mus appear
var youSaw : Array<String>!

//4 - must never be the first --MUST BE LAST CATEGORIE IN ARRAY
var youWith : Array<String>!

//final - nao entra no array de tudo
var final : Array<String>!
//ALL categories
let categories = [youAreBean, youHave, youArePlace, youSaw, youWith]


//pensar na possibilitade de níveis mais dificeis acrescentar palavras mais dificeis, e facil soh palavra pra crianca entender.
class FactoryRandomPhrase: NSObject {
    
    func getPhrase () -> String{
        #if DEBUG
            print("camila - FactoryRandomPhrase - GetPhrase")
        #endif
        
        let n1 = getRandomNumberMax(3)
        var n2 = getRandomNumberMax(4) + 1
        for (;;){
            if n1 != n2 && !((n1 == 1 || n1 == 2) && n2 == 4){
                break
            }
            n2 = getRandomNumberMax(4) + 1
        }
        let primeiraCategoria = categories[n1]
        var segundaCategoria = categories[n2]
        let fim = final[getRandomNumberMax(final.count)]
        
        let str = "\(firstItem.localized)\(primeiraCategoria[0].localized)\(getRandomElement(primeiraCategoria).localized)\(segundaCategoria[1].localized)\(getRandomElement(segundaCategoria).localized)\(fim) \n"
        #if DEBUG
            print("camila - FactoryRandomPhrase - GetPhrase - :\(str)")
        #endif
        
        return str
    }
    
    
    private func getRandomElement(categ : [String]) -> String{
        let max = categ.count - 2
        return categ[getRandomNumberMax(max) + 2]
    }
    
    private func getRandomNumberMax (max : Int) -> Int{
        return Int(arc4random_uniform(UInt32(max)))
    }
    
    override init() {
        super.init()
        setaArraysDeFrases()
        
          }
    
    func setaArraysDeFrases(){
        switch "language".localized {
        case "pt.br" :
            firstItem = "Você"
            youAreBean = [" é ", " ", "um cachorro", "um ser humano", "um golfinho", "um peixe", "um gato", "um pinguim", "uma pessoa baixa", "algém muito alto", "um ser forte", "uma arvore", "um tubarão", "uma mulher", "um homem", "uma criança", "um alienigena", "um marciano", "um estrangeiro", "um japonês", "um chines", "um brasileiro", "um americano", "um barbudo"]
            youHave = [" tem ",", tem ", "um livro", "uma tesoura", "um celular", "um ipad", "uma cadeira", "um cabo USB", "uma caneta", "um peixe", "cabelo rosa", "um sapato"]
            youArePlace = [" está ", " ", "na fila", "no show", "no salão de beleza", "na praia", "no BEPiD", "na escola"]
            youSaw = youHave
            youWith = youSaw
            final = [" e...", " então...", " quando..."]
            
            
            var temp = youAreBean
            temp.removeFirst(2)
            
            youWith[0] = " "
            youWith[1] = " com "
            
            youSaw[0] = " viu "
            youSaw[1] = " viu "
            youSaw.appendContentsOf(temp)

        case "en" :
            firstItem = "You"
            youAreBean = [" are ", " ", "a dog", "a human", "a dolphin", "a fish", "a tree", "a shark", "a woman", "a man", "a child", "an alien", "an american", "an outsider", "a japanese", "a chinese", "a brasilian", "a frog", "a pengin", "boring"]
            youHave = [" have ",", have", "a book", "a celphone", "an iphad", "a chair", "an usb cabe", "a pen", "a fish", "a dog", "pink hair" ]
            youArePlace = [" are ", " ", "in line", "in the show", "in the house", "on the beach", "in the hospital", "in America", "in Brazil", "on the shopping", "on BEPiD", "at school"]
            youSaw = youHave
            youWith = youSaw
            final = [" and...", " then...", " when..."]
            
            
            var temp = youAreBean
            temp.removeFirst(2)
            
            youWith[0] = " "
            youWith[1] = " with "
            
            youSaw[0] = " saw "
            youSaw[1] = " saw "
            youSaw.appendContentsOf(temp)
            
        default : break
            
        }

    }
    
}
