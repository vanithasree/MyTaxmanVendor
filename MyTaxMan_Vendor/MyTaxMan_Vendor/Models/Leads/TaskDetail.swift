//
//  TaskDetail.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation


struct TaskDetailsBase : Codable {
    let code : String?
    let desc : TaskDetailDesc?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case desc = "desc"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(TaskDetailDesc.self, forKey: .desc)
    }
    
}
struct TaskDetailDesc : Codable {
    let ilist : [Ilist]?
    
    enum CodingKeys: String, CodingKey {
        
        case ilist = "ilist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ilist = try values.decodeIfPresent([Ilist].self, forKey: .ilist)
    }
    
}
struct TaskDetailQuotes : Codable {
    let quote_status : String?
    let quoteid : String?

    enum CodingKeys: String, CodingKey {

        case quote_status = "quote_status"
        case quoteid = "quoteid"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
    }

}
struct Ilist : Codable {
    let taskid : String?
    let customerid : String?
    let category : String?
    let page1_title : String?
    let page1 : String?
    let page2_title : String?
    let page2 : String?
    let page3_title : String?
    let page3 : String?
    let page4_title : String?
    let page4 : String?
    let page5_title : String?
    let page5 : String?
    let page6_title : String?
    let page6 : String?
    let page7_title : String?
    let page7 : String?
    let description : String?
    let task_credits : String?
    let service_location : String?
    let lattitude : String?
    let longtitude : String?
    let task_status : String?
    let task_completed_on : String?
    let task_cancel_status : String?
    let cancel_description : String?
    let task_cancel_on : String?
    let task_submitted_on : String?
    let vendor_review : String?
    let vendor_review_givenon : String?
    let customername : String?
    let email : String?
    let mobile : String?
    let rmsg : [Rmsg]?
    let quotes : [TaskDetailQuotes]?
    
    enum CodingKeys: String, CodingKey {
        
        case taskid = "taskid"
        case customerid = "customerid"
        case category = "category"
        case page1_title = "page1_title"
        case page1 = "page1"
        case page2_title = "page2_title"
        case page2 = "page2"
        case page3_title = "page3_title"
        case page3 = "page3"
        case page4_title = "page4_title"
        case page4 = "page4"
        case page5_title = "page5_title"
        case page5 = "page5"
        case page6_title = "page6_title"
        case page6 = "page6"
        case page7_title = "page7_title"
        case page7 = "page7"
        case description = "description"
        case task_credits = "task_credits"
        case service_location = "service_location"
        case lattitude = "lattitude"
        case longtitude = "longtitude"
        case task_status = "task_status"
        case task_completed_on = "task_completed_on"
        case task_cancel_status = "task_cancel_status"
        case cancel_description = "cancel_description"
        case task_cancel_on = "task_cancel_on"
        case task_submitted_on = "task_submitted_on"
        case vendor_review = "vendor_review"
        case vendor_review_givenon = "vendor_review_givenon"
        case customername = "customername"
        case email = "email"
        case mobile = "mobile"
        case rmsg = "rmsg"
        case quotes = "quotes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        page1_title = try values.decodeIfPresent(String.self, forKey: .page1_title)
        page1 = try values.decodeIfPresent(String.self, forKey: .page1)
        page2_title = try values.decodeIfPresent(String.self, forKey: .page2_title)
        page2 = try values.decodeIfPresent(String.self, forKey: .page2)
        page3_title = try values.decodeIfPresent(String.self, forKey: .page3_title)
        page3 = try values.decodeIfPresent(String.self, forKey: .page3)
        page4_title = try values.decodeIfPresent(String.self, forKey: .page4_title)
        page4 = try values.decodeIfPresent(String.self, forKey: .page4)
        page5_title = try values.decodeIfPresent(String.self, forKey: .page5_title)
        page5 = try values.decodeIfPresent(String.self, forKey: .page5)
        page6_title = try values.decodeIfPresent(String.self, forKey: .page6_title)
        page6 = try values.decodeIfPresent(String.self, forKey: .page6)
        page7_title = try values.decodeIfPresent(String.self, forKey: .page7_title)
        page7 = try values.decodeIfPresent(String.self, forKey: .page7)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        task_credits = try values.decodeIfPresent(String.self, forKey: .task_credits)
        service_location = try values.decodeIfPresent(String.self, forKey: .service_location)
        lattitude = try values.decodeIfPresent(String.self, forKey: .lattitude)
        longtitude = try values.decodeIfPresent(String.self, forKey: .longtitude)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        task_completed_on = try values.decodeIfPresent(String.self, forKey: .task_completed_on)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        cancel_description = try values.decodeIfPresent(String.self, forKey: .cancel_description)
        task_cancel_on = try values.decodeIfPresent(String.self, forKey: .task_cancel_on)
        task_submitted_on = try values.decodeIfPresent(String.self, forKey: .task_submitted_on)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        rmsg = try values.decodeIfPresent([Rmsg].self, forKey: .rmsg)
        quotes = try values.decodeIfPresent([TaskDetailQuotes].self, forKey: .quotes)
    }
    
}

struct Rmsg : Codable {
    let received_quote_count : String?
    
    enum CodingKeys: String, CodingKey {
        
        case received_quote_count = "received_quote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        received_quote_count = try values.decodeIfPresent(String.self, forKey: .received_quote_count)
    }
    
}

