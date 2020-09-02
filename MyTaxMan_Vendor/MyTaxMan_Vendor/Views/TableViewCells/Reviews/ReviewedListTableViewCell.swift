//
//  ReviewedListTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import FloatRatingView

class ReviewedListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var objectContainerView: UIView!
    
    var sendAReplyAction : (() ->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewUI()
    }
    func setupViewUI() {
        statusImageView.backgroundColor = ColorManager.textThickDarkGreenColor.color
        statusImageView.cornerRadius = 7.5
        
        objectContainerView.cornerRadius = 7.5
        objectContainerView.layer.borderWidth = 0.8
        objectContainerView.layer.borderColor = ColorManager.lightGrey.color.cgColor
        
        nameLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        dateLabel.setLabelCustomProperties(titleText: "", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 1, alignment: .right)
        
        reviewLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 1, alignment: .left)
        reviewLabel.backgroundColor = .clear
        
        
        statusLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15)), numberOfLines: 0, alignment: .center)
        statusLabel.cornerRadius = 5.0
        statusLabel.backgroundColor = ColorManager.textVeryLiteGreenColor.color
        
        replyBtn.setButtonProperties(title: "Send a reply", font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15)), titleColor: ColorManager.textDarkGreenColor.color)
        
    }
    

    
    func setCellData(data: ReviewListDesc) {
        
        self.nameLabel.text = data.customername ?? ""
        self.statusLabel.text = "  Won  "
        self.ratingView.rating =  Double(data.star_given ?? "0")!
        self.reviewLabel.text = data.review ?? ""
        
        if let reviewedDate = data.reviewed_on, !reviewedDate.isEmpty {
            
            let date = reviewedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
            let activityDate = "\(date?.toString(format: "dd MMM yyyy") ?? "")"
            self.dateLabel.text = activityDate
        }
    }
    
    
    
    @IBAction func onTapReplyBtn(_ sender: UIButton) {
        sendAReplyAction?()
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
