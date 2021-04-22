//
//  UserProfileImageTVC.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit

class UserProfileImageTVC: UITableViewCell {

    @IBOutlet weak var userImgVw: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblLastSeen: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImgVw.roundCornerWithShadow(shadowColor: .lightGray, radius: self.userImgVw.frame.height/2, borderWidth: 0, borderColor: .clear, shadowOpacity: 2, shadowRadius: 2, shadowOffsetWidth: 2, shadowOffsetHeight: 2, clipsbounds: true)
    }
    
    func setCellData(name:String, lastSeen:String, img:String) {
        self.lblUsername.text = name
        self.lblLastSeen.text = lastSeen
        self.userImgVw.sd_setImage(with: URL(string: img)) { (image, error, cache, url) in
            
        }
    }
    
    func setImageCellData(name:String, lastSeen:String, img:UIImage) {
        self.lblUsername.text = name
        self.lblLastSeen.text = lastSeen
        self.userImgVw.image = img
    }
}
