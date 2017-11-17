//
//  Bubble.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/16/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

@IBDesignable
 class Bubble: UIView {
    
    override func awakeFromNib() {
        addAnimationForView(self)
    }
    
    fileprivate func random(min: Double, max: Double) -> Double {
        return Double(arc4random()) / 0xFFFFFFFF * (max - min) + min
    }
    

    fileprivate func addAnimationForView(_ view: UIView) {
        
        //create an animation to follow a circular path
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        
        //interpolate the movement to be more smooth
        pathAnimation.calculationMode = kCAAnimationPaced
        
        //apply transformation at the end of animation (not really needed since it runs forever)
        pathAnimation.fillMode = kCAFillModeForwards
        
        pathAnimation.isRemovedOnCompletion = false
        
        //run forever
        pathAnimation.repeatCount = Float.infinity
        
        //no ease in/out to have the same speed along the path
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.duration = random(min: 5, max: 8)
        
        
        //The circle to follow will be inside the circleContainer frame.
        //it should be a frame around the center of your view to animate.
        //do not make it to large, a width/height of 3-4 will be enough.
        let curvedPath = CGMutablePath()
        let circleContainer = view.frame.insetBy(dx: 23/50 * view.frame.size.width, dy: 23/50 * view.frame.size.height)
        
        //    CGPathAddEllipseInRect(curvedPath, nil, circleContainer)
        curvedPath.addEllipse(in: circleContainer)
        
        //add the path to the animation
        pathAnimation.path = curvedPath
        
        //release path
        //    CGPathRelease(curvedPath)
        //add animation to the view's layer
        view.layer.add(pathAnimation, forKey: "myCircleAnimation")
        
        //create an animation to scale the width of the view
        let scaleX = CAKeyframeAnimation(keyPath: "transform.scale.x")
        
        //set the duration
        scaleX.duration = 2
        
        //it starts from scale factor 1, scales to 1.05 and back to 1
        scaleX.values = [1, 1.05, 1]
        
        //time percentage when the values above will be reached.
        //i.e. 1.05 will be reached just as half the duration has passed.
        let scaleXTime = random(min: 1, max: 3)
        
        //    scaleX.keyTimes = [0.0, scaleXTime/2, scaleXTime]
        scaleX.keyTimes = [0.0, NSNumber(value: scaleXTime / 2), NSNumber(value: scaleXTime)]
        scaleX.repeatCount = Float.infinity
        
        //play animation backwards on repeat (not really needed since it scales back to 1)
        scaleX.autoreverses = true
        
        //ease in/out animation for more natural look
        scaleX.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        
        //add the animation to the view's layer
        view.layer.add(scaleX, forKey: "scaleXAnimation")
        
        //create the height-scale animation just like the width one above
        //but slightly increased duration so they will not animate synchronously
        let scaleY = CAKeyframeAnimation(keyPath: "transform.scale.y")
        
        scaleY.duration = 2.5
        scaleY.values = [1.0, 1.05, 1.0]
        
        let scaleYTime = random(min: 1, max: 3)
        
        scaleY.keyTimes = [0.0, NSNumber(value: scaleYTime / 2), NSNumber(value: scaleYTime)]
        scaleY.repeatCount = Float.infinity
        scaleY.autoreverses = true
        scaleX.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        view.layer.add(scaleY, forKey: "scaleYAnimation")
    
    }
    
  
    override func draw(_ rect: CGRect) {
        
        clipsToBounds = true
        layer.cornerRadius = frame.size.width / 2
        
        // General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        // Color Declarations
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let whiteTransparent = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.000)
        let black = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let grey = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.727)
        let backgroundColor = self.backgroundColor ?? UIColor.clear
        
// Gradient Declarations
let gradientAbove = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [white.cgColor, white.blendedColorWithFraction(0.5, ofColor: whiteTransparent).cgColor, whiteTransparent.cgColor, whiteTransparent.cgColor] as CFArray, locations: [0, 0.21, 0.64, 1])!
        
let outerGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [whiteTransparent.cgColor, whiteTransparent.blendedColorWithFraction(0.5, ofColor: black).cgColor, black.cgColor] as CFArray, locations: [0, 1, 1])!
        
let gradienBelow = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [whiteTransparent.cgColor, whiteTransparent.blendedColorWithFraction(0.5, ofColor: whiteTransparent).cgColor, whiteTransparent.cgColor, whiteTransparent.blendedColorWithFraction(0.5, ofColor: grey).cgColor,grey.cgColor] as CFArray, locations: [0, 0.28, 0.28, 1, 1])!
        
