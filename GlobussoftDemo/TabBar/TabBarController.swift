//
//  TabBarController.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate,TabbarDelegate{
   
    // View Did Load
    var selectedItem = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.tabBar as? MainTabBar)?.tabdelegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func tabBarButtonTapped() {
        self.selectedItem = 2
        self.selectedIndex = 2
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(selectedIndex != 2 || self.selectedItem == 2){
            NotificationCenter.default.post(name: Notification.Name("ChangeImage"), object: nil)
        }
    }
   
}
