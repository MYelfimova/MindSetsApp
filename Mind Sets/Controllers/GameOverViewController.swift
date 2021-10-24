//
//  GameOverViewController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 21/10/2021.
//  Copyright © 2021 Maria Yelfimova. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var statsView: UIView!
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        //post notification
        NotificationCenter.default.post(name: Notification.Name.startOverNewGame, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpLabels()
    }
    
    
    //MARK: - Additional Funcs
    private func setUpLabels() {
        self.setsLabel.text = "Sets: \(GameScreenModel.setsCounted)"
        self.pointsLabel.text = "Points: \(GameScreenModel.pointsCounted)"
        self.timeLabel.text = "Time: \(Timer.calculateTimerLabel())"
    }
    
    private func setUpSubviews() {
        
        statsView.layer.cornerRadius = 30
        statsView.layer.borderWidth = 0.5
        statsView.layer.borderColor = UIColor.mainGray.cgColor
        
        let outlets: [UILabel] = [pointsLabel, setsLabel, timeLabel]
        
        for label in outlets {
            label.layer.cornerRadius = 20.0
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.widthAnchor.constraint(equalToConstant: 170.0).isActive = true
            label.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        }
        newGameButton.layer.cornerRadius = 20
        newGameButton.widthAnchor.constraint(equalToConstant: 170.0).isActive = true
        newGameButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    }
    
    deinit {
        print("DEBUG: DEINIT: \(self.description)")
    }

}
