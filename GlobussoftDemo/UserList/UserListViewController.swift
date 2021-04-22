//
//  UserListViewController.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 16/04/21.
//

import UIKit
import CoreLocation

class UserListViewController: UIViewController {

   
    //MARK:- @IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    var viewModel = UserViewModel()
    var userModel = [UserDataModel]()
    var femaleArr = [UserDataModel]()
    var maleArr = [UserDataModel]()
    var userGender = ""
    let locationManager = CLLocationManager()
    
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    
    //MARK:- API Requests
    func getUsersList() {
        viewModel.getUserListData()
    }

    
    //MARK:- Extra methods
    
    func initialSetup() {
        setupTableView()
        viewModel.delegate = self
        getUsersList()
        userGender = UserSessionManager.shared.getGender() ?? "male"
        if userGender == "male" || userGender == "Male" {
            self.segmentControl.selectedSegmentIndex = 1
        } else {
            self.segmentControl.selectedSegmentIndex = 0
        }
        
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "UserListTVC", bundle: nil), forCellReuseIdentifier: "UserListTVC")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK:- @IBActions
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
}

extension UserListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        userCurrentLatitude = locValue.latitude
        userCurrentLongitude = locValue.longitude
    }
    
}

extension UserListViewController: UserControllerDelegate {
    
    func userDataSuccess(data: [UserDataModel]) {
        self.userModel = data
        
        for each in self.userModel {
            if each.gender == k.female || each.gender == k.Female {
                self.femaleArr.append(each)
            } else {
                self.maleArr.append(each)
            }
        }
        
        self.tableView.reloadData()
    }
    
    func userDataFailed(message: String) {
        print(message)
    }
    
}


extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentControl.selectedSegmentIndex == 0 {
            return self.femaleArr.count
        } else {
            return self.maleArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTVC", for: indexPath) as! UserListTVC
        
        if segmentControl.selectedSegmentIndex == 1 {
            let imgUrlStr =  self.femaleArr[indexPath.row].picture?.replacingOccurrences(of: "'\'", with: "") ?? ""
            let distance = Utilities.getDistance(from: CLLocation(latitude: userCurrentLatitude, longitude: userCurrentLongitude), to: CLLocation(latitude: self.femaleArr[indexPath.row].geoLocation?.latitude ?? 0.0, longitude: self.femaleArr[indexPath.row].geoLocation?.longitude ?? 0.0))
            cell.setCellData(name: self.femaleArr[indexPath.row].name ?? "", age: "\(self.femaleArr[indexPath.row].age ?? 0)", distance: "\(distance)", img: imgUrlStr)
            if indexPath.row % 2 == 0 {
                cell.userImgVw.image = #imageLiteral(resourceName: "female1")
            } else if indexPath.row % 3 == 0 {
                cell.userImgVw.image = #imageLiteral(resourceName: "female3")
            } else {
                cell.userImgVw.image = #imageLiteral(resourceName: "female2")
            }
        } else {
            let imgUrlStr =  self.maleArr[indexPath.row].picture?.replacingOccurrences(of: "'\'", with: "") ?? ""
            let distance = Utilities.getDistance(from: CLLocation(latitude: userCurrentLatitude, longitude: userCurrentLongitude), to: CLLocation(latitude: self.maleArr[indexPath.row].geoLocation?.latitude ?? 0.0, longitude: self.maleArr[indexPath.row].geoLocation?.longitude ?? 0.0))
            cell.setCellData(name: self.maleArr[indexPath.row].name ?? "", age: "\(self.maleArr[indexPath.row].age ?? 0)", distance: "\(distance)", img: imgUrlStr)
            if indexPath.row % 2 == 0 {
                cell.userImgVw.image = #imageLiteral(resourceName: "male2")
            } else if indexPath.row % 3 == 0 {
                cell.userImgVw.image = #imageLiteral(resourceName: "male1")
            } else {
                cell.userImgVw.image = #imageLiteral(resourceName: "male3")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerConstants.userProfileViewController) as! UserProfileViewController
        
        if segmentControl.selectedSegmentIndex == 1 {
            let distance = Utilities.getDistance(from: CLLocation(latitude: userCurrentLatitude, longitude: userCurrentLongitude), to: CLLocation(latitude: self.femaleArr[indexPath.row].geoLocation?.latitude ?? 0.0, longitude: self.femaleArr[indexPath.row].geoLocation?.longitude ?? 0.0))
            nextVC.userDetails = self.femaleArr[indexPath.row]
            nextVC.distanceAway = "\(distance)"
            if indexPath.row % 2 == 0 {
                nextVC.userImage = #imageLiteral(resourceName: "female1")
            } else if indexPath.row % 3 == 0 {
                nextVC.userImage = #imageLiteral(resourceName: "female3")
            } else {
                nextVC.userImage = #imageLiteral(resourceName: "female2")
            }
        } else {
            let distance = Utilities.getDistance(from: CLLocation(latitude: userCurrentLatitude, longitude: userCurrentLongitude), to: CLLocation(latitude: self.maleArr[indexPath.row].geoLocation?.latitude ?? 0.0, longitude: self.maleArr[indexPath.row].geoLocation?.longitude ?? 0.0))
            nextVC.userDetails = self.maleArr[indexPath.row]
            nextVC.distanceAway = "\(distance)"
            if indexPath.row % 2 == 0 {
                nextVC.userImage = #imageLiteral(resourceName: "male2")
            } else if indexPath.row % 3 == 0 {
                nextVC.userImage = #imageLiteral(resourceName: "male1")
            } else {
                nextVC.userImage = #imageLiteral(resourceName: "male3")
            }
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
