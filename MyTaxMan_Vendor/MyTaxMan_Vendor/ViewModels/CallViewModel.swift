//
//  CallViewModel.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CallViewModel {
    
    func callVendorCallHistory(input: Parameters, handler: @escaping (_ user: CallHistoryBase?, _ error: AlertMessage?)->()) {
        CallApiManager().callHistory(input: input, handler: handler)
    }
    func updateCallStatusToServer(input: Parameters, handler: @escaping (_ user: DraftQuoteBase?, _ error: AlertMessage?)->()) {
        CallApiManager().updateCallStatus(input: input, handler: handler)
    }
}
