//
//  DetailSummaryView.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/17/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class DetailSummaryView: UIView {
    
    
    @IBOutlet weak var manufacturer: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var listPriceLabel: UILabel!
    
    @IBOutlet weak var dealPriceLabel: UILabel!
    
    @IBOutlet weak var priceSaveDollarLabel: UILabel!
    
    @IBOutlet weak var priceSavedPercentlabel: UILabel!
    
    @IBOutlet weak var isInStock: UILabel!
    
    @IBOutlet weak var qtyLeftLabel: UILabel!
    
    @IBOutlet weak var quantityControl: Stepper!
    
    @IBOutlet weak var addToCartButton: UIButton!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var userRating: UserRating!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateView(with product: Product){
        
    }
    
    
}
