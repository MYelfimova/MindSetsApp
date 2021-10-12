//
//  Card.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 4/29/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//


// MARK: Model File 1 - Class Card describes what a card is

import Foundation

class Card : CustomStringConvertible {
    
    var description: String {
        return "a \(self.color) \(self.shade) \(self.shape) of number: \(self.number)\n"
    }

    let identifier: Int
    var isVisible = false
    var isSelected = false

    var number: Number
    var shape: Shape
    var color: Color
    var shade: Shade
    
    enum Number: String, CustomStringConvertible {
        case one = "1"
        case two = "2"
        case three = "3"
        
        var description: String { return self.rawValue }
        
        static var all: [Number] {
            return [.one, .two, .three]
        }
    }
    
    enum Shape: String, CustomStringConvertible {
        case squiggle = "squiggle"
        case oval = "oval"
        case diamond = "diamond"
        
        var description: String { return self.rawValue }
        
        static var all: [Shape] {
            return [.squiggle, .oval, .diamond]
        }
    }
    
    enum Shade: String, CustomStringConvertible {
        case striped = "striped"
        case filled = "filled"
        case outline = "outlined"
        
        var description: String { return self.rawValue }
        
        static var all: [Shade] {
            return [.striped, .filled, .outline]
        }
    }
    
    enum Color: String, CustomStringConvertible {
        case red = "red"
        case purple = "purple"
        case green = "green"
        
        var description: String { return self.rawValue }
        
        static var all: [Color] {
            return [.red, .purple, .green]
        }
    }
    
    private static var identifierFactory:[Int] = (Array(0...80)).shuffled()

// Identifier is added in order to keep up with "new game" logic and to initialize first pile of visible cards
    private static func getIdentifier() -> Int {
        if identifierFactory.isEmpty {
           identifierFactory = (Array(0...80)).shuffled()
        }
        return identifierFactory.remove(at: 0)
    }
    
    init(number: Number, shape: Shape, shade: Shade, color: Color) {
        self.identifier = Card.getIdentifier()
        self.isVisible = self.identifier <= 11 ? true : false
        self.shape = shape
        self.color = color
        self.shade = shade
        self.number = number
    }

}
