//
//  UserListTVC.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit

class UserListTVC: UITableViewCell {

    @IBOutlet weak var bgVw: UIView!
    @IBOutlet weak var userImgVw: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImgVw.roundCornerWithShadow(shadowColor: .lightGray, radius: self.userImgVw.frame.height/2, borderWidth: 0, borderColor: .clear, shadowOpacity: 2, shadowRadius: 2, shadowOffsetWidth: 2, shadowOffsetHeight: 2, clipsbounds: true)
        self.bgVw.roundCornerWithShadow(shadowColor: .gray, radius: 10, borderWidth: 0, borderColor: .clear, shadowOpacity: 3, shadowRadius: 3, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
    }
    
    func setCellData(name:String, age:String, distance:String, img:String) {
        self.lblUsername.text = name
        self.lblId.text = "Age: \(age)"
        self.lblEmail.text = "~\(distance) miles away"
        self.userImgVw.sd_setImage(with: URL(string: img)) { (image, error, cache, url) in
            
        }
    }
    
}
