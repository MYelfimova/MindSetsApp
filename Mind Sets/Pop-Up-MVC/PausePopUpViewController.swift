//
//  PausePopUpViewController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 5/9/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import Foundation

import UIKit


protocol UpdateGameStatus: AnyObject {
    func newGame(from: String)
    func gameResumed()
}

class PausePopUpViewController: VCLLoggingViewController, CardPopupContent {
    
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
        self.popupViewController?.close()
    }
    
    @IBAction func howToPlayButtonPressed(_ sender: UIButton) {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = SwipingController(collectionViewLayout: layout)

        let nav = UINavigationController(rootViewController: swipingController)
        nav.present(SwipingController(), animated: true, completion: nil)
    }
    
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
        print("DEINIT: \(self.description)")
    }

}
