//
//  JobStatusTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Prem kumar on 03/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class JobStatusTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    func setupViews(){
        titleLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0))
        titleLabel.numberOfLines = 0
        
        subTitleLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
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
    
    func setJobStatusValue(data : Inboxlist?, index: Int){
        titleLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0))
        titleLabel.text = "Job Status"
        var quote_status = ""
        switch data?.quote_status ?? "" {
        case "0":
            quote_status = "Quoted"
            break
        case "1":
            quote_status = "Mark as won"
            break
        case "2":
            quote_status = "Declined"
            break
        case "3":
            quote_status = "Expired"
            break
        case "4":
            if data?.task_status ?? "" == "0"{
                quote_status = "Marked as won"
            }else if data?.task_status ?? "" == "1"{
                quote_status = "Won"
            }
            break
        case "5":
            quote_status = "Drafted"
            break
        case "6":
            quote_status = "Ignored"
            break
        default:
            break
        }
        subTitleLabel.text = " \(quote_status) "
        subTitleLabel.layer.borderWidth = 1
        subTitleLabel.layer.borderColor = ColorManager.darkTheme.color.cgColor
        subTitleLabel.cornerRadius = 3
    }
    
    func setContactValue(vendorProfile : VendorLeadDetails_Desc?, index: Int){
        var title = ""
        var value = ""
        switch index {
        case 0:
            title = "Mobile Number"
            value = vendorProfile?.ilist?.first?.mobile ?? ""
            value = ValidationManager().hideMidCharsInMobileString(value)
            break
        case 1:
            title = "Email Address"
            value =  vendorProfile?.ilist?.first?.email ?? ""
            let components = value.components(separatedBy: "@")
            value = ValidationManager().hideMidChars(components.first ?? "") + "@" + (components.last ?? "")
            break
        default:
            break
        }
        
        subTitleLabel.text = " Verified "
        subTitleLabel.layer.borderWidth = 1
        subTitleLabel.layer.borderColor = ColorManager.darkTheme.color.cgColor
        subTitleLabel.cornerRadius = 3
        
        titleLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
        titleLabel.text = "\(title)\n\(value)"
        
        let balanceAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: titleLabel.text ?? "")
        balanceAttributedString.setColorForText(textForAttribute: "\(title)", withColor: ColorManager.lightGrey.color, withFont: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))!)
        balanceAttributedString.setLineSpaceForText(lineSpace: 3, alignment: titleLabel.textAlignment)
        titleLabel.attributedText = balanceAttributedString
        
    }
}
