//
//  AppNetworking.swift
//  StarterProj
//
//  Created by Gurdeep on 16/12/16.
//  Copyright © 2016 Gurdeep. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

//MARK:- Api Code
//=======================
enum ApiCode {
    
    static var success                  : Int { return 200 } // Success
    static var unauthorizedRequest      : Int { return 206 } // Unauthorized request
    static var headerMissing            : Int { return 207 } // Header is missing
    static var phoneNumberAlreadyExist  : Int { return 208 } // Phone number alredy exists
    static var requiredParametersMissing: Int { return 418 } // Required Parameter Missing or Invalid
    static var fileUploadFailed         : Int { return 421 } // File Upload Failed
    static var pleaseTryAgain           : Int { return 500 } // Please try again
    static var tokenExpired             : Int { return 401 } // Token expired refresh token needed to be generated
    static var noData                   : Int { return 404 } // No data found
    static var noNetwork                : Int { return -1009} //kCFErrorDomainCFNetwork

}


typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias SuccessResponse = (_ json : JSON) -> ()
typealias FailureResponse = (Error) -> (Void)
//typealias UserControllerSuccess = (_ user : User) -> ()


extension Notification.Name {
    
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum AppNetworking {
    
    //    static let USER = "admin"
    //    static let PASSWORD = "mypass"
    //    static let REALM = "8AC74BD0018D507238924D65D0184E93"
    //    static let NONCE = "12345"
    //    static let QOP = "auth"
    //    static let NONCE_COUNT = "12345"
    //    static let CNONCE = "123"
    
//    static var alamofireManager: SessionManager!
    
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func configureAlamofire() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15 // seconds
        configuration.timeoutIntervalForResource = 15
//        self.alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    static func isInternetAvailable()-> Bool{
        
        //        guard let remoteHostStatus = sharedAppDelegate.reachable?.currentReachabilityStatus() else {return false}
        //        if remoteHostStatus == ReachableViaWiFi || remoteHostStatus == ReachableViaWWAN{
        return true
        //        }
        //
        //        return false
    }

    static let username = "admin"
    static let password = "12345"
    
    static func POST(endPoint : WebServices.EndPoint,
                     parameters : JSONDictionary = [:],
                     headers : HTTPHeaders = [:],
                     loader : Bool = true,
                     success : @escaping (JSON) -> Void,
                     failure : @escaping (Error) -> Void) {
        
        
        request(URLString: endPoint.path, httpMethod: .post, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func GET(endPoint : WebServices.EndPoint,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        request(URLString: endPoint.path, httpMethod: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func PUT(endPoint : WebServices.EndPoint,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        request(URLString: endPoint.path, httpMethod: .put, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func DELETE(endPoint : WebServices.EndPoint,
                       parameters : JSONDictionary = [:],
                       headers : HTTPHeaders = [:],
                       loader : Bool = true,
                       success : @escaping (JSON) -> Void,
                       failure : @escaping (Error) -> Void) {
        
        request(URLString: endPoint.path, httpMethod: .delete, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    private static func request(URLString : String,
                                httpMethod : HTTPMethod,
                                parameters : JSONDictionary = [:],
                                encoding: ParameterEncoding = URLEncoding.httpBody,
                                headers : HTTPHeaders = [:],
                                loader : Bool = true,
                                success : @escaping (JSON) -> Void,
                                failure : @escaping (NSError) -> Void) {
        
        if loader { }
           print(parameters)
                
        makeRequest(URLString: URLString, httpMethod: httpMethod, parameters: parameters, encoding: encoding, headers: [:], loader: loader, success: { (json) in
//            let code = json["status_code"].intValue
//            if code == ApiCode.success{
//                if loader { }
                success(json)
//            }else if code == ApiCode.tokenExpired{
////                CommonFunctions.sessionExpired(message: message)
//            }else if code == ApiCode.noData{
//                failure(NSError.init(code: code, localizedDescription: json["message"].stringValue))
//            }
        }, failure: failure)
    }
    
    private static func makeRequest(URLString : String,
                                    httpMethod : HTTPMethod,
                                    parameters : JSONDictionary = [:],
                                    encoding: ParameterEncoding = URLEncoding.queryString,
                                    headers : HTTPHeaders = [:],
                                    loader : Bool = true,
                                    success : @escaping (JSON) -> Void,
                                    failure : @escaping (NSError) -> Void) {
        
        
        AF.request(URLString, method: .post, parameters: parameters, encoding: encoding, headers: [:]).responseJSON { (response) in
            
            if loader { }
            
            print("===================== METHOD =========================")
            print(httpMethod)
            print("===================== ENCODING =======================")
            print(encoding)
            print("===================== URL STRING =====================")
            print(URLString)
            print("===================== HEADERS ========================")
            print(headers)
            print("===================== PARAMETERS =====================")
            print(parameters.description)
            
            switch(response.result) {
            case .success(let value):
                print("===================== RESPONSE =======================")
                print(JSON(value))
                let json = JSON(value)
//                  let sdata = CommonFunctions.decryptData(data: json["data"].stringValue)
                  success(json)
                
            case .failure(let e):
                print("===================== FAILURE =======================")
                if loader { }
                let error = NSError(localizedDescription: e.localizedDescription)
                print(error)
                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
                    
                    NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
                    
//                    CommonFunctions.showToastWithMessage(LocalizedString.pleaseCheckInternetConnection.localized)
                    failure(error)
                } else {
                    failure(error)
                }
            }
        }
    }
    
}




