//
//  UserListViewController.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 16/04/21.
//

import UIKit

class UserListViewController: UIViewController {

   
    //MARK:- @IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    var viewModel = UserViewModel()
    var userModel = [UserDataModel]()
    var femaleArr = [UserDataModel]()
    var maleArr = [UserDataModel]()
    
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        getUsersList()
    }
    
    
    //MARK:- API Requests
    func getUsersList() {
        viewModel.getUserListData()
    }

    
    //MARK:- Extra methods
    
    
    
    //MARK:- @IBActions
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
}

extension UserListViewController: UserControllerDelegate {
    
    func userDataSuccess(data: [UserDataModel]) {
        self.userModel = data
        
        for each in self.userModel {
            if each.gender == k.female {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        if segmentControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = self.femaleArr[indexPath.row].name ?? ""
        } else {
            cell.textLabel?.text = self.maleArr[indexPath.row].name ?? ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerConstants.userProfileViewController) as! UserProfileViewController
        
        if segmentControl.selectedSegmentIndex == 0 {
            nextVC.userDetails = self.femaleArr[indexPath.row]
        } else {
            nextVC.userDetails = self.maleArr[indexPath.row]
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
