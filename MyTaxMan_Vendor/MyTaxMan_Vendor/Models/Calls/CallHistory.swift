//
//  CallHistory.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation

struct CallHistoryBase : Codable {
    let code : String?
    let desc : CallHistoryDesc?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case desc = "desc"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(CallHistoryDesc.self, forKey: .desc)
    }
    
}
struct CallHistoryDesc : Codable {
    let ilist : [CallHistroyIlist]?
    
    enum CodingKeys: String, CodingKey {
        
        case ilist = "ilist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ilist = try values.decodeIfPresent([CallHistroyIlist].self, forKey: .ilist)
    }
    
}


struct CallHistroyIlist : Codable {
    let callid : String?
    let vendorid : String?
    let customerid : String?
    let taskid : String?
    let call_from : String?
    let duration : String?
    let called_on : String?
    let customername : String?
    let mobile : String?
    let city : String?
    let task_status : String?
    let service_location : String?
    let quoteid : String?
    let quote_status : String?
    let task_credits : String?
    let rmsg : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case callid = "callid"
        case vendorid = "vendorid"
        case customerid = "customerid"
        case taskid = "taskid"
        case call_from = "call_from"
        case duration = "duration"
        case called_on = "called_on"
        case customername = "customername"
        case mobile = "mobile"
        case city = "city"
        case task_status = "task_status"
        case service_location = "service_location"
        case quoteid = "quoteid"
        case quote_status = "quote_status"
        case task_credits = "task_credits"
        case rmsg = "rmsg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        callid = try values.decodeIfPresent(String.self, forKey: .callid)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        call_from = try values.decodeIfPresent(String.self, forKey: .call_from)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        called_on = try values.decodeIfPresent(String.self, forKey: .called_on)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        service_location = try values.decodeIfPresent(String.self, forKey: .service_location)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        task_credits = try values.decodeIfPresent(String.self, forKey: .task_credits)
        rmsg = try values.decodeIfPresent([String].self, forKey: .rmsg)
    }
    
}
