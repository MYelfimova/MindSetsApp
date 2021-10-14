//
//  GameScreenViewController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 4/29/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit
import Foundation

class GameScreenViewController: VCLLoggingViewController, updateLabelsDelegate {
    
    //MARK: - Properties
    
    var setsCounted = 0
    var pointsCounted = 0
    var gameTimer = Timer()
    var timeDisplayed = 0
    
    lazy var animator = UIDynamicAnimator(referenceView: view.superview ?? view)
    lazy var cardBehavior = GameOverCardBehavior(in: animator)
    
    @IBOutlet weak var cardsGameView: CardsGameView!
    
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        //cardsGameView.isNewGame = true
        pauseTimer()
        let pausePopup = storyboard?.instantiateViewController(withIdentifier: "pausePopUpViewController") as! PausePopUpViewController

        let pausePopupShaped = CardPopupViewController(contentViewController: pausePopup)
        
        pausePopup.pauseDelegate = cardsGameView
        pausePopupShaped.show(onViewController: self)
    }
    
    @IBAction func dealButtonPressed(_ sender: UIButton) {
        cardsGameView.dealCards()
    }
    @IBAction func hintButtonPressed(_ sender: UIButton) {
        cardsGameView.getHint()
    }
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHighScore(score: 0)
        self.cardsGameView.delegate = self
        dealButton.layer.cornerRadius = 20
        hintButton.layer.cornerRadius = 20
        createObservers()
        
        print("DEBUG: INIT: \(self)")
    }
    
    override func applicationFinishedRestoringState() {
        super.applicationFinishedRestoringState()
        print("DEBUG: Finished restoring state")
    }
    
    deinit {
        print("DEBUG: DEINIT: \(self.description)")
    }
    
    
    //MARK: - Timer Functions
    func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        gameTimer.invalidate()
    }
    
    func resetTimer() {
        gameTimer.invalidate()
        self.timeDisplayed = 0
        timerLabel.text = "00:00"
    }
    
  

    
    //MARK: - Additional Functions fro updating Views inside
    
    func updateSetsLabel(sets: Int) {
        setsCounted = sets
        animateLabel(label: setsLabel, text: "Sets: \(sets)")
    }
    func updateScorelabel(score: Int) {
        pointsCounted = score
        animateLabel(label: scoreLabel, text: "Score: \(score)")
    }
    func loadHighScore(score: Int) {
        let defaults = UserDefaults.standard
        let userBestScore = defaults.integer(forKey: "UserBestScore")
        let newScore = max(userBestScore,score,0)
        
        defaults.set(newScore, forKey: "UserBestScore")
        if newScore != userBestScore {
            animateLabel(label: highScoreLabel, text: "High Score: \(newScore)")
        } else {
            self.highScoreLabel.text = "High Score: \(newScore)"
        }
        
    }
    

    
    
    // segues end game screen
    @objc func runGameOverAnimation() {
        let tempViewArray = cardsGameView.viewArray.shuffled()
        for view in tempViewArray {
            cardBehavior.addItem(view)
        }
    }
    @objc func openGameOverView() {
        performSegue(withIdentifier: "toGameOverView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameOverView" {
            let gameOverview = segue.destination as! GameOverPopupViewController
            
            gameOverview.timerString = timerLabel.text ?? "11:11"
            gameOverview.numberOfPoints = pointsCounted
            gameOverview.numberOfSets = setsCounted
        }
    }
    


    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(GameScreenViewController.showGameRules(notification:)), name: Notification.Name.showGameRules, object: nil)
    }
    
    @objc private func showGameRules(notification: NSNotification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let swipingController = TutorialController(collectionViewLayout: layout)
            swipingController.modalPresentationStyle = .popover
            self.present(swipingController, animated: true, completion: nil)
        }
        
    }
    
}



extension Notification.Name {
    //static let resumeGame = Notification.Name("resumeGame")
    //static let startOverNewGame = Notification.Name("startOverNewGame")
    static let showGameRules = Notification.Name("showGameRules")
}


extension GameScreenViewController {
    
    private func animateLabel(label: UILabel, text: String) {
        UIView.animate(
            withDuration: 0.25,
            animations: { () -> Void in
                label.transform = .init(scaleX: 1.18, y: 1.18)
            }) { (finished: Bool) -> Void in
            label.text = text
            UIView.animate(withDuration: 0.30, animations: { () -> Void in
                label.transform = .identity
            })
        }
    }
    
    func updateButtonStatus() {
        if cardsGameView.dealCardsButtonIsActive {
            dealButton.isEnabled = true
            dealButton.backgroundColor = UIColor.buttonWhiteColor
            dealButton.alpha = 1
        } else {
            dealButton.isEnabled = false
            dealButton.backgroundColor = UIColor.buttonGrayColor
            dealButton.alpha = 0.5
        }
        
        if cardsGameView.hintButtonIsActive {
            hintButton.isEnabled = true
            hintButton.backgroundColor = UIColor.buttonYellowColor
            hintButton.alpha = 1
        } else {
            hintButton.isEnabled = false
            hintButton.backgroundColor = UIColor.buttonGrayColor
            hintButton.alpha = 0.5
        }
        
        // this condition indicated end of the game and call end of the game screen
        if ((cardsGameView.game.cards.count<=12 && cardsGameView.game.getHintIndices() == [-10,-10,-10])) //  || setsCounted == 3)
        {
            gameTimer.invalidate()
            perform(#selector(runGameOverAnimation), with: nil, afterDelay: 2)
            perform(#selector(openGameOverView), with: nil, afterDelay: 4)
        }
    }
    
    
    @objc func countTimer() {
        self.timeDisplayed += 1
        
        if (self.timeDisplayed < 3600) {
            if (self.timeDisplayed % 60) <= 9 {
                if (self.timeDisplayed/60) <= 9{
                    self.timerLabel.text = "0\(Int(self.timeDisplayed / 60)):0\(self.timeDisplayed % 60)"
                }
                else {
                    self.timerLabel.text = "\(Int(self.timeDisplayed / 60)):0\(self.timeDisplayed % 60)"
                }
            } else {
                if (self.timeDisplayed/60) <= 9{
                    self.timerLabel.text = "0\(Int(self.timeDisplayed / 60)):\(self.timeDisplayed % 60)"
                }
                else {
                    self.timerLabel.text = "\(Int(self.timeDisplayed / 60)):\(self.timeDisplayed % 60)"
                }
            }
        }
        else {
            if (self.timeDisplayed % 60) <= 9 {
                if (self.timeDisplayed/60) <= 9{
                    self.timerLabel.text = "0\(self.timeDisplayed % 3600):0\(Int(self.timeDisplayed / 60)):0\(self.timeDisplayed % 60)"
                }
                else {
                    self.timerLabel.text = "0\(self.timeDisplayed % 3600):\(Int(self.timeDisplayed / 60)):0\(self.timeDisplayed % 60)"
                }
            } else {
                if (self.timeDisplayed/60) <= 9{
                    self.timerLabel.text = "0\(self.timeDisplayed % 3600):0\(Int(self.timeDisplayed / 60)):\(self.timeDisplayed % 60)"
                }
                else {
                    self.timerLabel.text = "0\(self.timeDisplayed % 3600):\(Int(self.timeDisplayed / 60)):\(self.timeDisplayed % 60)"
                }
            }
        }
        
    }
    
    
}
