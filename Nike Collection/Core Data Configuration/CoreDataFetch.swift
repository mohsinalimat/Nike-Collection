//
//  ProductService.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/7/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import CoreData

class CoreDataFetch {
    
   class var fetchResult:CoreDataFetch{
        let fetchresult = CoreDataFetch()
        return fetchresult
    }
    
   fileprivate  var managedObjectContexts = CoreDataStack().persistentContainer.viewContext
    
     func productsServe(category type: String) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        request.predicate = NSPredicate(format: "type == %@", type)
              
        do {
            
   let products = try self.managedObjectContexts.fetch(request)
      
    //check if core data has saved successfullly
       print(products)
            
    //if each time items count in console is same, this means the resetdata feature has effect
            print(products.count)
            
            return products
        }
        catch let error as NSError {
            fatalError("Error is getting product list: \(error.localizedDescription)")
        }
    }
    
}
