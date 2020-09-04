//
//  VenContactDetails.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 04/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation

struct VenContactDetailsBase : Codable {
    let code : String?
    let desc : [VenContactDesc]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent([VenContactDesc].self, forKey: .desc)
    }

}


struct VenContactDesc : Codable {
    let vendorname : String?
    let email : String?
    let landline : String?
    let mobile_no : String?

    enum CodingKeys: String, CodingKey {

        case vendorname = "vendorname"
        case email = "email"
        case landline = "landline"
        case mobile_no = "mobile_no"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        landline = try values.decodeIfPresent(String.self, forKey: .landline)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
    }

}
