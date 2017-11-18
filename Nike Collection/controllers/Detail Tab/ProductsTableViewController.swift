//
//  ProductsTableViewController.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/9/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import CoreData

class ProductsTableViewController: UITableViewController{

    //just a num as section tag
    let kHeaderSectionTag = 6900
    
    //also just a header num
    var expandedSectionHeaderNumber = -1
    
    //section view
    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    //as section title
    var sectionNames = [String]()
    
    //as section cells
    var sectionItems = [[Product]]()
    
    //selected cell
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       setFootView()
        //tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// custom functions
extension ProductsTableViewController{
    
    //can't show foot view
    private func setFootView(){
         tableView.tableFooterView = UIView()
    }
    
    //fetch cells data from CoreData
    private func fetchData(){
        sectionNames = ["Jackets","Shoes","Souvenirs","Shorts"]
        sectionItems = sectionNames.map{ (element) -> [Product] in
            return CoreDataFetch.fetchResult.productsServe(category: element)
        }

        // init the selectedProduct
selectedProduct = CoreDataFetch.fetchResult.productsServe(category: "Jackets").first
        
    }
    
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section = headerView.tag
    let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        
        let sectionData = self.sectionItems[section] as NSArray
        
        self.expandedSectionHeaderNumber = -1
        if (sectionData.count == 0) {
            return
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        
        let sectionData = self.sectionItems[section] as NSArray
        
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1
            return
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }

}

//table view data source
extension ProductsTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = self.sectionItems[section] as NSArray
            return arrayOfItems.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductsTableViewCell
        
        let section = self.sectionItems[indexPath.section]
        
        let currentProduct = section[indexPath.row]
           
        if selectedProduct?.id == currentProduct.id{
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor.green.cgColor
            
            
        }else{
            cell.contentView.layer.borderWidth = 0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            
        }
            
        
        
        cell.productImageView.layer.borderWidth = 2
        cell.productImageView.layer.cornerRadius = 10
        cell.productImageView.layer.borderColor = UIColor.red.cgColor
        
        cell.configureCell(with: section[indexPath.row])
        
        
        return cell
        
    }
    
}

//table view delegate
extension ProductsTableViewController{
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (self.sectionNames.count != 0) {
          
            return self.sectionNames[section]
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 55.0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //recast view as a UITableViewHeaderFooterView
        let header = view as! UITableViewHeaderFooterView
        
        header.contentView.backgroundColor = UIColor(hex: "408000")
        
        header.textLabel?.textColor = UIColor.white
        
        let font = UIFont(name: "ZiGzAgEo", size: 20)!
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        
        header.textLabel?.font = fontMetrics.scaledFont(for: font)
       
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        
        let headerFrame = self.view.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18))
        
        theImageView.image = #imageLiteral(resourceName: "DownArrow")
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(ProductsTableViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
        
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = sectionItems[indexPath.section][indexPath.row]
        tableView.reloadData()
    }
    
}
