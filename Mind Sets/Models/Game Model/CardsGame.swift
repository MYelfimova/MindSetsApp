//
//  CardsGame.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 4/29/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

// MARK: Model File 2 - Struct CardsGame holds the logic of the game

import Foundation

struct CardsGame {
    
    var cards = [Card]()
    
    init() {
        for number in Card.Number.all {
            for shape in Card.Shape.all {
                for shade in Card.Shade.all {
                    for color in Card.Color.all {
                        cards.append(Card (number: number, shape: shape, shade: shade, color: color))
                    }
                }
            }
        }
        self.cards = self.cards.sorted(by: {$0.identifier < $1.identifier})
    }
    
    func checkMatching() -> Bool {
        //let selectedCardsIndices = self.cards.indices.filter({self.cards[$0].isSelected})
        let selectedCards = self.cards.filter({$0.isSelected})
        
        let card0 = getRawValues(card: selectedCards[0])
        let card1 = getRawValues(card: selectedCards[1])
        let card2 = getRawValues(card: selectedCards[2])
        
        if (
            ((card0[0] == card1[0] && card1[0] == card2[0]) || (card0[0] != card1[0] && card1[0] != card2[0] && card0[0] != card2[0]))
            &&
            ((card0[1] == card1[1] && card1[1] == card2[1]) || (card0[1] != card1[1] && card1[1] != card2[1] && card0[1] != card2[1]))
            &&
            ((card0[2] == card1[2] && card1[2] == card2[2]) || (card0[2] != card1[2] && card1[2] != card2[2] && card0[2] != card2[2]))
            &&
            ((card0[3] == card1[3] && card1[3] == card2[3]) || (card0[3] != card1[3] && card1[3] != card2[3] && card0[3] != card2[3]))
            ) {
            return true;
        }
        return false;
    }
    
    func getHintIndices() -> [Int] {
        
        let maxVisibleIndex = self.cards.indices.filter({self.cards[$0].isVisible}).count
        var indicesForCheck = [[Int]]()

        for i in 0..<maxVisibleIndex {
            for j in i+1..<maxVisibleIndex {
                for h in j+1..<maxVisibleIndex{
                    indicesForCheck.append([i, j, h])
                }
            }
        }
        
        for index in indicesForCheck {
            let card0 = getRawValues(card: self.cards[index[0]])
            let card1 = getRawValues(card: self.cards[index[1]])
            let card2 = getRawValues(card: self.cards[index[2]])

            if (
                ((card0[0] == card1[0] && card1[0] == card2[0]) || (card0[0] != card1[0] && card1[0] != card2[0] && card0[0] != card2[0]))
                &&
                ((card0[1] == card1[1] && card1[1] == card2[1]) || (card0[1] != card1[1] && card1[1] != card2[1] && card0[1] != card2[1]))
                &&
                ((card0[2] == card1[2] && card1[2] == card2[2]) || (card0[2] != card1[2] && card1[2] != card2[2] && card0[2] != card2[2]))
                &&
                ((card0[3] == card1[3] && card1[3] == card2[3]) || (card0[3] != card1[3] && card1[3] != card2[3] && card0[3] != card2[3]))
                ) {
                //print("HINTS: the result of finding sets \(index) ")
                return index
                
            }

        }
        //print("HINTS: the result of finding sets [-10,-10,-10] ")
        return [-10,-10,-10]
  
    }
    
    //A function to extract the raw values of our cards
    func getRawValues(card: Card) -> [String] {
        var cardValues = [String]()
        cardValues += [card.number.rawValue, card.shape.rawValue, card.color.rawValue, card.shade.rawValue]
        return cardValues
    }
}

