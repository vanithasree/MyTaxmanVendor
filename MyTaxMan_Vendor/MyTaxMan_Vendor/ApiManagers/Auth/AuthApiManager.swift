//
//  AuthApiManager.swift
//  jps
//
//  Created by Kathiresan on 14/05/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import Alamofire

enum AuthApi {
    case venlogin
    case businessprofile
    case venforgotpassword
    case mobileemail_exist
    case ven_resend_otp
    case ven_otp_verification
}

// MARK: - EndPointType
extension AuthApi: EndPointType {
    
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
            
        case .venlogin:
            return "/venlogin"
        case .businessprofile:
            return "/businessprofile"
        case .venforgotpassword:
            return "/venforgotpassword"
        case .mobileemail_exist:
            return "/mobileemail_exist"
        case .ven_resend_otp:
            return "/ven_resend_otp"
        case .ven_otp_verification:
            return "/ven_otp_verification"
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
        case .venlogin:
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


class AuthApiManager {
    
    func requestLogIn(input: Parameters, handler: @escaping (_ result: LoginBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.venlogin, params: input) { (result: LoginBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestSignup(input: Parameters, handler: @escaping (_ result: RegisterBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.businessprofile, params: input) { (result: RegisterBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestOtpVerification(input: Parameters, handler: @escaping (_ result: LoginBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.ven_otp_verification, params: input) { (result: LoginBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func requestResendOtp(input: Parameters, handler: @escaping (_ result: OtpVerifyBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.ven_resend_otp, params: input) { (result: OtpVerifyBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestForgotPassword(input: Parameters, handler: @escaping (_ result: OtpVerifyBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: AuthApi.venforgotpassword, params: input) { (result: OtpVerifyBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    /*  func requestCheckMobile(input: Parameters, handler: @escaping (_ result: CheckMobile_Base?, _ error: AlertMessage?)->()) {
     APIManager.shared().call(type: AuthApi.mobileemail_exist, params: input) { (result: CheckMobile_Base?,message: AlertMessage?) in
     if let result = result {
     handler(result, nil)
     } else {
     handler(nil, message!)
     }
     }
     }
     
     
     */
    
}
