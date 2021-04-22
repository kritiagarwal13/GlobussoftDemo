//
//  Utilities.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit
import CoreLocation

class Utilities {
    
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name:StoryBoardConstants.kMainStoryBoard,bundle: Bundle.main)
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func changeRootViewController(navigation: UINavigationController?,controller:UIViewController?){
        if let navigationController = navigation {
            navigationController.setViewControllers([controller!], animated: true)
        }
        
    }
    
    class func pushViewController(fromVC:UIViewController, toVC: UIViewController, identifier: String,storyboard: String)
    {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        fromVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    class func viewConrollerObject(identifier: String,storyboard: String)-> UIViewController{
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    class func getDistance(from: CLLocation, to: CLLocation) -> Double {
        let distance = from.distance(from: to)
        let distanceInMiles = getMiles(i: distance)
        return distanceInMiles.rounded(toPlaces: 1)
    }
    
    class func getMiles(i:Double) -> Double {
         return i * 0.000621371192
    }
    
    class func getStoryBoard(name:String)-> UIStoryboard{
        let storyboard = UIStoryboard(name: name, bundle:Bundle.main)
        return storyboard
    }

}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
