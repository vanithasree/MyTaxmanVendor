//
//  ProfileHeaderTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 02/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var objectContainerView: UIView!
    @IBOutlet weak var jobsWonValueLabel: UILabel!
    @IBOutlet weak var jobsWonTitleLabel: UILabel!
    @IBOutlet weak var reviewsTitleLabel: UILabel!
    @IBOutlet weak var reviewsValueLabel: UILabel!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var featuredLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var creditsBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewCellUI()
    }
    func setupViewCellUI() {
        nameLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .center)
        featuredLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.textDarkGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .center)
        featuredLabel.backgroundColor = ColorManager.textVeryLiteGreenColor.color
        featuredLabel.cornerRadius = 7.5
        
        ratingTitleLabel.setLabelCustomProperties(titleText: "Avg rating", textColor: ColorManager.lightGrey.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 1, alignment: .center)
        
        ratingValueLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 1, alignment: .center)
        
        reviewsTitleLabel.setLabelCustomProperties(titleText: "Reviews", textColor: ColorManager.lightGrey.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 1, alignment: .center)
        
        reviewsValueLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 1, alignment: .center)
        
        jobsWonTitleLabel.setLabelCustomProperties(titleText: "Jobs won", textColor: ColorManager.lightGrey.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 1, alignment: .center)
        
        jobsWonValueLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 1, alignment: .center)
        
        profileImageView.cornerRadius = profileImageView.frame.width / 2
        
        
    }
    
    func setCellData(data: VenProfileBase?) {
        
        if let profilePic = data?.profile_pic, !profilePic.isEmpty {
            profileImageView.load(from: profilePic)
        }
        else {
            profileImageView.image = UIImage(named: "profile")
        }
        
        nameLabel.text = data?.desc?.first?.vendorname ?? ""
        if let featuredString = data?.featured, !featuredString.isEmpty, featuredString.lowercased() == "yes" {
            self.featuredLabel.text = "  Featured  "
        }
        else {
            self.featuredLabel.text = ""
        }
        
        self.ratingValueLabel.text = data?.averageRating?.first?.average_rating ?? "0"
        self.reviewsValueLabel.text = data?.reviewCount?.first?.review_count ?? "0"
        self.jobsWonValueLabel.text = data?.jobWon?.first?.jobwon_count ?? "0"
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
