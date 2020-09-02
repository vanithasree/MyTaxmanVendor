//
//  ProfileApiManager.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 02/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import Alamofire

enum ProfileApi {
    
    case  venprofile
}

// MARK: - EndPointType
extension ProfileApi: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .dev: return Constant.devURLBaseString
        case .production: return Constant.devURLBaseString
        case .stage: return Constant.devURLBaseString
        }
    }
    
    var version: String {
        return "/v0_1"
    }
    
    var path: String {
        switch self {
        case .venprofile:
            return "/venprofile"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            //        case .getAccount, .GetInfoByItemType, .getProfile: return .get
        //        case .updateUserProfile: return .put
        default:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .venprofile:
            return nil
            /*["Content-Type": "application/json",
             "X-Requested-With": "XMLHttpRequest",
             "x-access-token": "someToken"]*/
        default:
            return nil /* ["Content-Type": "application/json",
             "X-Requested-With": "XMLHttpRequest"]*/
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}
class ProfileApiManager {
    func getVenProfileDetails(input: Parameters, handler: @escaping (_ result: VenProfileBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ProfileApi.venprofile, params: input) { (result: VenProfileBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
}
