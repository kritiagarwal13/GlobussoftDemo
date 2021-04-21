//
//  AppDelegate.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 15/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13.0, *) { window?.overrideUserInterfaceStyle = .light }
        //AppUpdater.shared.showUpdate(withConfirmation: true)
        
        return true
    }

}

