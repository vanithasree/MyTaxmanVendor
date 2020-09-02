//
//  AppDelegate.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 19/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import GooglePlaces
import IQKeyboardManagerSwift
import Stripe


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        Stripe.setDefaultPublishableKey("pk_test_51GtHk9H5W0t1liVhtEfjefWJI8BHQbozVn18suKGYxG81ha7famiOMHjgMC4B5xjiIUWkKlEphVtxhZXyVflD70O00ZbZIuyWB")
    
        
        if UserDetails.shared.isLoggedIn {
            redirectToHomePage()
        } else {
            redirectToGetStartPage()
        }
        
        GoogleApi.shared.initialiseWithKey("AIzaSyBXugsG-nxQoQMEbIUAEaspFtS7-4rnOFk")
        // Override point for customization after application launch.
        return true
    }
    
    fileprivate  func redirectToHomePage() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard.init(name: "Tabbar", bundle: nil)
        if let tabBar = storyboard.instantiateViewController(withIdentifier: "TBViewController") as? UITabBarController {
            window?.rootViewController = tabBar
            window?.makeKeyAndVisible()
        }
    }
    
    fileprivate  func redirectToGetStartPage() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard.init(name: "Auth", bundle: nil)
        let initialVC = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController = initialVC
    }
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

