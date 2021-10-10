//
//  gifAnimationController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 6/8/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import Foundation
import UIKit

class  GifAnimationController: VCLLoggingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var gifPicture: UIImageView!
    
    override func viewWillLayoutSubviews() {
        gifPicture.image = UIImage.gifImageWithName("06animation")
    }
    

    override func viewDidLayoutSubviews() {

        perform(#selector(openRules), with: nil, afterDelay: 3)
        
    }

    @objc func openRules() {
        let gameScreen = self.storyboard?.instantiateViewController(withIdentifier: "gameScreenView") as! GameScreenViewController

       gameScreen.modalTransitionStyle = .crossDissolve
       gameScreen.modalPresentationStyle = .fullScreen
       //show(gameView, sender: self)
       self.present(gameScreen, animated: true, completion: nil)

    }
}
