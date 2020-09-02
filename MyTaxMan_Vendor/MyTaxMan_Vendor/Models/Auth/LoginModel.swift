//
//  LoginModel.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 23/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct LoginBase : Codable {
    let code : String?
    let desc : String?
    let vendorid : String?
    let vencallid : String?
    let device_token : String?
    let vendorname : String?
    let services_offered : String?
    let services_areas : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case desc = "desc"
        case vendorid = "vendorid"
        case vencallid = "vencallid"
        case device_token = "device_token"
        case vendorname = "vendorname"
        case services_offered = "services_offered"
        case services_areas = "services_areas"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        vencallid = try values.decodeIfPresent(String.self, forKey: .vencallid)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        vendorname = try values.decodeIfPresent(String.self, forKey: .vendorname)
        services_offered = try values.decodeIfPresent(String.self, forKey: .services_offered)
        services_areas = try values.decodeIfPresent(String.self, forKey: .services_areas)
    }

}
