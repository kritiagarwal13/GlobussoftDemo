//
//  UserDetailsTVC.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit

class UserDetailsTVC: UITableViewCell {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var detailTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setCellData(title:String, value:String, isLocation: Bool) {
        self.lblHeader.text = title
        if isLocation {
            self.detailTF.text = "\(value) miles away"
        } else {
            self.detailTF.text = value
        }
        
    }
    
}
