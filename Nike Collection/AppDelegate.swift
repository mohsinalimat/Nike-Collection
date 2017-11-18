//
//  AppDelegate.swift
//  Nike Collection
//
//  Created by Shao Kahn on 10/4/17.
//  Copyright © 2017 Mac. All rights reserved.
//



import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate {

    var window: UIWindow?
    
//get Core Data Stack class instance
var coreDataStack = CoreDataStack()
    
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //change bar background color to #000000
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    
        //change status text color to white
     UIApplication.shared.statusBarStyle = .lightContent
    
    //reset Core Data, for fetch an smanageobj as each entity in one time
      CoreDataDelete.shared.resetRequest()
        
        //save json data to Core Data
        CoreDataSave.shared.loadProducts()
    
        //Core Data files save location
   let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    
        //shows location in console
        print(urls[urls.count-1] as URL)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



}

