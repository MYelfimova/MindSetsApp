//
//  CardsGameView.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 4/29/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit


//This protocol allows CardsGameView view to send data to GameScreenViewController. After this declaration I will call updateLabels() method when CardsGameView view needs it!
protocol updateLabelsDelegate: class {
    //func updateLabels(sets: Int, score: Int)
    func updateScorelabel(score: Int)
    func updateSetsLabel(sets: Int)
    func updateButtonStatus()
    func startTimer()
    func pauseTimer()
    func resetTimer()
}

class CardsGameView: UIView, UpdateGameStatus {
    func gameResumed() {
        delegate?.startTimer()
        print("GAME RESUMED")
    }
    
    
    //Declaring the protocol delegate which I initialize in the didLoad() method of the GameScreenViewController.
    weak var delegate: updateLabelsDelegate? = nil
    
    // these are the scorring labels:
    var setsLabel = 0 { didSet {delegate?.updateSetsLabel(sets: setsLabel) ; delegate?.updateButtonStatus()}}
    var scoreLabel = 0 { didSet {delegate?.updateScorelabel(score: scoreLabel) ; delegate?.updateButtonStatus()}}
    
    var dealCardsButtonIsActive: Bool {
        return ( (game.cards.count >= numberOfVisibleCards)
            && (game.cards.count > 12)  // if on the screen is less then 12 cards, it means the the deck finishes
            && (numberOfVisibleCards < 30) ) // 30 is the max cards that card be dealt
    }
    var hintButtonIsActive: Bool {
        return ((game.getHintIndices() != [-10,-10,-10]) && !hintButtonWasUsed)
    }
    // this is the variable for tracking clicks on the Hint button
    var hintButtonWasUsed: Bool = false

    var grid = Grid(layout: Grid.Layout.aspectRatio(CGFloat(0.60)))
    //this is the array for storring all my Visible cards
    var viewArray = [CardView]() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var hintIndices = [-1,-1,-1] { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var game = CardsGame()
    var isNewGame: Bool = true {didSet { setNeedsDisplay(); setNeedsLayout() } }

    
    //The animation delay that will be += through the interation to stutter the animation for each card so it delineates each card being dealt visually.
    private var delay = 0.0
    
    var numberOfVisibleCards: Int {
        get {
            //return deck.grid.cellCount
            return (game.cards.indices.filter({game.cards[$0].isVisible})).count
        }
    }
    var visibleCards: [Card] {
        get {
            //return deck.grid.cellCount
            return game.cards.filter({$0.isVisible})
        }
    }
    var add3MoreBtnIsActive: Bool {
        return (numberOfVisibleCards < 30 && game.cards.count != numberOfVisibleCards)
    }
        
    var selectedCardsNumber: Int {
        get {
            return (game.cards.indices.filter({game.cards[$0].isSelected})).count
        }
    }
    
    

            
    //Create an array of individual cardViews
    private func createCardView(cardNumber: Int) {
        
        let cardView = CardView()
        cardView.number = game.cards[cardNumber].number //.rawValue
        cardView.shape = game.cards[cardNumber].shape //.rawValue
        cardView.color = game.cards[cardNumber].color //.rawValue)"
        cardView.shade = game.cards[cardNumber].shade //.rawValue
        
        cardView.backgroundColor = UIColor.clear
        cardView.contentMode = .redraw

        // MARK : WTF
        cardView.tag = cardNumber
        
        //declaring a tap gesture to each of our cards views.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        //Adding the gesture to each card.
        cardView.addGestureRecognizer(tap)
        
        //Adding the card view as a subview of playingCardView
        addSubview(cardView)
        
        //Adding each card view to an array. This will represent what cards are currently on the table.
        viewArray.append(cardView)
        
        delay = 0
        for i in 0..<numberOfVisibleCards {
            drawAnimation(view: viewArray[i], rect: grid[i])
        }
                
    }
    
    func newGame(from: String){
        if from == "popup" {
            hintButtonWasUsed = false
            isNewGame = true
            delegate?.resetTimer()
        }
    }
    
    
     func newGame() {
         game = CardsGame()
         
         viewArray.forEach {$0.removeFromSuperview()}
         viewArray = []
         hintIndices = [-1,-1,-1]
         scoreLabel = 0
         setsLabel = 0
        
        //for enabling Hint button if it was disabled from the last game
        hintButtonWasUsed = false

         grid.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height)
         grid.cellCount = numberOfVisibleCards
        
         createCardViews(grid: grid)
         delegate?.updateButtonStatus()
         delegate?.startTimer()
         isNewGame = false
     }
    
    override func draw(_ rect: CGRect) {
        grid.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height)
        grid.cellCount = numberOfVisibleCards

