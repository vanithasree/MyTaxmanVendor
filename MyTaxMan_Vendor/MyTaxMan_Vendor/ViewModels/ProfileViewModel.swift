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
    func updateBusinessProfileDetails(input: Parameters, handler: @escaping (_ user: VenBusinessDetailsBase?, _ error: AlertMessage?)->()) {
        ProfileApiManager().updateBusinessProfile(input: input, handler: handler)
    }
    func updateVendorContactDetails(input: Parameters, handler: @escaping (_ user: VenContactDetailsBase?, _ error: AlertMessage?)->()) {
        ProfileApiManager().updateContactDetails(input: input, handler: handler)
    }
    func rechargeVendorWallet(input: Parameters, handler: @escaping (_ user: VenRechargeSuccessBase?, _ error: AlertMessage?)->()) {
        ProfileApiManager().doVendorRecharge(input: input, handler: handler)
    }
    func getPaymentHistoryDetails(input: Parameters, handler: @escaping (_ user: VenPaymentHistoryBase?, _ error: AlertMessage?)->()) {
        ProfileApiManager().getPaymentHistory(input: input, handler: handler)
    }
    func getCreditHistoryDetails(input: Parameters, handler: @escaping (_ user: VenCreditHistoryBase?, _ error: AlertMessage?)->()) {
        ProfileApiManager().getCreditHistory(input: input, handler: handler)
    }
    func updateServiceTypes(input: Parameters, handler: @escaping (_ user: DraftQuoteBase?, _ error: AlertMessage?)->()) {
        ProfileApiManager().updateServiceType(input: input, handler: handler)
    }
}
