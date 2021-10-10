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

class PausePopUpViewController: VCLLoggingViewController, CardPopupContent {
    
    var popupViewController: CardPopupViewController?
    
    var allowsTapToDismissPopupCard: Bool = false //true
    
    var allowsSwipeToDismissPopupCard: Bool = false //true
    
    
    @IBOutlet weak var newGameButton: UIButton!
    
  //  @IBOutlet weak var howToPlayButton: UIButton!
    
    @IBOutlet weak var resumeButton: UIButton!
    
    
    //Declaring the protocol delegate which I initialize in the didLoad() method of the GameScreenViewController.
    var pauseDelegate: UpdateGameStatus?
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        print("delegate sent")
        pauseDelegate?.newGame(from: "popup")
        self.popupViewController?.close()
    }
    
  //  @IBAction func howToPlayButtonPressed(_ sender: UIButton) {
        // performSegue(withIdentifier: "showHowToPlaySegue", sender: self)
 //   }
    
    @IBAction func resumeButtonPressed(_ sender: UIButton) {
        print("delegate sent")
        pauseDelegate?.gameResumed()
        self.popupViewController?.close()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        udjustButtonsLook()
    }
    
    func udjustButtonsLook() {
        // let buttons: [UIButton] = [newGameButton, howToPlayButton, resumeButton]
         let buttons: [UIButton] = [newGameButton, resumeButton]
        
        for button in buttons {
            button.layer.cornerRadius = 20
            button.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
            button.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        }
    }

}
