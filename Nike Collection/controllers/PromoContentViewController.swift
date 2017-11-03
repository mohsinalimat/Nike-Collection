//
//  PromoContentViewController.swift
//  Nike Collection
//
//  Created by Shao Kahn on 10/4/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
//import SwiftyGif

class PromoContentViewController: UIViewController {

    @IBOutlet weak var promoImageView: UIImageView!
    
    var pageIndex = 0
    
    var imageName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       //set .gif file into image view
       //setPromoImageViewContent()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//custom functions:
extension PromoContentViewController{
    
//set .gif file into image view
 /*
    fileprivate func setPromoImageViewContent(){
        if let currentImage = imageName{
            let gifImage = UIImage(gifName: currentImage)
            self.promoImageView.setGifImage(gifImage, manager: SwiftyGifManager(memoryLimit:60), loopCount: -1)
        }
        
    }
 */
}
