//
//  ProductsTableViewCell.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/12/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import CoreData

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var userRating: UserRating!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
self.selectedBackgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        
 self.selectionStyle = .default
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectedBackgroundView?.backgroundColor = UIColor.white
        
    }

}

extension ProductsTableViewCell{
    
    internal func configureCell(with product: Product) {
        
        productImageView.image = Utility.image(withName: product.mainimage, andType: "jpg")
        productNameLabel.text = product.name
        manufacturerLabel.text = product.manufacturer?.name
        priceLabel.text = product.salePrice.currencyFormatter
        userRating.rating = Int(product.rating)
        

    }
    
}
