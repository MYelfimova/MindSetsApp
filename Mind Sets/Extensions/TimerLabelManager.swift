//
//  TimerLabelManager.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 24/10/2021.
//  Copyright © 2021 Maria Yelfimova. All rights reserved.
//

import Foundation

extension Timer {
    static func calculateTimerLabel() -> String {
        GameScreenModel.timeDisplayed -= 1
        
        if (GameScreenModel.timeDisplayed < 0) {
            GameScreenModel.timeDisplayed = 0
        }
        
        if (GameScreenModel.timeDisplayed < 3600) {
            if (GameScreenModel.timeDisplayed % 60) <= 9 {
                if (GameScreenModel.timeDisplayed/60) <= 9{
                    return "0\(Int(GameScreenModel.timeDisplayed / 60)):0\(GameScreenModel.timeDisplayed % 60)"
                }
                else {
                    return "\(Int(GameScreenModel.timeDisplayed / 60)):0\(GameScreenModel.timeDisplayed % 60)"
                }
            } else {
                if (GameScreenModel.timeDisplayed/60) <= 9{
                    return "0\(Int(GameScreenModel.timeDisplayed / 60)):\(GameScreenModel.timeDisplayed % 60)"
                }
                else {
                    return "\(Int(GameScreenModel.timeDisplayed / 60)):\(GameScreenModel.timeDisplayed % 60)"
                }
            }
        }
        else {
            if (GameScreenModel.timeDisplayed % 60) <= 9 {
                if (GameScreenModel.timeDisplayed/60) <= 9{
                    return "0\(GameScreenModel.timeDisplayed % 3600):0\(Int(GameScreenModel.timeDisplayed / 60)):0\(GameScreenModel.timeDisplayed % 60)"
                }
                else {
                    return "0\(GameScreenModel.timeDisplayed % 3600):\(Int(GameScreenModel.timeDisplayed / 60)):0\(GameScreenModel.timeDisplayed % 60)"
                }
            } else {
                if (GameScreenModel.timeDisplayed/60) <= 9{
                    return "0\(GameScreenModel.timeDisplayed % 3600):0\(Int(GameScreenModel.timeDisplayed / 60)):\(GameScreenModel.timeDisplayed % 60)"
                }
                else {
                    return "0\(GameScreenModel.timeDisplayed % 3600):\(Int(GameScreenModel.timeDisplayed / 60)):\(GameScreenModel.timeDisplayed % 60)"
                }
            }
        }
        
    }
    
}
