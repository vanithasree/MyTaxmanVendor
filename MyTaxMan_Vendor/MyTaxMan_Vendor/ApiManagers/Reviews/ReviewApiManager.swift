//
//  ReviewApiManager.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import Alamofire

enum ReviewsApi {
    case  ven_notreviewed
    case tech_review_list
    case ven_review_to_customer
    
}

// MARK: - EndPointType
extension ReviewsApi: EndPointType {
    
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
        case .ven_notreviewed:
            return "/ven_notreviewed"
        case .tech_review_list:
            return "/tech_review_list"
        case .ven_review_to_customer:
            return "/ven_review_to_customer"
            
            
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
        case .ven_notreviewed:
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

class ReviewsApiManager {
    func getNotReviewedList(input: Parameters, handler: @escaping (_ result: NotReviewedListBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ReviewsApi.ven_notreviewed, params: input) { (result: NotReviewedListBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func getReviewedList(input: Parameters, handler: @escaping (_ result: ReviewedListBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ReviewsApi.tech_review_list, params: input) { (result: ReviewedListBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func vendorReviewToCustomer(input: Parameters, handler: @escaping (_ result: DraftQuoteBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: ReviewsApi.ven_review_to_customer, params: input) { (result: DraftQuoteBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
}
