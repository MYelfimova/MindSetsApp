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
    
    mutating func checkMatching() -> Bool {
        let selectedCardsIndices = self.cards.indices.filter({self.cards[$0].isSelected})
        let selectedCards = self.cards.filter({$0.isSelected})
        
        let card0 = getRawValues(card: selectedCards[0])
        let card1 = getRawValues(card: selectedCards[1])
        let card2 = getRawValues(card: selectedCards[2])
        print("card0: \(print(card0))")
        print("card1: \(print(card1))")
        print("card2: \(print(card2))")
        
        if (
            ((card0[0] == card1[0] && card1[0] == card2[0]) || (card0[0] != card1[0] && card1[0] != card2[0] && card0[0] != card2[0]))
            &&
            ((card0[1] == card1[1] && card1[1] == card2[1]) || (card0[1] != card1[1] && card1[1] != card2[1] && card0[1] != card2[1]))
            &&
            ((card0[2] == card1[2] && card1[2] == card2[2]) || (card0[2] != card1[2] && card1[2] != card2[2] && card0[2] != card2[2]))
            &&
            ((card0[3] == card1[3] && card1[3] == card2[3]) || (card0[3] != card1[3] && card1[3] != card2[3] && card0[3] != card2[3]))
            ) {
            
            // MARK: For now i'm changing it here, but later, I will want to change it in the controller for animation!
            if ((self.cards.indices.filter({self.cards[$0].isVisible})).count < 13)
                && (self.cards.count != (self.cards.indices.filter({self.cards[$0].isVisible})).count){
                self.cards.swapAt(selectedCardsIndices[2], self.cards.count-1)
                self.cards.swapAt(selectedCardsIndices[1], self.cards.count-2)
                self.cards.swapAt(selectedCardsIndices[0], self.cards.count-3)
                self.cards.remove(at: cards.count-1)
                self.cards.remove(at: cards.count-1)
                self.cards.remove(at: cards.count-1)
                
                for index in selectedCardsIndices {
                    self.cards[index].isSelected = false
                    self.cards[index].isVisible = true
                }
            } else {
                self.cards.remove(at: selectedCardsIndices[2])
                self.cards.remove(at: selectedCardsIndices[1])
                self.cards.remove(at: selectedCardsIndices[0])
            }
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
            
            print("starting to check these 3 cards:")
            print("card0: \(print(card0))")
            print("card1: \(print(card1))")
            print("card2: \(print(card2))")
            
            if (
                ((card0[0] == card1[0] && card1[0] == card2[0]) || (card0[0] != card1[0] && card1[0] != card2[0] && card0[0] != card2[0]))
                &&
                ((card0[1] == card1[1] && card1[1] == card2[1]) || (card0[1] != card1[1] && card1[1] != card2[1] && card0[1] != card2[1]))
                &&
                ((card0[2] == card1[2] && card1[2] == card2[2]) || (card0[2] != card1[2] && card1[2] != card2[2] && card0[2] != card2[2]))
                &&
                ((card0[3] == card1[3] && card1[3] == card2[3]) || (card0[3] != card1[3] && card1[3] != card2[3] && card0[3] != card2[3]))
                ) {
                print("it's a set!")
                return index
            }
            print("it's NOT a set!\n")
        }
        return [-1,-1,-1]
    }
    
    //A function to extract the raw values of our cards
    func getRawValues(card: Card) -> [String] {
        var cardValues = [String]()
        cardValues += [card.number.rawValue, card.shape.rawValue, card.color.rawValue, card.shade.rawValue]
        return cardValues
    }
}

