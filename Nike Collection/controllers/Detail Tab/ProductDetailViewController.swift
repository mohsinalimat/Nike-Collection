//
//  ProductDetailViewController.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/17/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var detailSummaryView: DetailSummaryView!
    
    var product:Product?{
        didSet{
            if let currentProduct = product{
                
             self.showDetail(forThe: currentProduct)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}// ProductDetailViewController class over line

// custom functions
extension ProductDetailViewController{
    
    private func showDetail(forThe currentProduct:Product){
        detailSummaryView.updateView(with: currentProduct)
    }
    
}
