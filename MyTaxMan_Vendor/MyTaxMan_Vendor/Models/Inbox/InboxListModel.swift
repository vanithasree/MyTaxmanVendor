//
//  InboxListModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 04/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct InboxListBase : Codable {
    let code : String?
    let desc : [Inboxlist]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent([Inboxlist].self, forKey: .desc)
    }

}

struct Inboxlist : Codable {
    let more_information : String?
    let sent_on : String?
    let ignore_reason : String?
    let quoted_on : String?
    let star_given : String?
    let category : String?
    let vendorid : String?
    let cus_callid : String?
    let refund_reason : String?
    let refund_status : String?
    let seen_on : String?
    let ven_callid : String?
    let chat_image : String?
    let additional_comments : String?
    let cost_estimate_flat : String?
    let task_cancel_status : String?
    let chatid : String?
    let quoteid : String?
    let taskid : String?
    let city : String?
    let site_inspection : String?
    let quote_accepted_on : String?
    let cost_estimate_hourly : String?
    let reviewed_on : String?
    let vendorname : String?
    let review : String?
    let sent_by : String?
    let quote_status : String?
    let quote_callid : String?
    let cost_estimate_hourlyhours : String?
    let customerid : String?
    let customername : String?
    let message : String?
    let task_status : String?

    enum CodingKeys: String, CodingKey {

        case more_information = "more_information"
        case sent_on = "sent_on"
        case ignore_reason = "ignore_reason"
        case quoted_on = "quoted_on"
        case star_given = "star_given"
        case category = "category"
        case vendorid = "vendorid"
        case cus_callid = "cus_callid"
        case refund_reason = "refund_reason"
        case refund_status = "refund_status"
        case seen_on = "seen_on"
        case ven_callid = "ven_callid"
        case chat_image = "chat_image"
        case additional_comments = "additional_comments"
        case cost_estimate_flat = "cost_estimate_flat"
        case task_cancel_status = "task_cancel_status"
        case chatid = "chatid"
        case quoteid = "quoteid"
        case taskid = "taskid"
        case city = "city"
        case site_inspection = "site_inspection"
        case quote_accepted_on = "quote_accepted_on"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case reviewed_on = "reviewed_on"
        case vendorname = "vendorname"
        case review = "review"
        case sent_by = "sent_by"
        case quote_status = "quote_status"
        case quote_callid = "quote_callid"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case customerid = "customerid"
        case customername = "customername"
        case message = "message"
        case task_status = "task_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        sent_on = try values.decodeIfPresent(String.self, forKey: .sent_on)
        ignore_reason = try values.decodeIfPresent(String.self, forKey: .ignore_reason)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        star_given = try values.decodeIfPresent(String.self, forKey: .star_given)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        cus_callid = try values.decodeIfPresent(String.self, forKey: .cus_callid)
        refund_reason = try values.decodeIfPresent(String.self, forKey: .refund_reason)
        refund_status = try values.decodeIfPresent(String.self, forKey: .refund_status)
        seen_on = try values.decodeIfPresent(String.self, forKey: .seen_on)
        ven_callid = try values.decodeIfPresent(String.self, forKey: .ven_callid)
        chat_image = try values.decodeIfPresent(String.self, forKey: .chat_image)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        task_cancel_status = try values.decodeIfPresent(String.self, forKey: .task_cancel_status)
        chatid = try values.decodeIfPresent(String.self, forKey: .chatid)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        reviewed_on = try values.decodeIfPresent(String.self, forKey: .reviewed_on)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        sent_by = try values.decodeIfPresent(String.self, forKey: .sent_by)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        quote_callid = try values.decodeIfPresent(String.self, forKey: .quote_callid)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        task_status = try values.decodeIfPresent(String.self, forKey: .task_status)
    }

}
