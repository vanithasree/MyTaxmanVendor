//
//  ReviewViewModel.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import Alamofire

class ReviewViewModel {
    func getNotReviewedListFromServer(input: Parameters, handler: @escaping (_ user: NotReviewedListBase?, _ error: AlertMessage?)->()) {
        ReviewsApiManager().getNotReviewedList(input: input, handler: handler)
    }
    func getReviewedListFromServer(input: Parameters, handler: @escaping (_ user: ReviewedListBase?, _ error: AlertMessage?)->()) {
        ReviewsApiManager().getReviewedList(input: input, handler: handler)
    }
    func giveReviews(input: Parameters, handler: @escaping (_ user: DraftQuoteBase?, _ error: AlertMessage?)->()) {
        ReviewsApiManager().vendorReviewToCustomer(input: input, handler: handler)
    }
}

