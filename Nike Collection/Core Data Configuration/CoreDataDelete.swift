//
//  CoreDataDelete.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/5/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import CoreData

class CoreDataDelete{
    
    //use LoadProducts name call this var can return a instance of LoadProducts in this all module
    class var shared: CoreDataDelete{
        let resetCoreData = CoreDataDelete()
        return resetCoreData
    }
    

    func resetRequest(){
        
        //get Core Data stack instance
    let appDelegateDelete = UIApplication.shared.delegate as!
        AppDelegate
        let managedObjectContext = appDelegateDelete.coreDataStack.persistentContainer.viewContext
 
        let fetchResultArrs = [Product.self,Manufacturer.self,ProductInfo.self,ProductImage.self].map {$0.fetchRequest()}
    
        /*
        let productRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let manufacturerRequest: NSFetchRequest<Manufacturer> = Manufacturer.fetchRequest()
        let productInfoRequest: NSFetchRequest<ProductInfo> = ProductInfo.fetchRequest()
        let productImageRequest: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()
        */

        do{
            
_ =  try fetchResultArrs.map{ (element) in
    
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: element)
     _ =  try managedObjectContext.execute(deleteRequest) as! NSBatchDeleteResult
            }
            
        }catch  {
            
        }
    }
    
}





