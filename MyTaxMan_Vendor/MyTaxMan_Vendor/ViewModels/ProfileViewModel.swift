//
//  ProfileViewModel.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 02/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ProfileViewModel {
    func getVendorProfile(input: Parameters, handler: @escaping (_ user: VenProfileBase?, _ error: AlertMessage?)->()) {
        ProfileApiManager().getVenProfileDetails(input: input, handler: handler)
    }
}
