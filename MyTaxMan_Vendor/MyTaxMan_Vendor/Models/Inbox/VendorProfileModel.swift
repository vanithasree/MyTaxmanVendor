//
//  VendorProfileModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 04/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct VendorLeadDetails_Base : Codable{
    let desc : VendorLeadDetails_Desc?
    let code : String?

    enum CodingKeys: String, CodingKey {

        case desc = "desc"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent(VendorLeadDetails_Desc.self, forKey: .desc)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }

}

struct VendorLeadDetails_Desc : Codable {
    let ilist : [Lead_Ilist]?

    enum CodingKeys: String, CodingKey {

        case ilist = "ilist"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ilist = try values.decodeIfPresent([Lead_Ilist].self, forKey: .ilist)
    }

}

struct Lead_Ilist : Codable {
    let task_submitted_on : String?
    let customername : String?
    let task_credits : String?
    let page3 : String?
    let page7_title : String?
    let category : String?
    let page1 : String?
    let page6_title : String?
    let cancel_description : String?
    let vendor_review_givenon : String?
    let quotes : [Quotes]?
    let page5_title : String?
    let longtitude : String?
    let page4_title : String?
    let description : String?
    let page3_title : String?
    let page2_title : String?
    let page1_title : String?
    let page6 : String?
    let email : String?
    let lattitude : String?
    let task_cancel_status : String?
    let page4 : String?
    let task_completed_on : String?
    let rmsg : [Rmsg]?
    let page2 : String?
    let taskid : String?
    let service_location : String?
    let mobile : String?
    let vendor_review : String?
    let page7 : String?
    let customerid : String?
    let task_status : String?
    let page5 : String?
    let task_cancel_on : String?

    enum CodingKeys: String, CodingKey {

        case task_submitted_on = "task_submitted_on"
        case customername = "customername"
        case task_credits = "task_credits"
        case page3 = "page3"
        case page7_title = "page7_title"
        case category = "category"
        case page1 = "page1"
        case page6_title = "page6_title"
        case cancel_description = "cancel_description"
        case vendor_review_givenon = "vendor_review_givenon"
        case quotes = "quotes"
        case page5_title = "page5_title"
        case longtitude = "longtitude"
        case page4_title = "page4_title"
        case description = "description"
        case page3_title = "page3_title"
        case page2_title = "page2_title"
        case page1_title = "page1_title"
        case page6 = "page6"
        case email = "email"
        case lattitude = "lattitude"
        case task_cancel_status = "task_cancel_status"
        case page4 = "page4"
        case task_completed_on = "task_completed_on"
        case rmsg = "rmsg"
        case page2 = "page2"
        case taskid = "taskid"
        case service_location = "service_location"
        case mobile = "mobile"
        case vendor_review = "vendor_review"
        case page7 = "page7"
        case customerid = "customerid"
        case task_status = "task_status"
        case page5 = "page5"
        case task_cancel_on = "task_cancel_on"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        task_submitted_on = try values.decodeIfPresent(String.self, forKey: .task_submitted_on)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        task_credits = try values.decodeIfPresent(String.self, forKey: .task_credits)
        page3 = try values.decodeIfPresent(String.self, forKey: .page3)
        page7_title = try values.decodeIfPresent(String.self, forKey: .page7_title)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        page1 = try values.decodeIfPresent(String.self, forKey: .page1)
        page6_title = try values.decodeIfPresent(String.self, forKey: .page6_title)
        cancel_description = try values.decodeIfPresent(String.self, forKey: .cancel_description)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)
        quotes = try values.decodeIfPresent([Quotes].self, forKey: .quotes)
        page5_title = try values.decodeIfPresent(String.self, forKey: .page5_title)
        longtitude = try values.decodeIfPresent(String.self, forKey: .longtitude)
        page4_title = try values.decodeIfPresent(String.self, forKey: .page4_title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        page3_title = try values.decodeIfPresent(String.self, forKey: .page3_title)
        page2_title = try values.decodeIfPresent(String.self, forKey: .page2_title)
        page1_title = try values.decodeIfPresent(String.self, forKey: .page1_title)
        page6 = try values.decodeIfPresent(String.self, forKey: .page6)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        lattitude = try values.decodeIfPresent(String.self, forKey: .lattitude)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        page4 = try values.decodeIfPresent(String.self, forKey: .page4)
        task_completed_on = try values.decodeIfPresent(String.self, forKey: .task_completed_on)
        rmsg = try values.decodeIfPresent([Rmsg].self, forKey: .rmsg)
        page2 = try values.decodeIfPresent(String.self, forKey: .page2)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        service_location = try values.decodeIfPresent(String.self, forKey: .service_location)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        page7 = try values.decodeIfPresent(String.self, forKey: .page7)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
        page5 = try values.decodeIfPresent(String.self, forKey: .page5)
        task_cancel_on = try values.decodeIfPresent(String.self, forKey: .task_cancel_on)
    }

}

struct Quotes : Codable {
    let quoteid : String?
    let quote_status : String?

    enum CodingKeys: String, CodingKey {

        case quoteid = "quoteid"
        case quote_status = "quote_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
    }

}
