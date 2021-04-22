//
//  SelfProfileVC.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit

class SelfProfileVC: UIViewController {

    //MARK:- @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK:- Properties
    var userDetails: UserDataModel?
    var titleArr = ["", k.gender, k.dob]
    var userImage : UIImage?
    var isLiked = false
    var distanceAway = ""
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    
    //MARK:- Extra methods
    
    func initialSetup() {
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "UserProfileImageTVC", bundle: nil), forCellReuseIdentifier: "UserProfileImageTVC")
        tableView.register(UINib(nibName: "UserDetailsTVC", bundle: nil), forCellReuseIdentifier: "UserDetailsTVC")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK:- @IBActions
    
}


extension SelfProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let imgcell = tableView.dequeueReusableCell(withIdentifier: "UserProfileImageTVC", for: indexPath) as! UserProfileImageTVC
        
            imgcell.setImageCellData(name: UserSessionManager.shared.getName() ?? "", lastSeen: "", img: UserSessionManager.shared.getAvatar() ?? UIImage())
            imgcell.userImgVw.image = UserSessionManager.shared.getAvatar() ?? UIImage()
            return imgcell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsTVC", for: indexPath) as! UserDetailsTVC
            switch indexPath.row {
            case 1:
                cell.setCellData(title: titleArr[indexPath.row], value: UserSessionManager.shared.getGender() ?? "", isLocation: false)
                
            case 2:
                cell.setCellData(title: titleArr[indexPath.row], value: UserSessionManager.shared.getDOB() ?? "", isLocation: false)
                
            default:
                break
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        } else {
            return 85
        }
    }
    
    
}

