//
//  UIView+Extension.swift
//  Nike Collection
//
//  Created by Shao Kahn on 11/3/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

@IBDesignable
class viewEffect:UIView{
    override func draw(_ rect: CGRect) {
        
        //returns a current CGContext type context
        let cgContext = UIGraphicsGetCurrentContext()
        
        //set line width, let it euqal to line view height
        cgContext?.setLineWidth(3.0)
        
        //set dash line color
cgContext?.setStrokeColor(UIColor(hex:"8EFA00").cgColor)
        
        
        
        //the dash line - red line width is 10 pt, the between two red lines distance is 3 pt
        let dashArr:[CGFloat] = [10,3]
        
        //phase determine dash line start in head of 10 pt
        cgContext?.setLineDash(phase: 0.0, lengths: dashArr)
        
        
        
        //dash line begin point
        cgContext?.move(to: CGPoint(x: self.bounds.origin.x , y: self.bounds.origin.y ))
        
        //dash line end point
        cgContext?.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.origin.y ))
        
        //put dash line to line view
        cgContext?.strokePath()
        
    }
}

extension UIView{

}







