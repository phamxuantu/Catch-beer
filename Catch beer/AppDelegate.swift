//
//  AppDelegate.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import TwitterKit
import Toast_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        TWTRTwitter.sharedInstance().start(withConsumerKey: "ioww3dyK7pUsqR2C7bTF8JZsE", consumerSecret: "QX5q7JCO68pBbnXE5nzeKcTOndUF8KwrHSYthkbY6wPeoY1gEU")
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
//        // add network reachability observer on app start
        NetworkManager.shared.startNetworkReachabilityObserver()
//        print("check connected: ", NetworkManager.shared.startNetworkReachabilityObserver())
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {


        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]) || TWTRTwitter.sharedInstance().application(app, open: url, options: options)

        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("Will Resign Active")
        GameplaySceneClass.sharedInstance.pauseGame()
     }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        print("Did Enter Background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//        print("Will Enter Foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("Did Become Active")
        GameplaySceneClass.sharedInstance.prepareResume()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//        print("Will Terminate")
    }


}

