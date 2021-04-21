//
//  Webservice+EndPoints.swift
//  StarterProj
//
//  Created by Gurdeep on 06/03/17.
//  Copyright © 2017 Gurdeep. All rights reserved.
//

import Foundation

let BASE_URL = "http://www.json-generator.com/api/json/get/ceiNKFwyaa?indent=2"   //Live url


extension WebServices {

    enum EndPoint : String {
        
        case userData = ""
        
        
        var path : String {
            
            let url = BASE_URL
            return url + self.rawValue
        }
    }
}
