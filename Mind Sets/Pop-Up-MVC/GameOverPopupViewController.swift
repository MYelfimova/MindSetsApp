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
    
    var numberOfSets = 0
    var numberOfPoints = 0
    var timerString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsLabel.text = "Sets: \(numberOfSets)"
        pointsLabel.text = "Points: \(numberOfPoints)"
        timeLabel.text = "Time: \(timerString)"
        udjustOutletsLook()
    }
        
    
    @IBAction func newGameButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var setsLabel: UILabel!
    
    @IBOutlet weak var buttonNewGameLook: UIButton!
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
        print("DEINIT: \(self.description)")
    }
}
