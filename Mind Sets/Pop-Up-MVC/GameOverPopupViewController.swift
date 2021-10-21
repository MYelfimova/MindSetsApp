//
//  GameOverPopupViewController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 5/10/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import Foundation
import UIKit

class GameOverPopupViewController: UIViewController {
    
    var numberOfSets = GameScreenModel.setsCounted
    var numberOfPoints = GameScreenModel.pointsCounted
    var timerString = GameScreenModel.timeDisplayed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.setsLabel.text = "Sets: \(numberOfSets)"
//        self.pointsLabel.text = "Points: \(numberOfPoints)"
//        self.timeLabel.text = "Time: \(timerString)"
       // udjustOutletsLook()
    }
        
    
    @IBAction func newGameButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var pointsLabel: UILabel!
    
    @IBOutlet var setsLabel: UILabel!
    
    @IBOutlet var buttonNewGameLook: UIButton!
    func udjustOutletsLook() {
        let outlets: [UILabel] = [pointsLabel, setsLabel, timeLabel]
        
        for label in outlets {
            label.layer.cornerRadius = 20.0
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
            label.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        }
        buttonNewGameLook.layer.cornerRadius = 20
        buttonNewGameLook.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
        buttonNewGameLook.heightAnchor.constraint(equalToConstant: 60.0).isActive = true


        

        
    }
    
    deinit {
        print("DEBUG: DEINIT: \(self.description)")
    }
}
