//
//  PauseGameViewController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 21/10/2021.
//  Copyright © 2021 Maria Yelfimova. All rights reserved.
//

import UIKit

class PauseGameViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var resumeGameButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }
    
    //MARK: - Additional funcs

    @IBAction func resumeGameButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name.resumeGame, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func howToPlayButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name.showGameRules, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name.startOverNewGame, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpButtons() {
        
        buttonsView.layer.cornerRadius = 30
        buttonsView.layer.borderWidth = 0.5
        buttonsView.layer.borderColor = UIColor.mainGray.cgColor
        
        let resumeButtonTitle = NSMutableAttributedString(string: Constants.rulesTitle, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        howToPlayButton.setAttributedTitle(resumeButtonTitle, for: .normal)
        
        let buttons: [UIButton] = [newGameButton, resumeGameButton]
        
        for button in buttons {
            button.layer.cornerRadius = 20
            button.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
            button.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        }
    }
    
    deinit {
        print("DEBUG: DEINIT: \(self.description)")
    }
}
