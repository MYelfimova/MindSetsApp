//
//  LottieAnimationVC.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 11/10/2021.
//  Copyright © 2021 Maria Yelfimova. All rights reserved.
//

import UIKit
import Lottie

class LottieAnimationVC: UIViewController {
    // 1. Create the AnimationView
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runStartingAnimation()
        perform(#selector(navigateToGame), with: nil, afterDelay: 1.2)
    }
    
    @objc private func navigateToGame() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = SwipingController(collectionViewLayout: layout)
        swipingController.modalPresentationStyle = .fullScreen //.popover
        swipingController.modalTransitionStyle = .crossDissolve
        self.present(swipingController, animated: true, completion: nil)
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
    
    
    
    deinit {
        print("DEINIT: \(self.description)")
    }
}
