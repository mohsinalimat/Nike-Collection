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
            
       print(products)
            print(products.count)
            
            return products
        }
        catch let error as NSError {
            fatalError("Error is getting product list: \(error.localizedDescription)")
        }
    }
    
}
