//
//  PromoContentViewController.swift
//  Nike Collection
//
//  Created by Shao Kahn on 10/4/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import SwiftyGif

class PromoContentViewController: UIViewController {

    @IBOutlet weak var promoImageView: UIImageView!
    
    var pageIndex = 0
    
    var imageName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let currentImage = imageName{
            let gifImage = UIImage(gifName: currentImage)
            self.promoImageView.setGifImage(gifImage, manager: SwiftyGifManager(memoryLimit:60), loopCount: -1)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
