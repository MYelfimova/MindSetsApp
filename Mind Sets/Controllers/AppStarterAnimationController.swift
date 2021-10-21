//
//  AppStarterAnimationController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 11/10/2021.
//  Copyright © 2021 Maria Yelfimova. All rights reserved.
//

import UIKit
import Lottie

class AppStarterAnimationController: UIViewController {
    // 1. Create the AnimationView
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG: INIT: \(self.description)")
        runStartingAnimation()
        perform(#selector(navigateToGame), with: nil, afterDelay: 1.2)
    }
    
    @objc private func navigateToGame() {
        let isAppAlreadyLaunchedOnce = isAppAlreadyLaunchedOnce()
        if isAppAlreadyLaunchedOnce {
            startGame()
        } else {
            startTutorial()
        }
    }
    
    private func runStartingAnimation() {
        self.view.backgroundColor = UIColor.white
        animationView = .init(name: "startScreen")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        animationView!.play()
    }
    
    
    private func startTutorial() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let tutorialController = TutorialController(collectionViewLayout: layout)
        tutorialController.modalPresentationStyle = .fullScreen //.popover
        tutorialController.modalTransitionStyle = .crossDissolve
        tutorialController.isOpenedFromPopup = false
        self.present(tutorialController, animated: true, completion: nil)
    }
    
    private func startGame() {
        let storyboard = UIStoryboard(name: "Main" , bundle: nil)
        let gameScreen = storyboard.instantiateViewController(withIdentifier: "gameScreenView") as! GameScreenViewController
        
        UIApplication.shared.windows.first?.rootViewController = gameScreen
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(false, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    deinit {
        print("DEBUG: DEINIT: \(self.description)")
    }
}

