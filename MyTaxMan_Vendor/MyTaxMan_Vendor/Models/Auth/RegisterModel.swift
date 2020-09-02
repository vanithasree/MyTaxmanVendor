//
//  RegisterModel.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import UIKit

struct RegisterBase : Codable {
    let code : String?
    let desc : String?
    let businessid : [Businessid]?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case desc = "desc"
        case businessid = "businessid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        businessid = try values.decodeIfPresent([Businessid].self, forKey: .businessid)
    }
    
}
struct Businessid : Codable {
    let vendorid : String?
    let ven_callid : String?
    let device_token : String?
    let vendorname : String?
    let mobile_no : String?
    let otp_verified : String?
    let otp : String?
    let landline : String?
    let email : String?
    let password : String?
    let business_name : String?
    let aBN : String?
    let street_address : String?
    let location : String?
    let website : String?
    let description : String?
    let service_types : String?
    let service_areas : String?
    let new_job_lead_notification : String?
    let message_notification : String?
    let quotes_notification : String?
    let daily_summary_notification : String?
    let newsletter_notification : String?
    let timezone : String?
    let wallet_balance : String?
    let call_availability_start : String?
    let call_availability_end : String?
    let do_not_distrub : String?
    let location_setting_allowed : String?
    let microphone_setting_allowed : String?
    let password_updated_on : String?
    let last_login : String?
    let registered_on : String?
    let deviceid : String?
    let profile_pic : String?
    let portfolio1 : String?
    let portfolio2 : String?
    let portfolio3 : String?
    let portfolio4 : String?
    let portfolio5 : String?
    let portfolio6 : String?
    let portfolio7 : String?
    let portfolio8 : String?
    let portfolio9 : String?
    let portfolio10 : String?
    let portfolio11 : String?
    let portfolio12 : String?
    let portfolio13 : String?
    let portfolio14 : String?
    let portfolio15 : String?
    let insurance_doc : String?
    let insurance_doc_verified : String?
    let featured : String?
    
    enum CodingKeys: String, CodingKey {
        
