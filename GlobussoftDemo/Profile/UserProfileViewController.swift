//
//  UserProfileViewController.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 16/04/21.
//

import UIKit
import SDWebImage

class UserProfileViewController: UIViewController {
    
    //MARK:- @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLike: UIButton!
    
    
    //MARK:- Properties
    var userDetails: UserDataModel?
    var titleArr = ["", k.gender, k.age, k.id, k.email, k.phone, k.favColor, k.location]
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
        self.btnLike.roundCornerWithShadow(shadowColor: .lightGray, radius: 10, borderWidth: 1, borderColor: .link, shadowOpacity: 1, shadowRadius: 1, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        if isLiked {
            self.btnLike.backgroundColor = UIColor.link
            self.btnLike.setTitleColor(.white, for: .normal)
            self.btnLike.tintColor = .white
        } else {
            self.btnLike.backgroundColor = UIColor.white
            self.btnLike.setTitleColor(.link, for: .normal)
            self.btnLike.tintColor = .link
        }
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "UserProfileImageTVC", bundle: nil), forCellReuseIdentifier: "UserProfileImageTVC")
        tableView.register(UINib(nibName: "UserDetailsTVC", bundle: nil), forCellReuseIdentifier: "UserDetailsTVC")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK:- @IBActions
    
    @IBAction func likeTapped(_ sender: UIButton) {
        if let userDeets = userDetails {
            likedUsers.append(userDeets)
        }
        self.btnLike.backgroundColor = UIColor.link
        self.btnLike.setTitleColor(.white, for: .normal)
        self.btnLike.tintColor = .white
    }
    
}


extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let imgcell = tableView.dequeueReusableCell(withIdentifier: "UserProfileImageTVC", for: indexPath) as! UserProfileImageTVC
            let imgUrlStr =  userDetails?.picture?.replacingOccurrences(of: "'\'", with: "") ?? ""
            print(imgUrlStr)
            imgcell.setCellData(name: userDetails?.name ?? "", lastSeen: userDetails?.lastSeen ?? "", img: imgUrlStr)
            imgcell.userImgVw.image = userImage
            return imgcell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsTVC", for: indexPath) as! UserDetailsTVC
            switch indexPath.row {
            case 1:
                cell.setCellData(title: titleArr[indexPath.row], value: userDetails?.gender ?? "", isLocation: false)
                
            case 2:
                cell.setCellData(title: titleArr[indexPath.row], value: "\(userDetails?.age ?? 0)", isLocation: false)
                
            case 3:
                cell.setCellData(title: titleArr[indexPath.row], value: userDetails?._id ?? "", isLocation: false)
                
            case 4:
                cell.setCellData(title: titleArr[indexPath.row], value: userDetails?.email ?? "", isLocation: false)
                
            case 5:
                cell.setCellData(title: titleArr[indexPath.row], value: userDetails?.phone ?? "", isLocation: false)
                
            case 6:
                cell.setCellData(title: titleArr[indexPath.row], value: userDetails?.favoriteColor ?? "", isLocation: false)
                
            case 7:
                cell.setCellData(title: titleArr[indexPath.row], value: distanceAway, isLocation: true)
                
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

