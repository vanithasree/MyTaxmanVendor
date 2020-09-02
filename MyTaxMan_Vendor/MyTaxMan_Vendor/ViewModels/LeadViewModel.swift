//
//  LeadViewModel.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LeadViewModel {
    func getLeadsList(pageNumber:String, input: Parameters, handler: @escaping (_ user: LeadsListBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().getLeadsListFromServer(lead: pageNumber, input: input, handler: handler)
    }
    func getLeadsListByFilter(pageNumber:String, input: Parameters, handler: @escaping (_ user: LeadsListBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().getLeadsListFromFilterOption(lead: pageNumber, input: input, handler: handler)
    }
    func doSubmitQuote(input: Parameters, handler: @escaping (_ user: SubmitQuoteBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().submitQuote(input: input, handler: handler)
    }
    func doDraftQuote(input: Parameters, handler: @escaping (_ user: DraftQuoteBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().draftQuote(input: input, handler: handler)
    }
    
    
    func getTaskDetailsListFromServer(input: Parameters, handler: @escaping (_ user: TaskDetailsBase?, _ error: AlertMessage?)->()) {
        LeadApiManager().getTaskDetailList(input: input, handler: handler)
    }
}