        if isNewGame {
            newGame()
        }
        else {
            updateCardViews()
        }
    }
    
    
    //This funcrion is for new game
    func createCardViews(grid: Grid) {
        viewArray.forEach {$0.removeFromSuperview()}
        
            for i in 0..<numberOfVisibleCards {

            //let cardView = CardView(grid[i]!)
            let cardView = CardView()
            cardView.number = game.cards[i].number//.rawValue
            cardView.shape = game.cards[i].shape//.rawValue
            cardView.color = game.cards[i].color//.rawValue)"
            cardView.shade = game.cards[i].shade//.rawValue
            cardView.isSelected = game.cards[i].isSelected
            cardView.isFaceUp = false
                
            cardView.backgroundColor = UIColor.clear
            cardView.contentMode = .redraw
                
            // MARK : WTF
            cardView.tag = i
            
            //declaring a tap gesture to each of our cards views.
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            
            //Adding the gesture to each card.
            cardView.addGestureRecognizer(tap)
            
            //Adding the card view as a subview of playingCardView
            addSubview(cardView)
            
            //Adding each card view to an array. This will represent what cards are currently on the table.
            viewArray.append(cardView)
                
            }
            
            delay = 0
            for i in 0..<numberOfVisibleCards {
                drawAnimation(view: viewArray[i], rect: grid[i])
            }
            dealIfNeeded()
    }
    
    func updateCardViews() {
        grid.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height)
        grid.cellCount = numberOfVisibleCards
        
        for i in 0..<viewArray.count {
            viewArray[i].number = game.cards[i].number//.rawValue
            viewArray[i].shape = game.cards[i].shape//.rawValue
            viewArray[i].color = game.cards[i].color//.rawValue)"
            viewArray[i].shade = game.cards[i].shade//.rawValue
            viewArray[i].isSelected = game.cards[i].isSelected
             
            if viewArray[i].isHinted == true {
                viewArray[i].isHinted = false
            } else if hintIndices.contains(i) {
                viewArray[i].isHinted = true
                hintIndices.remove(at: hintIndices.firstIndex(of: i)!)
            }
            
            viewArray[i].tag = i
            
            viewArray[i].backgroundColor = UIColor.clear
            viewArray[i].contentMode = .redraw
                
            // MARK : WTF
            viewArray[i].tag = i
            configureCard(viewArray[i], gridNum: i)
        }
        let lastViewIndex = viewArray.count
        
        for i in lastViewIndex ..< numberOfVisibleCards {

        let cardView = CardView(frame: grid[i]!)
        cardView.number = game.cards[i].number //.rawValue
        cardView.shape = game.cards[i].shape //.rawValue
        cardView.color = game.cards[i].color //.rawValue)"
        cardView.shade = game.cards[i].shade //.rawValue
        cardView.isSelected = game.cards[i].isSelected
        cardView.isFaceUp = false
            
        cardView.backgroundColor = UIColor.clear
        cardView.contentMode = .redraw
            
        // MARK : WTF
        cardView.tag = i
        
        //declaring a tap gesture to each of our cards views.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        //Adding the gesture to each card.
        cardView.addGestureRecognizer(tap)
        
        //Adding the card view as a subview of playingCardView
        addSubview(cardView)
        
        //Adding each card view to an array. This will represent what cards are currently on the table.
        viewArray.append(cardView)
        configureCard(viewArray[i], gridNum: i)
        }
        delegate?.updateButtonStatus()
        
        //sometimes it happens that on the table there are no sets, and the program knows it - so let's make life easier for the player
        dealIfNeeded()
    }
    
    func dealIfNeeded() {
        if (dealCardsButtonIsActive && game.getHintIndices() == [-10,-10,-10]){
            perform(#selector(dealCards), with: 0, afterDelay: 1.5)
 
        }
    }
     

    @objc func handleTap(_ pickedCard: UIGestureRecognizer) {
        if let cardSelectedView = pickedCard.view as? CardView {
            
            //Pull the corresponding data from the associated clicked view
            let cardData = visibleCards[cardSelectedView.tag]
            //the data to be passed along with be defaulted to true but then will have to run through a check
            cardData.isSelected = cardData.isSelected == true ? false : true
            
            //for enabling Hint button again
            hintButtonWasUsed = false
            
            switch selectedCardsNumber {
            case 4:
                for card in game.cards {
                    card.isSelected = false
                }
                cardData.isSelected = true
                
                case 3:
                if (game.checkMatching()) {
                    //updating my score variables after a set was found
                    setsLabel+=1; scoreLabel+=5

                    let selectedCardsIndices = (game.cards.indices.filter({game.cards[$0].isSelected})).sorted(by: {$0 > $1})
                    if ((numberOfVisibleCards > 2) && (numberOfVisibleCards < 13)) {
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.3,
                                delay: 0,
                                options: [],
                                animations: {
                                    
                                    selectedCardsIndices.forEach { index in
                                        self.viewArray[index].transform = .identity
                                        self.viewArray[index].transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
                                    }
                                },
                                completion: { position in
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.45,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                             selectedCardsIndices.forEach { index in
                                                self.viewArray[index].transform = CGAffineTransform.identity.scaledBy(x: 0.2, y: 0.2)
                                                self.viewArray[index].alpha = 0
                                            }
                                        },
                                        completion: { position in
                                             selectedCardsIndices.forEach { index in
                                                self.viewArray[index].removeFromSuperview()
                                                self.viewArray.remove(at: index)
                                                self.game.cards.remove(at: index)
                                                
                                                if self.game.cards.count > self.numberOfVisibleCards {
                                                    self.game.cards[self.numberOfVisibleCards].isVisible = true
                                                }

                                            }
                                            
                                        }
                                    )
                                }
                            )
                            
                    } else {
                        UIViewPropertyAnimator.runningPropertyAnimator(
                            withDuration: 0.3,
                            delay: 0,
                            options: [],
                            animations: {
                                
                                selectedCardsIndices.forEach { index in
                                    self.viewArray[index].transform = .identity
                                    self.viewArray[index].transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
                                }
                            },
                            completion: { position in
                                UIViewPropertyAnimator.runningPropertyAnimator(
                                    withDuration: 0.45,
                                    delay: 0,
                                    options: [],
                                    animations: {
                                         selectedCardsIndices.forEach { index in
                                            self.viewArray[index].transform = CGAffineTransform.identity.scaledBy(x: 0.2, y: 0.2)
                                            self.viewArray[index].alpha = 0
                                        }
                                    },
                                    completion: { position in
                                         selectedCardsIndices.forEach { index in
                                            self.viewArray[index].removeFromSuperview()
                                            self.viewArray.remove(at: index)
                                            self.game.cards.remove(at: index)
                                            if self.game.cards.count > self.numberOfVisibleCards {
                                                self.game.cards[self.numberOfVisibleCards].isVisible = false
                                            }
                                        }
                                        
                                    }
                                )
                            }
                        )
                    }
                    for card in game.cards {
                        card.isSelected = false
                    }
                }
                
            default: print("1 or 2 cards selected only")
            }
        }
        setNeedsLayout()
        setNeedsDisplay()
        
    }
    
    @objc func dealCards(penalty: Int = 1) {
        let Ind = numberOfVisibleCards
        game.cards[Ind].isVisible = true
        game.cards[Ind+1].isVisible = true
        game.cards[Ind+2].isVisible = true
        
        //updating my score variables after dealing 3 more cards
        if penalty != 0 {
            scoreLabel -= 1
        }
        
        //for enabling Hint button again
        hintButtonWasUsed = false
        
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    func getHint(){
        self.hintIndices = game.getHintIndices()
        scoreLabel-=3
        for card in game.cards {
            card.isSelected = false
        }
        hintButtonWasUsed = true
        setNeedsLayout()
        setNeedsDisplay()
        
    }
    
    func drawAnimation(view: CardView, rect: CGRect?) {
        //var card = 0
        //This sets the initial card origin at the bottom left of the board and animates them being dealt into their grid positions.
        view.center = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        
        //Here is where the cards are animated to in the grid
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.25,
            delay: delay,
            animations: {
                view.isHidden = false
                view.frame.size = rect?
                    .insetBy(dx: 6, dy: 6).size ?? self.bounds.size
            view.center = CGPoint(x: rect?
                .midX ?? self.bounds.midX, y: rect?
                    .midY ?? self.bounds.midY) }
            , completion: { finished in
                UIView.transition(
                    with: view,
                    duration: 0.5,
                    options: [.transitionFlipFromLeft],
                    // TODO: FaceUp/FaceDown wil be used here: which needs to be painted as well
                    animations: { view.isFaceUp = true }
                )
        })
        //The animation delay that will be += through the interation to stutter the animation for each card so it delineates each card being dealt visually.
        delay += 0.25
    }

// MARK: Important ! This function makes a smooth transition when a Deal card is pressed or some cards are matched
    //Configure the Setviewcard and override its layout and position
    func configureCard(_ label: CardView, gridNum: Int) {
 
        //Currently this is used to establish a basic layout for the cards in the grid and have them redraw when views are laidout. This actiona is also animated. The initial twelve cards being dealt are in the newGame function and impliment annimation that starts from bottom left of the view and animates as they move into place in the grid.
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.25,
            delay: 0,
            animations: {
                label.frame.size = self.grid[gridNum]?
                    .insetBy(dx: 6, dy: 6).size ?? self.bounds.size;
                label.center = CGPoint(x: self.grid[gridNum]?.midX ?? self.bounds.midX, y: self.grid[gridNum]?.midY ?? self.bounds.midY)
                
        }, completion: { finished in
            if label.isFaceUp == false {
                UIView.transition(
                    with: label,
                    duration: 0.5,
                    options: [.transitionFlipFromLeft],
                    // TODO: FaceUp/FaceDown wil be used here: which needs to be painted as well
                    animations: { label.isFaceUp = true}
                )
            }
                
        })
       
    }
    

}

