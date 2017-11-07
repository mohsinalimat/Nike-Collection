//
//  CoreDataSave.swift
//  Nike Collection
//
//  Created by Shao Kahn on 11/3/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import CoreData


class CoreDataSave{
   
//use LoadProducts name call this var can return a instance of LoadProducts in this all module
    class var shared: CoreDataSave{
        let loadProducts = CoreDataSave()
        return loadProducts
    }
 
   
    
  // load json data and save them into Core Data
 func loadProducts() {
    
    //get instance of viewContext, it means all momd
    let appDelegateSave = UIApplication.shared.delegate as! AppDelegate
    let managedObjectContext = appDelegateSave.coreDataStack.persistentContainer.viewContext

    let path = Bundle.main.url(forResource: "Products", withExtension: "json")
    
        if let jsonPath = path {
            let data = try? Data(contentsOf: jsonPath)
            
            do {
    guard let jsonData = data else {return}
        
    let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
         
 let jsonArray = jsonResult["products"] as! NSArray
 
                
 //access json in detail
 _ = jsonArray.map{json in loadJson(json: json)}
                
appDelegateSave.coreDataStack.saveContext()
                
}catch let error as NSError {
     print("Error in parsing products.json: \(error.localizedDescription)")
            }
    }
    
    
    //access json in detail
    func loadJson(json: Any) {
        
        let productData = json as! [String: Any]
        //print(json)
        
        
        //As NikeCollectionMomd
        //Product part ------------------------------------------
        
        let product = Product(context: managedObjectContext)
        
        
        _ = ["id","name","type","summary"].map{element in
            guard let item = productData[element] else { return }
            product.setValue(item as? String, forKey: element)
        }
        
        _ = ["regularPrice","salePrice","quantity","rating"].enumerated().map{(offset,element) in
            if offset > 1 {
                if let item = productData[element] {
                    product.setValue((item as AnyObject).int16Value, forKey: element)
                }
            }else {
                if let item = productData[element] {
                    product.setValue((item as? Double)!, forKey: element)
                }
                
            }
        }
        //-------------------------------------------------------
        
        
        
        
        //Manufacturer part --------------------------------------
        let manufacturer = Manufacturer(context: managedObjectContext)
        
        manufacturer.setValue((productData["manufacturerId"] as AnyObject).int16Value, forKey: "id")
        manufacturer.setValue(productData["manufacturerName"] as? String, forKey: "name")
        
        product.setValue(manufacturer, forKey: "manufacturer")
        //--------------------------------------------------------
        
        
        
        
        //ProductImage part --------------------------------------
        let productImages = product.productImages?.mutableCopy() as! NSMutableSet
        
        var mainImageName: String?
        
        if let imageNames = productData["images"] {
            
            _ = (imageNames as! NSArray).map{ imageName in
                
                let productImage = ProductImage(context: managedObjectContext)
                
                let currentImageName = imageName as? String
                let currentImage = Utility.image(withName: currentImageName, andType: "jpg")
                
                let imageData = NSData.init(data: UIImageJPEGRepresentation(currentImage!, 1.0)!) as Data
                
                productImage.setValue(imageData, forKey: "image")
                productImage.setValue(currentImageName, forKey: "name")
                
                if mainImageName == nil && currentImageName?.contains("1") == true {
                    mainImageName = currentImageName
                }
                
                productImages.add(productImage)
            }
            
            product.setValue(productImages.copy() as? NSSet, forKey: "productImages")
        }
        //print(mainImageName)
        product.setValue(mainImageName, forKey: "mainimage")
        
        //--------------------------------------------------------
        
        
        
        
        //ProductInfo part ---------------------------------------
        let productInfo = product.productInfo?.mutableCopy() as! NSMutableSet
        
        _ = ["description1","description2","description3"].map{ element in
            if let description = productData[element] {
                
                let temp = ProductInfo(context: managedObjectContext)
                
                temp.setValue(description as? String, forKey: "info")
                temp.setValue("description", forKey: "type")
                productInfo.add(temp)
            }
        }
        
        _ = ["Brand","US Size(Men's)","Condition","modelNumber"].map{element in
            if let item = productData[element] {
                
                let temp = ProductInfo(context: managedObjectContext)
                
                temp.setValue(element, forKey: "title")
                temp.setValue(item as? String, forKey: "info")
                temp.setValue("specs", forKey: "type")
                productInfo.add(temp)
            }
        }
        
        product.setValue(productInfo.copy() as? NSSet, forKey: "productInfo")
//-----------------------------------------------------
        
    }
 
}
   
  
}



