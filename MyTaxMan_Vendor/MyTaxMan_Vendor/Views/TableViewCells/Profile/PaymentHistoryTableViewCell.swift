//
//  PaymentHistoryTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 04/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class PaymentHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var innerTitleBgView: UIView!
    @IBOutlet weak var mainBgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellViewUI()
    }
    func setCellViewUI() {
        innerTitleBgView.roundCorners(corners:[.topRight, .topLeft], radius: 20.0)
        mainBgView.layer.borderColor = UIColor.lightGray.cgColor
        mainBgView.layer.borderWidth = 0.7
        mainBgView.roundCorners(corners:[.topRight, .topLeft], radius: 20.0)
    
        
        headerTitleLabel.setLabelCustomProperties(titleText: "", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .left)
        categoryLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .left)
        
        creditsLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .right)
        
        timeStampLabel.setLabelCustomProperties(titleText: "", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 0, alignment: .left)
        
        statusLabel.setLabelCustomProperties(titleText: "", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 0, alignment: .right)
        
    }
    
    func setPaymentHistoryData(data : Payment_history) {
        self.headerTitleLabel.text = data.payment_access_id ?? ""
        self.timeStampLabel.text = ""
        self.statusLabel.text = ""
        
        if let acceptedDate = data.date, !acceptedDate.isEmpty {
            
            let date = acceptedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
            let activityDate = "\(date?.toString(format: "dd MMM yyyy") ?? "")"
            self.categoryLabel.text = activityDate
        }
        
        self.creditsLabel.text = data.amount ?? ""
    }
    
    func setCreditHistoryData(data : Credits_used_details) {
        self.headerTitleLabel.text = data.customername ?? ""
        self.categoryLabel.text = data.category ?? ""
        self.creditsLabel.text = "\(data.credits_used ?? "0") Credits"
        if let acceptedDate = data.credits_taken_on, !acceptedDate.isEmpty {
            
            let date = acceptedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
            let activityDate = "\(date?.toString(format: "dd MMM yyyy") ?? "")"
            self.timeStampLabel.text = activityDate
        }
        self.statusLabel.text = data.credits_status ?? ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
