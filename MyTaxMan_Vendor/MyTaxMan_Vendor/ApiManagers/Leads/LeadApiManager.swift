//
//  LeadApiManager.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import Alamofire

enum LeadsApi {
    case  ven_leads_page_pagination
    case ven_lead_details
    case filter_leads
    case vensubmit_quote
    case ven_draft_quote
}


// MARK: - EndPointType
extension LeadsApi: EndPointType {
    
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
            
        case .ven_leads_page_pagination:
            return "/ven_leads_page_pagination_iOS?currentpage="
        case .ven_lead_details:
            return "/ven_lead_details"
        case .filter_leads:
            return "/filter_leads"
        case .vensubmit_quote:
            return "/vensubmit_quote"
        case .ven_draft_quote:
            return "/ven_draft_quote"
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
        case .ven_leads_page_pagination:
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

class LeadApiManager {
    
    func getTaskDetailList(input: Parameters, handler: @escaping (_ result: TaskDetailsBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: LeadsApi.ven_lead_details, params: input) { (result: TaskDetailsBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func submitQuote(input: Parameters, handler: @escaping (_ result: SubmitQuoteBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: LeadsApi.vensubmit_quote, params: input) { (result: SubmitQuoteBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func draftQuote(input: Parameters, handler: @escaping (_ result: DraftQuoteBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: LeadsApi.ven_draft_quote, params: input) { (result: DraftQuoteBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func getLeadsListFromFilterOption(lead pageNumber: String, input: Parameters, handler: @escaping (_ result: LeadsListBase?, _ error: AlertMessage?)->()) {
        
        APIManager.shared().call(type: LeadsApi.filter_leads, params: input) { (result: LeadsListBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func getLeadsListFromServer(lead pageNumber: String, input: Parameters, handler: @escaping (_ result: LeadsListBase?, _ error: AlertMessage?)->()) {
        
        APIManager.shared().call(type: LeadsApi.ven_leads_page_pagination, params: input) { (result: LeadsListBase?,message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
        
        /*  APIManager.shared().call(type: LeadsApi.ven_leads_page_pagination, urlInput: pageNumber, params: input) { (result: LeadsListBase?,message: AlertMessage?) in
         if let result = result {
         handler(result, nil)
         } else {
         handler(nil, message!)
         }
         }*/
    }
}
