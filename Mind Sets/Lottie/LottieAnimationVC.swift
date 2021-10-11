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
      
      // 2. Start AnimationView with animation name (without extension)
      
      animationView = .init(name: "mashynia-app-1")
      
      animationView!.frame = view.bounds
      
      // 3. Set animation content mode
      
      animationView!.contentMode = .scaleAspectFit
      
      // 4. Set animation loop mode
      
      animationView!.loopMode = .playOnce
      
      // 5. Adjust animation speed
      
      animationView!.animationSpeed = 0.5
      
      view.addSubview(animationView!)
      
      // 6. Play animation
      
      animationView!.play()
      
    }
}
