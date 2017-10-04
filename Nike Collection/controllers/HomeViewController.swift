//
//  HomeViewController.swift
//  Nike Collection
//
//  Created by Shao Kahn on 10/4/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var pageView: UIView!
    
    var pageViewController: UIPageViewController?
    
    ///initialize assests PDF images
    let arrPageImage = ["LeBronDunkContest","hyper","giphy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setPageViewController()
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


extension HomeViewController{
    
    private func setPageViewController(){
        
        let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVC") as! UIPageViewController
        
        pageVC.dataSource = self
        
        let firstControlller = getViewControlller(atIndex: 0)
        
        //let page slide
        pageVC.setViewControllers([firstControlller], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        //pageVC references pageViewController
        self.pageViewController = pageVC
        
        
        //embed pageVC
        self.addChildViewController(pageViewController!)
        
        //pageVC should be inside the Container View
        self.pageView.addSubview((self.pageViewController?.view)!)
        
        //make sure pageVC ParentController -HomeViewController
        self.pageViewController?.didMove(toParentViewController: self)
        
        
    }
    
    fileprivate func getViewControlller(atIndex index: Int) -> PromoContentViewController{
        
        let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "promoContentVC") as! PromoContentViewController
        
        promoContentVC.imageName = arrPageImage[index]
        promoContentVC.pageIndex = index
        
        return promoContentVC
        
    }
    
    
}


extension HomeViewController: UIPageViewControllerDataSource{
    
    //viewControllerBefore - the silde order is from right to left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentViewController
        var index = pageContentVC.pageIndex
        
        //make image slide order in |0|1|2 |0|1|2 |0|1|2...
        if (index == 0) || (index == NSNotFound){
            return getViewControlller(atIndex: arrPageImage.count - 1)
        }
        
        index -= 1
        
        return getViewControlller(atIndex: index)
    }
    
    //viewControllerAfter - the silde order is from left to right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentViewController
        var index = pageContentVC.pageIndex
        
        if index == NSNotFound{
            return nil
        }
        
        index += 1
        
        if index == arrPageImage.count{
            return getViewControlller(atIndex: 0)
        }
        
        return getViewControlller(atIndex: index)
    }
    
    
    
    
    
    
}




