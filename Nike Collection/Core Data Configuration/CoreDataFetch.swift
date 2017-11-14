//
//  ProductService.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/7/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataFetch {
    
   class var fetchResult:CoreDataFetch{
    
        let fetchresult = CoreDataFetch()
        return fetchresult
    }
    
   fileprivate let appDelegateFetch = UIApplication.shared.delegate as! AppDelegate
    
   
     func productsServe(category type: String) -> [Product] {
    
        let managedObjectContexts = appDelegateFetch.coreDataStack.persistentContainer.viewContext
        
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        request.predicate = NSPredicate(format: "type == %@", type)
              
        do {
            
   let products = try managedObjectContexts.fetch(request)
      
    //check if core data has saved successfullly
       //print(products)
            
    //if each time items count in console is same, this means the resetdata feature has effect
            //print(products.count)
            
            return products
        }
        catch let error as NSError {
            fatalError("Error is getting product list: \(error.localizedDescription)")
        }
    }
    
    
}
