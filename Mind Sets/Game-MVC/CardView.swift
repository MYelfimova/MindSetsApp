//
//  CardView.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 4/29/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class CardView: UIView {
    

    override func draw(_ rect: CGRect) {
        self.contentMode = .redraw
        //print("Drawing a shape")
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        UIColor.white.setFill()
        path.fill()
        //path.lineWidth = 1.5
        
       
        
        
        
        if !self.isFaceUp {
            #colorLiteral(red: 1, green: 0.5102974176, blue: 0.1469883919, alpha: 1).setFill()
            path.fill()
        } else {
            path.addClip()
            
            let bounds = path.bounds

            drawShapes(bounds: bounds, number: self.number, shape: self.shape, color: self.colors["\(self.color)"]!, shade: self.shade)
        }
        
        if self.isHinted {
                   #colorLiteral(red: 0.9945228696, green: 0.2679056525, blue: 0.5997453332, alpha: 1).setStroke()
                   path.lineWidth = 5
                   path.stroke()
                   //path.apply(CGAffineTransform(scaleX: CGFloat(1.15), y: CGFloat(1.15)))
                   //path.apply(CGAffineTransform(translationX: -2, y: -2))

               } else if self.isSelected {
                   #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).setStroke()
                   path.lineWidth = 5
                   path.stroke()
                   //path.apply(CGAffineTransform(scaleX: CGFloat(0.9), y: CGFloat(0.9)))
                   //path.apply(CGAffineTransform(translationX: 2, y: 2))
               }
        
        
    }
    var color: String = "purple" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var number: String = "2" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shape: String = "diamond" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shade: String = "filled" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isSelected: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isHinted: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    
    //var uniqueIdentifier: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }

    var cornerRadius: CGFloat {
        return bounds.size.height * 0.12
    }

    let colors = [
        "purple": UIColor(red: CGFloat(96/255.0), green: CGFloat(105/255.0), blue: CGFloat(255/255.0), alpha: 1.0),
        "red" : UIColor(red: CGFloat(255/255.0), green: CGFloat(130/255.0), blue: CGFloat(39/255.0), alpha: 1.0),
        "green" : UIColor(red: CGFloat(254/255.0), green: CGFloat(68/255.0), blue: CGFloat(153/255.0), alpha: 1.0)
    ]
    
    
    func drawSquiggleOld(bounds: CGRect) -> UIBezierPath {
        // make sure this function returns shape with sizes: path.width = 0.8*bounds.width, and path.height = path.width/2
        //plus make sure I'm creating the shape on position (origin.x, origin.y)
        
        let startPoint = CGPoint(x: 76.5, y: 403.5)
        let curves = [ // to, cp1, cp2
            (CGPoint(x:  199.5, y: 295.5), CGPoint(x: 92.463, y: 380.439),
             CGPoint(x: 130.171, y: 327.357)),
            (CGPoint(x:  815.5, y: 351.5), CGPoint(x: 418.604, y: 194.822),
             CGPoint(x: 631.633, y: 454.052)),
            (CGPoint(x: 1010.5, y: 248.5), CGPoint(x: 844.515, y: 313.007),
             CGPoint(x: 937.865, y: 229.987)),
            (CGPoint(x: 1057.5, y: 276.5), CGPoint(x: 1035.564, y: 254.888),
             CGPoint(x: 1051.46, y: 270.444)),
            (CGPoint(x:  993.5, y: 665.5), CGPoint(x: 1134.423, y: 353.627),
             CGPoint(x: 1105.444, y: 556.041)),
            (CGPoint(x:  860.5, y: 742.5), CGPoint(x: 983.56, y: 675.219),
             CGPoint(x: 941.404, y: 715.067)),
            (CGPoint(x:  271.5, y: 728.5), CGPoint(x: 608.267, y: 828.077),
             CGPoint(x: 452.192, y: 632.571)),
            (CGPoint(x:  101.5, y: 803.5), CGPoint(x: 207.927, y: 762.251),
             CGPoint(x: 156.106, y: 824.214)),
            (CGPoint(x:   49.5, y: 745.5), CGPoint(x: 95.664, y: 801.286),
             CGPoint(x: 73.211, y: 791.836)),
            (startPoint, CGPoint(x: 1.465, y: 651.628),
             CGPoint(x: 1.928, y: 511.233)),
        ]
        
        // Draw the squiggle
        let path = UIBezierPath()
        path.move(to: startPoint)
        for (to, cp1, cp2) in curves {
            path.addCurve(to: to, controlPoint1: cp1, controlPoint2: cp2)
        }

        // Reshape and transform the squiggle
        path.apply(CGAffineTransform(scaleX: CGFloat(9*bounds.size.width/12/1134.423), y: CGFloat(4*bounds.size.height/12/828.077)))
        path.apply(CGAffineTransform(translationX: CGFloat(bounds.origin.x - 1.465 * bounds.size.height/828.077 + 0.5*bounds.size.width/12), y: CGFloat(bounds.origin.y - 194.822 * bounds.size.width/1134.423)))
        
        //print("drawing a squiggle at \(bounds.origin.x), \(bounds.origin.y)")
        
        return path
    }
    func drawOvalOld(bounds: CGRect) -> UIBezierPath {
        // make sure this function returns shape with sizes: path.width = 0.8*bounds.width (or 10/12), and path.height = path.width/2
        //plus make sure I'm creating the shape on position (origin.x, origin.y)
        
        let path = UIBezierPath(roundedRect: CGRect(x: bounds.origin.x + 0.5*bounds.size.width/12, y: bounds.origin.y, width: 9*bounds.size.width/12, height: (8*bounds.size.width/12)/2), cornerRadius: 60)

        
        //print("drawing an oval at \(bounds.origin.x), \(bounds.origin.y)")
        
        return path
    }
    func drawDiamondOld(bounds: CGRect) -> UIBezierPath {
        // make sure this function returns shape with sizes: path.width = 0.8*bounds.width, and path.height = path.width/2
        //plus make sure I'm creating the shape on position (origin.x, origin.y)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.origin.x + 1.5 * bounds.size.width/12, y: bounds.origin.y + bounds.size.height/2))
        path.addLine(to: CGPoint(x: bounds.origin.x + bounds.size.width/2, y: bounds.origin.y + 5*bounds.size.height/12))
        path.addLine(to: CGPoint(x: bounds.origin.x + 10.5*bounds.size.width/12, y: bounds.origin.y + bounds.size.height/2))
        path.addLine(to: CGPoint(x: bounds.origin.x + bounds.size.width/2, y: bounds.origin.y + 7*bounds.size.height/12))
        path.close()

        path.apply(CGAffineTransform(translationX: CGFloat(-bounds.size.width/12), y: CGFloat(-5*bounds.size.height/12)))

        //print("drawing a diamond at \(bounds.origin.x), \(bounds.origin.y)")
        
        return path
    }
    
    func drawDiamond(bounds: CGRect) -> UIBezierPath {
        // make sure this function returns shape with sizes: path.width = 0.8*bounds.width (or 10/12), and path.height = path.width/2
        //plus make sure I'm creating the shape on position (origin.x, origin.y)
        
        let rect = CGRect(x: bounds.origin.x + 1*bounds.size.width/4.5, y: bounds.origin.y, width: bounds.size.height/4.5, height: bounds.size.height/4.5)
        let path = UIBezierPath(rect: rect)
        
        //print("drawing an oval at \(bounds.origin.x), \(bounds.origin.y)")
        
        return path
    }
    func drawOval(bounds: CGRect) -> UIBezierPath {
        // make sure this function returns shape with sizes: path.width = 0.8*bounds.width (or 10/12), and path.height = path.width/2
        //plus make sure I'm creating the shape on position (origin.x, origin.y)
        
        let rect = CGRect(x: bounds.origin.x + 1*bounds.size.width/4.8, y: bounds.origin.y, width: 2*bounds.size.width/4.8, height: 2*bounds.size.width/4.8)
        let path = UIBezierPath(ovalIn: rect)
        
        //print("drawing an oval at \(bounds.origin.x), \(bounds.origin.y)")
        
        return path
    }
    func drawSquiggle(bounds: CGRect) -> UIBezierPath {
        // make sure this function returns shape with sizes: path.width = 0.8*bounds.width (or 10/12), and path.height = path.width/2
        //plus make sure I'm creating the shape on position (origin.x, origin.y)
        
        let center = CGPoint (x: bounds.origin.x + bounds.size.width/2.5, y: bounds.origin.y + bounds.size.width/4.2)
        let circleRadius = bounds.size.width/4.8
        let path = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat.pi*2, endAngle: CGFloat.pi * 1.5, clockwise: true)
        
        path.addLine(to: center)
        path.close()

        //print("drawing an oval at \(bounds.origin.x), \(bounds.origin.y)")
        
        return path
    }
    
    func drawShapes(bounds: CGRect, number: String, shape: String, color: UIColor, shade: String) {
    // stage 1 - draw a shape
        
        var path = UIBezierPath()
        switch shape {
        case "oval": path = drawOval(bounds: bounds)
                //print("\(number) \(shade) oval(s)")
            case "squiggle": path = drawSquiggle(bounds: bounds)
                //print("\(number) \(shade) squiggle(s)")
            case "diamond": path = drawDiamond(bounds: bounds)
                //print("\(number) \(shade) diamond(s)")
        default: path = UIBezierPath()
        }
        
        func finishDonutShape(shape: String, path: UIBezierPath, shade: String, color: UIColor)-> UIBezierPath {
             if shape == "oval" {
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
    
        
    //stage 2 - number and shading
        switch number {
        case "1" :
            path.apply(CGAffineTransform(translationX: CGFloat(bounds.size.width/12), y: CGFloat(bounds.size.height/2-1.5*bounds.size.height/12)))
            setShading(path: path, shade: shade, color: color)
            path = finishDonutShape(shape: shape, path: path, shade: shade, color: color)
            
        case "2" :
            path.apply(CGAffineTransform(translationX: CGFloat(bounds.size.width/12), y: CGFloat(6*bounds.size.height/24)))
            setShading(path: path, shade: shade, color: color)
            path = finishDonutShape(shape: shape, path: path, shade: shade, color: color)
            
            var path2 = path.copy() as! UIBezierPath
            path2.apply(CGAffineTransform(translationX: CGFloat(0), y: CGFloat(7*bounds.size.height/24)))
            setShading(path: path2, shade: shade, color: color)
            path2 = finishDonutShape(shape: shape, path: path2, shade: shade, color: color)
            
        case "3" :
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
            
        default: return;
        }
    }
    func setShading(path: UIBezierPath, shade: String, color: UIColor) {
        
        switch shade {
        case "outlined":
            color.setStroke()
            path.lineWidth = 2.0
            path.stroke()

        case "striped":
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
            
        case "filled":
            color.setFill()
            path.fill()
            
        default: return;
            
        }
    }


}
