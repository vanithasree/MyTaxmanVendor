//
//  VenBusinessDetails.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 04/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation

struct VenBusinessDetailsBase : Codable {
    let code : String?
    let vendorbusinessdetails : [VendorBusinessDetails]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case vendorbusinessdetails = "Vendor business details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        vendorbusinessdetails = try values.decodeIfPresent([VendorBusinessDetails].self, forKey: .vendorbusinessdetails)
    }

}

struct VendorBusinessDetails : Codable {
    let business_name : String?
    let street_address : String?
    let location : String?
    let aBN : String?
    let website : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case business_name = "business_name"
        case street_address = "street_address"
        case location = "location"
        case aBN = "ABN"
        case website = "website"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        street_address = try values.decodeIfPresent(String.self, forKey: .street_address)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        aBN = try values.decodeIfPresent(String.self, forKey: .aBN)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
