//
//  UserRating.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class UserRating:UIView{
    
    var rating = 0{
        didSet{
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for _ in 0..<5 {
        let tempButton = UIButton()
        
        tempButton.setImage(#imageLiteral(resourceName: "blackstar"), for: .normal)
        tempButton.setImage(#imageLiteral(resourceName: "yellowstar"), for: .selected)
        
        tempButton.adjustsImageWhenHighlighted = false
        
        ratingButtons.append(contentsOf: [tempButton])
        addSubview(tempButton)
        }
        
    }
    
    
    override func layoutSubviews() {
        
        // Set the button's width and height
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        var x = 0
        
        for button in ratingButtons {
            // O O O O O
            buttonFrame.origin.x = CGFloat(x * (buttonSize + 5))
            button.frame = buttonFrame
            x += 1
        }
        
        updateButtonSelectionStates()
    }
    

}//UserRating class over line

extension UserRating{
    
    private func updateButtonSelectionStates() {
        var x = 0
        
        for button in ratingButtons {
            button.isSelected = x < rating
            // rating == 2
            x += 1
        }
    }
    
}



