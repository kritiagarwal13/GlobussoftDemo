//
//  UserController.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 16/04/21.
//

import Foundation
import SwiftyJSON

protocol UserControllerDelegate : AnyObject {
    func userDataSuccess(data: [UserDataModel])
    func userDataFailed(message: String)
}


class UserViewModel {
    
    weak var delegate: UserControllerDelegate?
    
    func getUserListData() {
        
        WebServices.getUserData(parameters: [:], success: { (json) in
            let jsonData =  json.arrayValue.map { UserDataModel(withJSON: $0) }
            self.delegate?.userDataSuccess(data: jsonData)
        }) { (error) -> (Void) in
            self.delegate?.userDataFailed(message: error.localizedDescription)
        }
    }
    
}
