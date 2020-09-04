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
    case ven_businessdetails_update
    case ven_contactdetails_update
    case ven_recharge_success
    case ven_payment_history
    case ven_credit_history
    case ven_servicetype_update
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
        case .ven_businessdetails_update:
            return "/ven_businessdetails_update"
        case .ven_contactdetails_update:
            return "/ven_contactdetails_update"
        case .ven_recharge_success:
            return "/ven_recharge_success"
        case .ven_payment_history:
            return "/ven_payment_history"
        case .ven_credit_history:
            return "/ven_credit_history"
        case .ven_servicetype_update:
            return "/ven_servicetype_update"
            
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
    func updateBusinessProfile(input: Parameters, handler: @escaping (_ result: VenBusinessDetailsBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ProfileApi.ven_businessdetails_update, params: input) { (result: VenBusinessDetailsBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func updateContactDetails(input: Parameters, handler: @escaping (_ result: VenContactDetailsBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ProfileApi.ven_contactdetails_update, params: input) { (result: VenContactDetailsBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func doVendorRecharge(input: Parameters, handler: @escaping (_ result: VenRechargeSuccessBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ProfileApi.ven_recharge_success, params: input) { (result: VenRechargeSuccessBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func getPaymentHistory(input: Parameters, handler: @escaping (_ result: VenPaymentHistoryBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ProfileApi.ven_payment_history, params: input) { (result: VenPaymentHistoryBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func getCreditHistory(input: Parameters, handler: @escaping (_ result: VenCreditHistoryBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ProfileApi.ven_credit_history, params: input) { (result: VenCreditHistoryBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func updateServiceType(input: Parameters, handler: @escaping (_ result: DraftQuoteBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ProfileApi.ven_servicetype_update, params: input) { (result: DraftQuoteBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
}