        case vendorid = "vendorid"
        case ven_callid = "ven_callid"
        case device_token = "device_token"
        case vendorname = "vendorname"
        case mobile_no = "mobile_no"
        case otp_verified = "otp_verified"
        case otp = "otp"
        case landline = "landline"
        case email = "email"
        case password = "password"
        case business_name = "business_name"
        case aBN = "ABN"
        case street_address = "street_address"
        case location = "location"
        case website = "website"
        case description = "description"
        case service_types = "service_types"
        case service_areas = "service_areas"
        case new_job_lead_notification = "new_job_lead_notification"
        case message_notification = "message_notification"
        case quotes_notification = "quotes_notification"
        case daily_summary_notification = "daily_summary_notification"
        case newsletter_notification = "newsletter_notification"
        case timezone = "timezone"
        case wallet_balance = "wallet_balance"
        case call_availability_start = "call_availability_start"
        case call_availability_end = "call_availability_end"
        case do_not_distrub = "do_not_distrub"
        case location_setting_allowed = "location_setting_allowed"
        case microphone_setting_allowed = "microphone_setting_allowed"
        case password_updated_on = "password_updated_on"
        case last_login = "last_login"
        case registered_on = "registered_on"
        case deviceid = "deviceid"
        case profile_pic = "profile_pic"
        case portfolio1 = "portfolio1"
        case portfolio2 = "portfolio2"
        case portfolio3 = "portfolio3"
        case portfolio4 = "portfolio4"
        case portfolio5 = "portfolio5"
        case portfolio6 = "portfolio6"
        case portfolio7 = "portfolio7"
        case portfolio8 = "portfolio8"
        case portfolio9 = "portfolio9"
        case portfolio10 = "portfolio10"
        case portfolio11 = "portfolio11"
        case portfolio12 = "portfolio12"
        case portfolio13 = "portfolio13"
        case portfolio14 = "portfolio14"
        case portfolio15 = "portfolio15"
        case insurance_doc = "insurance_doc"
        case insurance_doc_verified = "insurance_doc_verified"
        case featured = "featured"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        ven_callid = try values.decodeIfPresent(String.self, forKey: .ven_callid)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        otp_verified = try values.decodeIfPresent(String.self, forKey: .otp_verified)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        landline = try values.decodeIfPresent(String.self, forKey: .landline)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        aBN = try values.decodeIfPresent(String.self, forKey: .aBN)
        street_address = try values.decodeIfPresent(String.self, forKey: .street_address)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        service_types = try values.decodeIfPresent(String.self, forKey: .service_types)
        service_areas = try values.decodeIfPresent(String.self, forKey: .service_areas)
        new_job_lead_notification = try values.decodeIfPresent(String.self, forKey: .new_job_lead_notification)
        message_notification = try values.decodeIfPresent(String.self, forKey: .message_notification)
        quotes_notification = try values.decodeIfPresent(String.self, forKey: .quotes_notification)
        daily_summary_notification = try values.decodeIfPresent(String.self, forKey: .daily_summary_notification)
        newsletter_notification = try values.decodeIfPresent(String.self, forKey: .newsletter_notification)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        wallet_balance = try values.decodeIfPresent(String.self, forKey: .wallet_balance)
        call_availability_start = try values.decodeIfPresent(String.self, forKey: .call_availability_start)
        call_availability_end = try values.decodeIfPresent(String.self, forKey: .call_availability_end)
        do_not_distrub = try values.decodeIfPresent(String.self, forKey: .do_not_distrub)
        location_setting_allowed = try values.decodeIfPresent(String.self, forKey: .location_setting_allowed)
        microphone_setting_allowed = try values.decodeIfPresent(String.self, forKey: .microphone_setting_allowed)
        password_updated_on = try values.decodeIfPresent(String.self, forKey: .password_updated_on)
        last_login = try values.decodeIfPresent(String.self, forKey: .last_login)
        registered_on = try values.decodeIfPresent(String.self, forKey: .registered_on)
        deviceid = try values.decodeIfPresent(String.self, forKey: .deviceid)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        portfolio1 = try values.decodeIfPresent(String.self, forKey: .portfolio1)
        portfolio2 = try values.decodeIfPresent(String.self, forKey: .portfolio2)
        portfolio3 = try values.decodeIfPresent(String.self, forKey: .portfolio3)
        portfolio4 = try values.decodeIfPresent(String.self, forKey: .portfolio4)
        portfolio5 = try values.decodeIfPresent(String.self, forKey: .portfolio5)
        portfolio6 = try values.decodeIfPresent(String.self, forKey: .portfolio6)
        portfolio7 = try values.decodeIfPresent(String.self, forKey: .portfolio7)
        portfolio8 = try values.decodeIfPresent(String.self, forKey: .portfolio8)
        portfolio9 = try values.decodeIfPresent(String.self, forKey: .portfolio9)
        portfolio10 = try values.decodeIfPresent(String.self, forKey: .portfolio10)
        portfolio11 = try values.decodeIfPresent(String.self, forKey: .portfolio11)
        portfolio12 = try values.decodeIfPresent(String.self, forKey: .portfolio12)
        portfolio13 = try values.decodeIfPresent(String.self, forKey: .portfolio13)
        portfolio14 = try values.decodeIfPresent(String.self, forKey: .portfolio14)
        portfolio15 = try values.decodeIfPresent(String.self, forKey: .portfolio15)
        insurance_doc = try values.decodeIfPresent(String.self, forKey: .insurance_doc)
        insurance_doc_verified = try values.decodeIfPresent(String.self, forKey: .insurance_doc_verified)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
    }
    
}


struct OtpVerifyBase : Codable {
    let desc : String?
    let code : String?
 
    
    enum CodingKeys: String, CodingKey {
        
        case desc = "desc"
        case code = "code"
      
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        code = try values.decodeIfPresent(String.self, forKey: .code)
 
    }
}
