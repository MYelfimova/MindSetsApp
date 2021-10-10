//
//  Constants.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 10/10/2021.
//  Copyright © 2021 Maria Yelfimova. All rights reserved.
//

import UIKit

struct Constants {
    static let pages = [
        Page(image: "how-to-1-1000", descriptionTitle: "Deck", descriptionBody: "A deck consists of 81 unique cards"),
        Page(image: "how-to-2-1000", descriptionTitle: "Features", descriptionBody: "Each card has 4 varying features: shape, number of shapes, shading, color"),
        Page(image: "how-to-3-1000", descriptionTitle: "Set Rules", descriptionBody: "3 cards must have their features either completely different or the same for all\nAll different: number of shapes, colors, shadings\nAll same: shapes"),
        Page(image: "how-to-4-1000", descriptionTitle: "This is a valid set", descriptionBody: "All same: shapes, color\nAll different: number of shapes, shadings"),
        Page(image: "how-to-5-1000", descriptionTitle: "This is not a valid set", descriptionBody: "All same: shapes\nAll different: color\nNeither the same or different: number of shapes, shading\n(which is a mistake)"),
        Page(image: "how-to-6-1000", descriptionTitle: "Scoring", descriptionBody: "• each Set you get +5 points\n•each Hint you pay -3 points\n•each Deal you get 3 more cards\n to the Deck and a pay -1 point"),
    ]
    
    static let nextButtonTitle = "NEXT"
    static let prevButtonTitle = "PREV"
    static let playButtonTitle = "PLAY"
    static let rulesTitle = "How To Play"
    
    static let titleFont = UIFont.boldSystemFont(ofSize:24)
    static let descriptionTitleFont = UIFont.boldSystemFont(ofSize: 20)
    static let descriptionFont = UIFont.systemFont(ofSize: 16)
}
