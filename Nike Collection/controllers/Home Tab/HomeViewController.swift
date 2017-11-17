//
//  HomeViewController.swift
//  Nike Collection
//
//  Created by Shao Kahn on 10/4/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UIPageViewControllerDataSource,UICollectionViewDataSource {

    
    @IBOutlet weak var pageView: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var newestCollectionView: UICollectionView!{
        didSet{self.newestCollectionView.dataSource = self}
    }
    
    @IBOutlet weak var bestCollectionView: UICollectionView!{
        didSet{self.bestCollectionView.dataSource = self}
    }
    
    
    // aim to get promoPageVC in Storyboard
    var pageViewController: UIPageViewController?
    
    // initialize assests PDF images
    let arrPageImage = ["Jordan", "Lebron", "Fuck"]
    
    // use this in automatic sliding feature function
    var currentIndex = 0
    
    //newest and best colleciton view needs array
    var newestCollection = [Product]()
    var bestCollection = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set page slide automatically 3.0 seconds
        pageSlideRunTimes()
        
        //set container view
        setPageViewController()
        
        //set newest and best arrays data and send datasource to self
        collectionViewDataInit()
        
        //set navigation bar colorful 
        gradientNavigationBar()
        
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

}//class HomeViewController over line

//custom functions
extension HomeViewController{
    
    //run loadNextController function 3.0 seconds
    fileprivate func pageSlideRunTimes(){
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(HomeViewController.loadNextController), userInfo: nil, repeats: true)
        
    }
  
    //set container view
    fileprivate func setPageViewController(){
        
        let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVC") as! UIPageViewController
        
        pageVC.dataSource = self
        
        let firstControlller = getViewControlller(atIndex: 0)
       
        
        //set the page content initialization
        pageVC.setViewControllers([firstControlller], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        // if play Double sides , there will need two controllers in controller array
        
        
        //assign to pageViewController property
        self.pageViewController = pageVC
        
        
        //add to pageViewController to HomeViewController
        self.addChildViewController(pageViewController!)
        
        
        //add the pageViewController as the subClass of HomeViewController
self.pageView.addSubview(self.pageViewController!.view)
    self.pageViewController?.didMove(toParentViewController: self)
    }
    
    //get gif pics
    fileprivate func getViewControlller(atIndex index: Int) -> PromoContentViewController{
        
        let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "promoContentVC") as! PromoContentViewController
        
        promoContentVC.imageName = arrPageImage[index]
        promoContentVC.pageIndex = index
        
        return promoContentVC
        
    }
    
    //make page slide by itself
    @objc private func loadNextController(){
        
        currentIndex += 1
        
        //when currentIndex is 2, and it plus 1 will euqals to 3,but 3 is not in arrPageImage index
        if currentIndex == arrPageImage.count{
            currentIndex = 0
        }
        
        let nextControler = getViewControlller(atIndex: currentIndex)
        
        //set the viewContrller to display
        self.pageViewController?.setViewControllers([nextControler], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
       
        //currentPage equals to currentIndex
        self.pageControl.currentPage = currentIndex
    }
   
//set newest and best arrays data
    private func collectionViewDataInit(){
        newestCollection = CoreDataFetch.fetchResult.productsServe(category: "Souvenirs")
        bestCollection = CoreDataFetch.fetchResult.productsServe(category: "Shoes")

    }

 //set navigation bar colorful 
    private func gradientNavigationBar(){
navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.400000006, green: 0, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0.5019999743, alpha: 1),#colorLiteral(red: 0, green: 0.5019999743, blue: 0, alpha: 1)])
  
    }
    
}


//pageVC - datasource
extension HomeViewController{
    
    //viewControllerBefore - the silde order is from right to left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentViewController
        var index = pageContentVC.pageIndex
        
        //make image slide order in |2|1|0 |2|1|0 |2|1|0...
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
        
        //make image slide order in |0|1|2 |0|1|2 |0|1|2...
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

//collectionView - datasource
extension HomeViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
            
        case self.newestCollectionView:
            return self.newestCollection.count
            
        case self.bestCollectionView:
            return self.bestCollection.count
            
        default :
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case self.newestCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newestItems", for: indexPath) as! ProductCollectionViewCell
            let product = newestCollection[indexPath.row]
            
            cell.productsImageView.image = Utility.image(withName: product.mainimage, andType: "jpg")
            cell.layer.cornerRadius = cell.bounds.size.width / 2
            
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.randomColor().cgColor
          
            return cell
            
        case self.bestCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bestItems", for: indexPath) as! ProductCollectionViewCell
            let product = bestCollection[indexPath.row]
            
            cell.productsImageView.image = Utility.image(withName: product.mainimage, andType: "jpg")
            
            cell.layer.cornerRadius = cell.bounds.size.width / 2
            
            cell.layer.borderWidth = 5
     cell.layer.borderColor = UIColor.randomColor().cgColor
     
            return cell
    
            
        default:
            return UICollectionViewCell()
        }
        
    }

}


