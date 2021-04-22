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
    var navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13.0, *) { window?.overrideUserInterfaceStyle = .light }
        //AppUpdater.shared.showUpdate(withConfirmation: true)
        
        if UserSessionManager.shared.getIsRegistered() ?? false {
            navigateToVC()
        } else {
            navigateToRegisterVC()
        }
        
        return true
    }
    
    func navigateToVC()
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        var vc : UIViewController?
        
        vc = Utilities.viewConrollerObject(identifier:ViewControllerConstants.kTabBarController , storyboard: StoryBoardConstants.kMainStoryBoard) as! TabBarController
        
        navigationController = UINavigationController(rootViewController: vc!)
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        #if compiler(>=5.1)
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            window?.overrideUserInterfaceStyle = .light
        }
        #endif
        self.window?.isHidden = false
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    
    func navigateToRegisterVC()
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        var vc : UIViewController?
        
        vc = Utilities.viewConrollerObject(identifier:ViewControllerConstants.registerVc , storyboard: StoryBoardConstants.kMainStoryBoard) as! ViewController
        
        navigationController = UINavigationController(rootViewController: vc!)
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        #if compiler(>=5.1)
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            window?.overrideUserInterfaceStyle = .light
        }
        #endif
        self.window?.isHidden = false
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

}

