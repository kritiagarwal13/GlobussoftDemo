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
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLastSeen: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Properties
    var userDetails: UserDataModel?
    var titleArr = [k.gender, k.age, k.id, k.email, k.phone, k.favColor, k.location]
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }

    
    //MARK:- Extra methods
    func initialSetup() {
        let imageUrlStr = userDetails?.picture?.replacingOccurrences(of: "'\'", with: "") ?? ""
        let imgUrl = URL(string: imageUrlStr)!
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        URLSession(configuration: config).dataTask(with: imgUrl) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }

            // use your data here
            self.imgVw.sd_setImage(with: imgUrl) { (image, err, cache, URL) in
                
            }
        }.resume()
        self.lblName.text = userDetails?.name
        self.lblLastSeen.text = userDetails?.lastSeen
    }
    
    
    //MARK:- @IBActions
    

}


extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileDetailCell", for: indexPath) as! ProfileDetailCell
        switch indexPath.row {
        case 0:
            cell.lblHeader.text = titleArr[indexPath.row]
            cell.detailTF.text = userDetails?.gender
        case 1:
            cell.lblHeader.text = titleArr[indexPath.row]
            cell.detailTF.text = "\(userDetails?.age ?? 0)"
        case 2:
            cell.lblHeader.text = titleArr[indexPath.row]
            cell.detailTF.text = userDetails?._id
        case 3:
            cell.lblHeader.text = titleArr[indexPath.row]
            cell.detailTF.text = userDetails?.email
        case 4:
            cell.lblHeader.text = titleArr[indexPath.row]
            cell.detailTF.text = userDetails?.phone
        case 5:
            cell.lblHeader.text = titleArr[indexPath.row]
            cell.detailTF.text = userDetails?.favoriteColor
        case 6:
            cell.lblHeader.text = titleArr[indexPath.row]
            cell.detailTF.text = "[\(userDetails?.geoLocation?.latitude ?? 0.0), \(userDetails?.geoLocation?.longitude ?? 0.0)]"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
}


class ProfileDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var detailTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
