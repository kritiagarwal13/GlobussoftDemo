//
//  UserSessionManager.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 22/04/21.
//

import UIKit


class UserSessionManager {
    
    static let shared = UserSessionManager()
    let userDefaults = UserDefaults.standard

    private init() {}
    
    // MARK:- Setting and Getting isRegistered
    func setIsRegistered(value:Bool?){
        userDefaults.set(value, forKey: UserDefaultKey.isRegister)
        userDefaults.synchronize()
    }
    
    func getIsRegistered()->Bool?{
        if let userInfo = userDefaults.value(forKey: UserDefaultKey.isRegister){
            return userInfo as? Bool
        }else{
            return false
        }
    }
    
    // MARK:- Setting and Getting avatar
    func setAvatar(image: UIImage?){
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        userDefaults.set(imageData, forKey: UserDefaultKey.avatar)
    }
      
    func getAvatar()->UIImage?{
        var image: UIImage?
        if let imageData = userDefaults.data(forKey: UserDefaultKey.avatar) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    
    // MARK:- Setting and Getting Displayname
    func setName(value:String?){
        userDefaults.set(value, forKey: UserDefaultKey.name)
        userDefaults.synchronize()
    }
    
    func getName()->String?{
        if let userInfo = userDefaults.value(forKey: UserDefaultKey.name){
            return userInfo as? String
        }else{
            return ""
        }
    }
    
    // MARK:- Setting and Getting Gender
    func setGender(value:String?){
        userDefaults.set(value, forKey: UserDefaultKey.gender)
        userDefaults.synchronize()
    }
    
    func getGender()->String?{
        if let userInfo = userDefaults.value(forKey: UserDefaultKey.gender){
            return userInfo as? String
        }else{
            return "en"
        }
    }
    
    
    // MARK:- Setting and Getting DOB
    func setDOB(value:String?){
        userDefaults.set(value, forKey: UserDefaultKey.dob)
        userDefaults.synchronize()
    }
    
    func getDOB()->String?{
        if let userInfo = userDefaults.value(forKey: UserDefaultKey.dob){
            return userInfo as? String
        }else{
            return ""
        }
    }
   
    func removedata()
    {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
}

