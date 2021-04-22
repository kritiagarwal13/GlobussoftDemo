//
//  MainTabBar.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit


protocol TabbarDelegate:class {
    func tabBarButtonTapped()
}

class MainTabBar: UITabBar {
    
    private var middleButton = UIButton()
    private var bgView = UIView()

    weak var tabdelegate : TabbarDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()

        if #available(iOS 13.0, *) {
            let appearance = self.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundColor = UIColor.white
            
            self.standardAppearance = appearance
        } else {
            self.shadowImage = UIImage()
           
            
        }

        self.tintColor = UIColor.link
        self.unselectedItemTintColor = .white
        self.isTranslucent = false
        self.layer.shadowColor = UIColor.init(red: 0, green:0, blue: 0, alpha: 0.4).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeImage(notification:)), name: Notification.Name("ChangeImage"), object: nil)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        
        let from = point
        let to = middleButton.center

        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? middleButton : super.hitTest(point, with: event)
    }
    
    @objc func tabBarButtonTapped() {
        let vc1 = Utilities.viewConrollerObject(identifier:ViewControllerConstants.userProfileViewController , storyboard: StoryBoardConstants.kMainStoryBoard) as! UserListViewController

        Utilities.topViewController()?.navigationController?.viewControllers.append(vc1)
        Utilities.topViewController()?.navigationController?.pushViewController(vc1, animated: true)
    }
    
    @objc func changeImage(notification: NSNotification){
        
        
    }
}

