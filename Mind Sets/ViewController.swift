//
//  ViewController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 4/29/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print("Let's print it all babe!!\n")
        var game = CardsGame()
        
        print("all cards: \(game.cards)")
        print("all visible cards: \(game.cards.filter({$0.isVisible}))")
        
        game.cards[0].isSelected = true; game.cards[1].isSelected = true; game.cards[2].isSelected = true
        
        print("all selected cards: \(game.cards.filter({$0.isSelected}))")
        
        print("matching cards: \(game.checkMatching())")
        
        print("\n\n Starting to look for HINTS:\n")
        print(game.getHintIndices())
        
        
    }


}

