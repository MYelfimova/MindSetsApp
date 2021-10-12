//
//  CardView.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 4/29/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var color: Card.Color = Card.Color.orange { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var number: Card.Number = Card.Number.two { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shape: Card.Shape = Card.Shape.pacmanShape { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shade: Card.Shade = Card.Shade.filled { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isSelected: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isHinted: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var cornerRadius: CGFloat {
        return bounds.size.height * 0.12
    }
    
    let shapeColors = [
        Card.Color.orange: UIColor.shapeColorOrange,
        Card.Color.pink : UIColor.shapeColorPink,
        Card.Color.blue : UIColor.shapeColorBlue
    ]
    
    override func draw(_ rect: CGRect) {
        self.contentMode = .redraw
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        UIColor.white.setFill()
        path.fill()
        
        if !self.isFaceUp {
            UIColor.cardBackFillColor.setFill()
            path.fill()
        } else {
            path.addClip()
            let bounds = path.bounds
            
            drawShapes(bounds: bounds, number: self.number, shape: self.shape, color: self.shapeColors[self.color]!, shade: self.shade)
        }
        
        if self.isHinted {
            UIColor.cardHintColor.setStroke()
            path.lineWidth = 5
            path.stroke()
            
        } else if self.isSelected {
            UIColor.cardSelectedColor.setStroke()
            path.lineWidth = 5
            path.stroke()
        }
    }
    
}


extension CardView {
    
    func drawShapes(bounds: CGRect, number: Card.Number, shape: Card.Shape, color: UIColor, shade: Card.Shade) {
        
        // MARK: Drawing the shape basis
        
        var path = UIBezierPath()
        switch shape {
        case .donutShape: path = drawDonutShape(bounds: bounds)
        case .pacmanShape: path = drawPacmanShape(bounds: bounds)
        case .squareShape: path = drawSquareShape(bounds: bounds)
        }
        
        // MARK: Setting the amount and shading
        
        switch number {
        case .one :
            path.apply(CGAffineTransform(translationX: CGFloat(bounds.size.width/12), y: CGFloat(bounds.size.height/2-1.5*bounds.size.height/12)))
            setShading(path: path, shade: shade, color: color)
            path = finishDonutShape(shape: shape, path: path, shade: shade, color: color)
            
        case .two :
            path.apply(CGAffineTransform(translationX: CGFloat(bounds.size.width/12), y: CGFloat(6*bounds.size.height/24)))
            setShading(path: path, shade: shade, color: color)
            path = finishDonutShape(shape: shape, path: path, shade: shade, color: color)
            
            var path2 = path.copy() as! UIBezierPath
            path2.apply(CGAffineTransform(translationX: CGFloat(0), y: CGFloat(7*bounds.size.height/24)))
            setShading(path: path2, shade: shade, color: color)
            path2 = finishDonutShape(shape: shape, path: path2, shade: shade, color: color)
            
        case .three :
            path.apply(CGAffineTransform(translationX: CGFloat(bounds.size.width/12), y: CGFloat(2*bounds.size.height/24)))
            setShading(path: path, shade: shade, color: color)
            path = finishDonutShape(shape: shape, path: path, shade: shade, color: color)
            
            var path2 = path.copy() as! UIBezierPath
            path2.apply(CGAffineTransform(translationX: CGFloat(0), y: CGFloat(7*bounds.size.height/24)))
            setShading(path: path2, shade: shade, color: color)
            path2 = finishDonutShape(shape: shape, path: path2, shade: shade, color: color)
            
            var path3 = path.copy() as! UIBezierPath
            path3.apply(CGAffineTransform(translationX: CGFloat(0), y: CGFloat(14*bounds.size.height/24)))
            setShading(path: path3, shade: shade, color: color)
            path3 = finishDonutShape(shape: shape, path: path3, shade: shade, color: color)
            
        }
    }
    
    func drawSquareShape(bounds: CGRect) -> UIBezierPath {
        let rect = CGRect(x: bounds.origin.x + 1*bounds.size.width/4.5, y: bounds.origin.y, width: bounds.size.height/4.5, height: bounds.size.height/4.5)
        let path = UIBezierPath(rect: rect)
        
        return path
    }
    
    func drawDonutShape(bounds: CGRect) -> UIBezierPath {
        let rect = CGRect(x: bounds.origin.x + 1*bounds.size.width/4.8, y: bounds.origin.y, width: 2*bounds.size.width/4.8, height: 2*bounds.size.width/4.8)
        let path = UIBezierPath(ovalIn: rect)
        
        return path
    }
    
    func drawPacmanShape(bounds: CGRect) -> UIBezierPath {
        let center = CGPoint (x: bounds.origin.x + bounds.size.width/2.5, y: bounds.origin.y + bounds.size.width/4.2)
        let circleRadius = bounds.size.width/4.8
        let path = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat.pi*2, endAngle: CGFloat.pi * 1.5, clockwise: true)
        
        path.addLine(to: center)
        path.close()
        
        return path
    }
    
    func finishDonutShape(shape: Card.Shape, path: UIBezierPath, shade: Card.Shade, color: UIColor)-> UIBezierPath {
        if shape == .donutShape {
            let context = UIGraphicsGetCurrentContext()!
            context.saveGState()
            path.addClip()
            
            let rect2 = CGRect(x: path.bounds.origin.x + 3*path.bounds.size.width/12, y: path.bounds.origin.y + 3*path.bounds.size.height/12, width: 6*path.bounds.size.height/12, height: 6*path.bounds.size.height/12)
            let path2 = UIBezierPath(ovalIn: rect2)
            UIColor.white.setFill()
            path2.fill()
            
            color.setStroke()
            path2.lineWidth = 2.0
            path2.stroke()
            
            context.restoreGState()
            return path
        }
        return path
    }
    
    func setShading(path: UIBezierPath, shade: Card.Shade, color: UIColor) {
        
        switch shade {
        case .outline:
            color.setStroke()
            path.lineWidth = 2.0
            path.stroke()
            
        case .striped:
            let myPath = path.copy() as! UIBezierPath
            let bounds = myPath.bounds
            
            let stripes = UIBezierPath()
            for x in stride(from: 0, to: bounds.size.width, by: bounds.size.width/10){
                stripes.move(to: CGPoint(x: bounds.origin.x + x, y: bounds.origin.y ))
                stripes.addLine(to: CGPoint(x: bounds.origin.x + x, y: bounds.origin.y + bounds.size.height ))
            }
            color.set()
            color.setStroke()
            stripes.lineWidth = 1
            
            myPath.lineWidth = 3.0
            
            let context = UIGraphicsGetCurrentContext()!
            context.saveGState()
            
            myPath.addClip()
            stripes.stroke()
            myPath.stroke()
            
            context.restoreGState()
            
        case .filled:
            color.setFill()
            path.fill()
            
        }
    }
    
    
}
