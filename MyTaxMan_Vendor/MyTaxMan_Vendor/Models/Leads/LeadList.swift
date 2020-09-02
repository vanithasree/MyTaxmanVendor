//
//  LeadList.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation


struct LeadsListBase : Codable {
    let code : String?
    let desc : Desc?
    let rows_per_page : Int?
    let previous_pagelink : String?
    let current_pagelink : String?
    let next_pagelink : String?
    let total_no_of_pages : Int?
    let total_rows : String?
    let current_page : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case desc = "desc"
        case rows_per_page = "rows_per_page"
        case previous_pagelink = "previous_pagelink"
        case current_pagelink = "current_pagelink"
        case next_pagelink = "next_pagelink"
        case total_no_of_pages = "total_no_of_pages"
        case total_rows = "total_rows"
        case current_page = "current_page"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(Desc.self, forKey: .desc)
        rows_per_page = try values.decodeIfPresent(Int.self, forKey: .rows_per_page)
        previous_pagelink = try values.decodeIfPresent(String.self, forKey: .previous_pagelink)
        current_pagelink = try values.decodeIfPresent(String.self, forKey: .current_pagelink)
        next_pagelink = try values.decodeIfPresent(String.self, forKey: .next_pagelink)
        total_no_of_pages = try values.decodeIfPresent(Int.self, forKey: .total_no_of_pages)
        total_rows = try values.decodeIfPresent(String.self, forKey: .total_rows)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
    }
    
}

struct Desc : Codable {
    let leads : [Leads]?
    
    enum CodingKeys: String, CodingKey {
        
        case leads = "leads"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        leads = try values.decodeIfPresent([Leads].self, forKey: .leads)
    }
    
}

struct Leads : Codable {
    let taskid : [Taskid]?
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
    let tasskid : [Tasskid]?
    let customername : String?
    let city : String?
    
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
        case tasskid = "tasskid"
        case customername = "customername"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        taskid = try values.decodeIfPresent([Taskid].self, forKey: .taskid)
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
        tasskid = try values.decodeIfPresent([Tasskid].self, forKey: .tasskid)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        city = try values.decodeIfPresent(String.self, forKey: .city)
    }
    
}

struct Taskid : Codable {
    let taskid : String?
    
    enum CodingKeys: String, CodingKey {
        
        case taskid = "taskid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
    }
    
}

struct Tasskid : Codable {
    let tasskid : String?
    let received_quote_count : String?
    
    enum CodingKeys: String, CodingKey {
        
        case tasskid = "tasskid"
        case received_quote_count = "received_quote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tasskid = try values.decodeIfPresent(String.self, forKey: .tasskid)
        received_quote_count = try values.decodeIfPresent(String.self, forKey: .received_quote_count)
    }
    
}

