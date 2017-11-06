//
//  CoreDataDelete.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/5/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import CoreData

class ResetCoreData{
    
    //use LoadProducts name call this var can return a instance of LoadProducts in this all module
    class var shared: ResetCoreData{
        let resetCoreData = ResetCoreData()
        return resetCoreData
    }
    
    
    //get Core Data stack instance
  fileprivate  let managedObjectContext = CoreDataStack().persistentContainer.viewContext
    
 fileprivate  var deleteRequest: NSBatchDeleteRequest?
  
     func deleteProducts(){
    
        let requestInstanceArray = [Product.self,Manufacturer.self,ProductInfo.self,ProductImage.self].map { (classElement) in
             classElement.fetchRequest()
        }
    
        
        do{
_ = try requestInstanceArray.map({ (fetchElement) in
    
    deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchElement )
    _ =  try managedObjectContext.execute(deleteRequest!)
            })
        }catch let error as NSError {
            print("Error in deleting products: \(error.localizedDescription)")
        }
    }
    
}





