//
//  LikedListVC.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit
import CoreLocation

class LikedListVC: UIViewController {
    
    //MARK:- @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK:- Properties
    
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if likedUsers.count > 0 {
            self.lblNoData.isHidden = true
            self.tableView.isHidden = false
        } else {
            self.tableView.isHidden = true
            self.lblNoData.isHidden = false
        }
        self.tableView.reloadData()
    }
    
    
    //MARK:- API Requests
    
    
    //MARK:- Extra methods
    
    func setupTableView() {
        tableView.register(UINib(nibName: "UserListTVC", bundle: nil), forCellReuseIdentifier: "UserListTVC")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK:- @IBActions
    
    
}


extension LikedListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return likedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTVC", for: indexPath) as! UserListTVC
        
        let imgUrlStr =  likedUsers[indexPath.row].picture?.replacingOccurrences(of: "'\'", with: "") ?? ""
        print(imgUrlStr)
        
        let distance = Utilities.getDistance(from: CLLocation(latitude: userCurrentLatitude, longitude: userCurrentLongitude), to: CLLocation(latitude: likedUsers[indexPath.row].geoLocation?.latitude ?? 0.0, longitude: likedUsers[indexPath.row].geoLocation?.longitude ?? 0.0))
        cell.setCellData(name: likedUsers[indexPath.row].name ?? "", age: "\(likedUsers[indexPath.row].age ?? 0)", distance: "\(distance)", img: imgUrlStr)
        if indexPath.row % 2 == 0 {
            if likedUsers[indexPath.row].gender == "male" || likedUsers[indexPath.row].gender == "Male" {
                cell.userImgVw.image = #imageLiteral(resourceName: "male2")
            } else {
                cell.userImgVw.image = #imageLiteral(resourceName: "female1")
            }
        } else if indexPath.row % 3 == 0 {
            if likedUsers[indexPath.row].gender == "male" || likedUsers[indexPath.row].gender == "Male" {
                cell.userImgVw.image = #imageLiteral(resourceName: "male1")
            } else {
                cell.userImgVw.image = #imageLiteral(resourceName: "female3")
            }
        } else {
            if likedUsers[indexPath.row].gender == "male" || likedUsers[indexPath.row].gender == "Male" {
                cell.userImgVw.image = #imageLiteral(resourceName: "male3")
            } else {
                cell.userImgVw.image = #imageLiteral(resourceName: "female2")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerConstants.userProfileViewController) as! UserProfileViewController
        nextVC.userDetails = likedUsers[indexPath.row]
        
        let distance = Utilities.getDistance(from: CLLocation(latitude: userCurrentLatitude, longitude: userCurrentLongitude), to: CLLocation(latitude: likedUsers[indexPath.row].geoLocation?.latitude ?? 0.0, longitude: likedUsers[indexPath.row].geoLocation?.longitude ?? 0.0))
        nextVC.distanceAway = "\(distance)"
        nextVC.isLiked = true
        
        if indexPath.row % 2 == 0 {
            if likedUsers[indexPath.row].gender == "male" || likedUsers[indexPath.row].gender == "Male" {
                nextVC.userImage = #imageLiteral(resourceName: "male2")
            } else {
                nextVC.userImage = #imageLiteral(resourceName: "female1")
            }
        } else if indexPath.row % 3 == 0 {
            if likedUsers[indexPath.row].gender == "male" || likedUsers[indexPath.row].gender == "Male" {
                nextVC.userImage = #imageLiteral(resourceName: "male1")
            } else {
                nextVC.userImage = #imageLiteral(resourceName: "female3")
            }
        } else {
            if likedUsers[indexPath.row].gender == "male" || likedUsers[indexPath.row].gender == "Male" {
                nextVC.userImage = #imageLiteral(resourceName: "male3")
            } else {
                nextVC.userImage = #imageLiteral(resourceName: "female2")
            }
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
