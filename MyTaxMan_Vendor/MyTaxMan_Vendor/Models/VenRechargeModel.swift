//
//  VenRechargeModel.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 04/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation

struct VenRechargeSuccessBase : Codable {
    let code : String?
    let payment_history : String?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case payment_history = "Payment_history"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        payment_history = try values.decodeIfPresent(String.self, forKey: .payment_history)
    }
    
}


struct VenPaymentHistoryBase : Codable {
    let code : String?
    let payment_ref_code : String?
    let payment_history : [Payment_history]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case payment_ref_code = "payment_ref_code"
        case payment_history = "Payment_history"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        payment_ref_code = try values.decodeIfPresent(String.self, forKey: .payment_ref_code)
        payment_history = try values.decodeIfPresent([Payment_history].self, forKey: .payment_history)
    }

}

struct Payment_history : Codable {
    let rechargeid : String?
    let vendorid : String?
    let amount : String?
    let date : String?
    let payment_access_id : String?

    enum CodingKeys: String, CodingKey {

        case rechargeid = "rechargeid"
        case vendorid = "vendorid"
        case amount = "amount"
        case date = "date"
        case payment_access_id = "payment_access_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rechargeid = try values.decodeIfPresent(String.self, forKey: .rechargeid)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        payment_access_id = try values.decodeIfPresent(String.self, forKey: .payment_access_id)
    }

}


struct VenCreditHistoryBase : Codable {
    let code : String?
    let credits_used_details : [Credits_used_details]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case credits_used_details = "Credits_used_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        credits_used_details = try values.decodeIfPresent([Credits_used_details].self, forKey: .credits_used_details)
    }

}

struct Credits_used_details : Codable {
    let customername : String?
    let category : String?
    let creditid : String?
    let vendorid : String?
    let taskid : String?
    let credits_used : String?
    let credits_status : String?
    let credits_taken_on : String?

    enum CodingKeys: String, CodingKey {

        case customername = "customername"
        case category = "category"
        case creditid = "creditid"
        case vendorid = "vendorid"
        case taskid = "taskid"
        case credits_used = "credits_used"
        case credits_status = "credits_status"
        case credits_taken_on = "credits_taken_on"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        creditid = try values.decodeIfPresent(String.self, forKey: .creditid)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        credits_used = try values.decodeIfPresent(String.self, forKey: .credits_used)
        credits_status = try values.decodeIfPresent(String.self, forKey: .credits_status)
        credits_taken_on = try values.decodeIfPresent(String.self, forKey: .credits_taken_on)
    }

}
