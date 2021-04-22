//
//  Constants.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 21/04/21.
//

import Foundation

var likedUsers = [UserDataModel]()
var userCurrentLatitude : Double = 0.0
var userCurrentLongitude : Double = 0.0

struct k {
    
    static let latitude = "Latitude"
    static let longitude = "Longitude"
    static let female = "female"
    static let Female = "Female"
    static let gender = "Gender"
    static let age = "Age"
    static let id = "ID"
    static let email = "Email"
    static let phone = "Phone"
    static let favColor = "Favorite Color"
    static let location = "Location"
    static let kMomentAgo = "just now"
    static let kYearAgo = "year ago"
    static let kYearsAgo = "years ago"
    static let kMonthAgo = "month ago"
    static let kMonthsAgo = "months ago"
    static let kDayAgo = "day ago"
    static let kDaysAgo = "days ago"
    static let kHourAgo = "hour ago"
    static let kHoursAgo = "hours ago"
    static let kMinAgo = "min ago"
    static let kMinsAgo = "mins ago"
    static let kSecAgo = "sec ago"
    static let kSecsAgo = "secs ago"
    static let kDeviceWithNoCamera = "This device has no Camera"
    static let kCameraNotFound = "Camera Not Found"
    static let kOK = "Ok"
    static let kCancel = "Cancel"
    static let kUpload_Image = "Upload Image"
    static let kTake_Picture = "Take Picture"
    static let kChoose_Existing = "Choose Existing"
    static let dob = "Date of birth"
    
}


struct ViewControllerConstants {
    static let userProfileViewController = "UserProfileViewController"
    static let likedListVC = "LikedListVC"
    static let kTabBarController = "TabBarController"
    static let registerVc = "ViewController"
}

struct StoryBoardConstants {
    static let kMainStoryBoard = "Main"
}


struct UserDefaultKey {
    static let isRegister = "isRegister"
    static let gender = "gender"
    static let avatar = "avatar"
    static let name = "name"
    static let dob = "dob"
}
