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
    
    func setJobStatusValue(vendorProfile : VendorProfile_Base?, index: Int){
        titleLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0))
        titleLabel.text = "Job Status"
        subTitleLabel.text = " won "
        subTitleLabel.layer.borderWidth = 1
        subTitleLabel.layer.borderColor = ColorManager.darkTheme.color.cgColor
        subTitleLabel.cornerRadius = 3
    }
    
    func setContactValue(vendorProfile : VendorProfile_Base?, index: Int){
        var title = ""
        var value = ""
        switch index {
        case 0:
            title = "Mobile Number"
            value = vendorProfile?.desc?.first?.mobile_no ?? ""
            break
        case 1:
            title = "Email Address"
            value = vendorProfile?.desc?.first?.mobile_no ?? ""
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