// BackgroundCircle Drawing
let backgroundCirclePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))

backgroundColor.setFill()
        backgroundCirclePath.fill()
        
        
    // OuterCircle Drawing
let outerCirclePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
    context?.saveGState()
outerCirclePath.addClip()
        
context?.drawRadialGradient(outerGradient, startCenter: CGPoint(x: 30/60 * frame.size.width, y: 33.66/60 * frame.size.height), startRadius: 26.14/60*frame.size.height, endCenter: CGPoint(x: 30/60 * frame.size.width, y: 30/60*frame.size.height), endRadius: 30/60*frame.size.height, options: [CGGradientDrawingOptions.drawsBeforeStartLocation, CGGradientDrawingOptions.drawsAfterEndLocation])
        
        context?.restoreGState()
        
// OvalAbove Drawing
let ovalAbovePath = UIBezierPath(ovalIn: CGRect(x: 12/60 * frame.size.width, y: 1/60 * frame.size.height, width: 36/60 * frame.size.width, height: 28/60 * frame.size.height))
    
    context?.saveGState()
    ovalAbovePath.addClip()
    
context?.drawLinearGradient(gradientAbove, start: CGPoint(x: 30/60*frame.size.width, y: 1/60*frame.size.height), end: CGPoint(x: 30/60*frame.size.width, y: 29/60*frame.size.height), options: CGGradientDrawingOptions())
        
        context?.restoreGState()
        
        
        // OvalBelow Drawing
let ovalBelowPath = UIBezierPath(ovalIn: CGRect(x: 7/60 * frame.size.width, y: 25.5/60 * frame.size.height, width: 46/60 * frame.size.width, height: 34/60 * frame.size.height))
        
        context?.saveGState()
        ovalBelowPath.addClip()
        
context?.drawLinearGradient(gradienBelow, start: CGPoint(x: 30/60*frame.size.width, y: 25.5/60*frame.size.height), end: CGPoint(x: 30/60*frame.size.width, y: 59.5/60*frame.size.height), options: CGGradientDrawingOptions())
        
        context?.restoreGState()
        
    }
}


extension UIColor {
    
    fileprivate func interpolate(_ a: CGFloat, b: CGFloat, fraction: CGFloat) -> CGFloat {
        return (a + ((b - a) * fraction))
    }
    

     func blendedColorWithFraction(_ fraction: CGFloat, ofColor endColor: UIColor) -> UIColor {
        
        if fraction <= 0.0 { return self }
        
        if fraction >= 1.0 { return endColor }
        
    var a1:CGFloat = 0
        var b1:CGFloat = 0
    var c1:CGFloat = 0
        var d1:CGFloat = 0
        
        var a2:CGFloat = 0
    var b2:CGFloat = 0
        var c2:CGFloat = 0
        var d2:CGFloat = 0
        
    if UIColor.instancesRespond(to: #selector(UIColor.getWhite(_:alpha:))) {
        
            //white
            if getWhite(&a1, alpha: &b1) && endColor.getWhite(&a2, alpha: &b2) {
    return UIColor(white: interpolate(a1, b: a2, fraction: fraction), alpha: interpolate(b1, b: b2, fraction: fraction))
            }
            
            //RGB
    if getRed(&a1, green: &b1, blue: &c1, alpha: &d1) && endColor.getRed(&a2, green: &b2, blue: &c2, alpha: &d2) {
        
return UIColor(red: interpolate(a1, b: a2, fraction: fraction), green: interpolate(b1, b: b2, fraction: fraction), blue: interpolate(c1, b: c2, fraction: fraction), alpha: interpolate(d1, b: d2, fraction: fraction))
        
    }
            
    //HSB
if getHue(&a1, saturation: &b1, brightness: &c1, alpha: &d1) && endColor.getHue(&a2, saturation: &b2, brightness: &c2, alpha: &d2) {
    
return UIColor(hue: interpolate(a1, b: a2, fraction: fraction), saturation: interpolate(b1, b: b2, fraction: fraction), brightness: interpolate(c1, b: c2, fraction: fraction), alpha: interpolate(d1, b: d2, fraction: fraction))
            }
        }
        
        //error
        return UIColor.red
    }
    
    
}


