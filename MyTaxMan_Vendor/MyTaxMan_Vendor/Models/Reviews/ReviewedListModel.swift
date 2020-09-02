//
//  ReviewedListModel.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation

struct ReviewedListBase : Codable {
    let code : String?
    let desc : [ReviewListDesc]?
    let reviewcount : [Reviewcount]?
    let avg_rating : [Avg_rating]?
    let job_won_count : [Job_won_count]?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case desc = "desc"
        case reviewcount = "reviewcount"
        case avg_rating = "avg_rating"
        case job_won_count = "job_won_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        desc = try values.decodeIfPresent([ReviewListDesc].self, forKey: .desc)
        reviewcount = try values.decodeIfPresent([Reviewcount].self, forKey: .reviewcount)
        avg_rating = try values.decodeIfPresent([Avg_rating].self, forKey: .avg_rating)
        job_won_count = try values.decodeIfPresent([Job_won_count].self, forKey: .job_won_count)
    }
    
}

struct Avg_rating : Codable {
    let review_count : String?
    
    enum CodingKeys: String, CodingKey {
        
        case review_count = "review_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        review_count = try values.decodeIfPresent(String.self, forKey: .review_count)
    }
    
}

struct Job_won_count : Codable {
    let jobwon_count : String?
    
    enum CodingKeys: String, CodingKey {
        
        case jobwon_count = "jobwon_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobwon_count = try values.decodeIfPresent(String.self, forKey: .jobwon_count)
    }
    
}

struct Reviewcount : Codable {
    let review_count : String?
    
    enum CodingKeys: String, CodingKey {
        
        case review_count = "review_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        review_count = try values.decodeIfPresent(String.self, forKey: .review_count)
    }
    
}

struct ReviewListDesc : Codable {
    let vendor_review : String?
    let vendor_review_givenon : String?
    let customername : String?
    let city : String?
    let quoteid : String?
    let customerid : String?
    let vendorid : String?
    let taskid : String?
    let cost_estimate_flat : String?
    let cost_estimate_hourly : String?
    let cost_estimate_hourlyhours : String?
    let site_inspection : String?
    let more_information : String?
    let additional_comments : String?
    let ignore_reason : String?
    let quoted_on : String?
    let quote_status : String?
    let quote_accepted_on : String?
    let review : String?
    let star_given : String?
    let reviewed_on : String?
    let quote_callid : String?
    
    enum CodingKeys: String, CodingKey {
        
        case vendor_review = "vendor_review"
        case vendor_review_givenon = "vendor_review_givenon"
        case customername = "customername"
        case city = "city"
        case quoteid = "quoteid"
        case customerid = "customerid"
        case vendorid = "vendorid"
        case taskid = "taskid"
        case cost_estimate_flat = "cost_estimate_flat"
        case cost_estimate_hourly = "cost_estimate_hourly"
        case cost_estimate_hourlyhours = "cost_estimate_hourlyhours"
        case site_inspection = "site_inspection"
        case more_information = "more_information"
        case additional_comments = "additional_comments"
        case ignore_reason = "ignore_reason"
        case quoted_on = "quoted_on"
        case quote_status = "quote_status"
        case quote_accepted_on = "quote_accepted_on"
        case review = "review"
        case star_given = "star_given"
        case reviewed_on = "reviewed_on"
        case quote_callid = "quote_callid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vendor_review = try values.decodeIfPresent(String.self, forKey: .vendor_review)
        vendor_review_givenon = try values.decodeIfPresent(String.self, forKey: .vendor_review_givenon)
        customername = try values.decodeIfPresent(String.self, forKey: .customername)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        quoteid = try values.decodeIfPresent(String.self, forKey: .quoteid)
        customerid = try values.decodeIfPresent(String.self, forKey: .customerid)
        vendorid = try values.decodeIfPresent(String.self, forKey: .vendorid)
        taskid = try values.decodeIfPresent(String.self, forKey: .taskid)
        cost_estimate_flat = try values.decodeIfPresent(String.self, forKey: .cost_estimate_flat)
        cost_estimate_hourly = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourly)
        cost_estimate_hourlyhours = try values.decodeIfPresent(String.self, forKey: .cost_estimate_hourlyhours)
        site_inspection = try values.decodeIfPresent(String.self, forKey: .site_inspection)
        more_information = try values.decodeIfPresent(String.self, forKey: .more_information)
        additional_comments = try values.decodeIfPresent(String.self, forKey: .additional_comments)
        ignore_reason = try values.decodeIfPresent(String.self, forKey: .ignore_reason)
        quoted_on = try values.decodeIfPresent(String.self, forKey: .quoted_on)
        quote_status = try values.decodeIfPresent(String.self, forKey: .quote_status)
        quote_accepted_on = try values.decodeIfPresent(String.self, forKey: .quote_accepted_on)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        star_given = try values.decodeIfPresent(String.self, forKey: .star_given)
        reviewed_on = try values.decodeIfPresent(String.self, forKey: .reviewed_on)
        quote_callid = try values.decodeIfPresent(String.self, forKey: .quote_callid)
    }
    
}

