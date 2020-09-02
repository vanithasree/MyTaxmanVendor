//
//  LeadsListTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class LeadsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quoteDescriptionLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setUpView() {
        nameLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(19.0)), numberOfLines: 1, alignment: .left)
        timeStampLabel.setLabelCustomProperties(titleText:"", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .right)
        addressLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(17.0)), numberOfLines: 0, alignment: .right)
        categoryLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(17.0)), numberOfLines: 0, alignment: .left)
        serviceTypeLabel.setLabelCustomProperties(titleText:"", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(17.0)), numberOfLines: 0, alignment: .left)
        creditsLabel.font = UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(17.0))
        quoteDescriptionLabel.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(17.0))
        
        
        quoteDescriptionLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        quoteDescriptionLabel.backgroundColor = ColorManager.textVeryLiteGreenColor.color
        quoteDescriptionLabel.cornerRadius = 5
        quoteDescriptionLabel.textColor = ColorManager.textThickDarkGreenColor.color
        
        //creditsLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .natural)
        //quoteDescriptionLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .natural)
    }
    
    func setCellDate(leadData : Leads) {
        nameLabel.text = leadData.customername ?? ""
        timeStampLabel.text = leadData.task_submitted_on ?? ""
        addressLabel.text = leadData.service_location ?? ""
        categoryLabel.text = leadData.category ?? ""
        serviceTypeLabel.text = "Service Type: \( leadData.page1 ?? "")"
        creditsLabel.text = "\( leadData.task_credits ?? "0") Credits"
        
        var descriptionText : String = "Be The First"
        if let taskIds = leadData.tasskid {
            if taskIds.count > 0 {
                switch taskIds.first?.received_quote_count {
                case "0":
                    descriptionText = "Be The First"
                case "1", "2":
                    descriptionText = "More Quotes Received"
                case "3":
                    descriptionText = "Get in Quick"
                    
                default:
                    break
                }
                
            }
        }
        quoteDescriptionLabel.text = descriptionText
        
        
        if let acceptedDate = leadData.task_submitted_on, !acceptedDate.isEmpty {
            
            let date = acceptedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
            let activityDate = "\(date?.toString(format: "dd MMM") ?? "")"
            timeStampLabel.text = activityDate
        }
        
    }
    
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell{
    func shadowAndBorderForCell() {
        // SHADOW AND BORDER FOR CELL
        //yourTableViewCell.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
}
