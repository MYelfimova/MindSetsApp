//
//  CardBehavior.swift
//  DeckOfCards_5-6
//
//  Created by Maria Yelfimova on 4/17/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
    
    lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        //animator.addBehavior(behavior)
        return behavior
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
       let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        //behavior.elasticity = 1.0
        behavior.resistance = 0
        //animator.addBehavior(behavior)
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem) {
        
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            //let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            push.angle = (CGFloat.pi/2) //+ (CGFloat.pi).arc4RandomCGFloat
//            switch (item.center.x, item.center.y) {
//            case let (x, y) where x < center.x && y > center.y:
//                push.angle = -1 * push.angle
//            case let (x, y) where x > center.x:
//                push.angle = y < center.y ? CGFloat.pi-push.angle: CGFloat.pi+push.angle
//            default:
//                push.angle = (CGFloat.pi*2).arc4RandomCGFloat
//            }
        }
        
        push.magnitude = CGFloat(1.0) + CGFloat(2.0).arc4RandomCGFloat
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
        //animator.addBehavior(push)
    }
    
    func addItem (_ item: UIDynamicItem) {
        //collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
        
    }
    
    func removeItem (_ item: UIDynamicItem) {
        //collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}


extension CGFloat {
    var arc4RandomCGFloat: CGFloat {
        switch self {
        case 1...CGFloat.greatestFiniteMagnitude:
            return CGFloat(Int(arc4random_uniform(UInt32(self))))
        case -CGFloat.greatestFiniteMagnitude..<0:
            return CGFloat(Int(arc4random_uniform(UInt32(self))))
        default:
            return 0
        }
        
    }
}
