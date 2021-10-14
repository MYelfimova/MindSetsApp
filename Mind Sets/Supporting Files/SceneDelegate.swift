//
//  SceneDelegate.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 4/29/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = scene as? UIWindowScene else {return}
        window = UIWindow(windowScene: scene)
        window?.rootViewController = AppStarterAnimationController()
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("DEBUG: sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("DEBUG: sceneDidBecomeActive")
        readFromSettings()// - continue
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("DEBUG: sceneWillResignActive")
        writeToSettings()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("DEBUG: sceneWillEnterForeground")
        
        // todo: to write all the variables to settings
        
        readFromSettings()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("DEBUG: sceneDidEnterBackground")
        
        // todo: to read all the variables from settings
        writeToSettings()
    }
    
    private func readFromSettings() {
        GameScreenModel.setsCounted = defaults.integer(forKey: "SetsCounted")
        GameScreenModel.pointsCounted = defaults.integer(forKey: "PointsCounted")
        GameScreenModel.timeDisplayed = defaults.integer(forKey: "TimeDisplayed")
        GameScreenModel.userBestScore = defaults.integer(forKey: "UserBestScore")
    }
    
    private func writeToSettings() {
        defaults.set(GameScreenModel.setsCounted, forKey: "SetsCounted")
        defaults.set(GameScreenModel.pointsCounted, forKey: "PointsCounted")
        defaults.set(GameScreenModel.timeDisplayed, forKey: "TimeDisplayed")
        defaults.set(GameScreenModel.userBestScore, forKey: "UserBestScore")
    }


}

