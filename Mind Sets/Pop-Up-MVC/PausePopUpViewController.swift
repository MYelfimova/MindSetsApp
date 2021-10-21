//
//  PausePopUpViewController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 5/9/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import Foundation

import UIKit


protocol UpdateGameStatus: class {
    func newGame(from: String)
    func gameResumed()
}

class PausePopUpViewController: UIViewController, CardPopupContent { //VCLLoggingViewController,
    
    var popupViewController: CardPopupViewController?
    var allowsTapToDismissPopupCard: Bool = true
    var allowsSwipeToDismissPopupCard: Bool = true
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    var pauseDelegate: UpdateGameStatus?
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        print("delegate sent")
        pauseDelegate?.newGame(from: "popup")
        //NotificationCenter.default.post(name: Notification.Name.startOverNewGame, object: nil)
        self.popupViewController?.close()
    }
    
    @IBAction func howToPlayButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name.showGameRules, object: nil)
        self.popupViewController?.close()
    }
    
    @IBAction func resumeButtonPressed(_ sender: UIButton) {
        print("delegate sent")
        //NotificationCenter.default.post(name: Notification.Name.resumeGame, object: nil)
        pauseDelegate?.gameResumed()
        self.popupViewController?.close()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        udjustButtonsLook()
        print("DEBUG: INIT: \(self)")
    }
    
    func udjustButtonsLook() {
        
        let resumeButtonTitle = NSMutableAttributedString(string: Constants.rulesTitle, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        howToPlayButton.setAttributedTitle(resumeButtonTitle, for: .normal)
        
        let buttons: [UIButton] = [newGameButton, resumeButton]
        
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
