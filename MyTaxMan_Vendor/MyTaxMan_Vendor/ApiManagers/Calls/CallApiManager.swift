//
//  CallApiManager.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import Alamofire

enum CallsApi {
    case  callhistory
    case call_status_update
    
}

// MARK: - EndPointType
extension CallsApi: EndPointType {
    
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
        case .callhistory:
            return "/callhistory"
        case .call_status_update:
            return "/call_status_update"
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
        case .callhistory:
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

class CallApiManager {
    func callHistory(input: Parameters, handler: @escaping (_ result: CallHistoryBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: CallsApi.callhistory, params: input) { (result: CallHistoryBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func updateCallStatus(input: Parameters, handler: @escaping (_ result: DraftQuoteBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: CallsApi.call_status_update, params: input) { (result: DraftQuoteBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
}
