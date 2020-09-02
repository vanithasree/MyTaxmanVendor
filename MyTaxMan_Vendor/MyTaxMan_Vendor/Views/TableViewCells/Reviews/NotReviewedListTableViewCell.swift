//
//  NotReviewedListTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 01/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class NotReviewedListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var objectContainerView: UIView!
    
    @IBOutlet weak var jobDetailsBtn: UIButton!
    @IBOutlet weak var requestedBtn: UIButton!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLbel: UILabel!
    
     var jobDetailsAction : (() ->Void)?
    
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setViewCellUI()
    }
    func setViewCellUI() {
        objectContainerView.cornerRadius = 7.5
        objectContainerView.layer.borderWidth = 0.8
        objectContainerView.backgroundColor = .white
        objectContainerView.layer.borderColor = ColorManager.lightGrey.color.cgColor
        
        nameLbel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        addressLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        categoryLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        timeStampLabel.setLabelCustomProperties(titleText: "", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .right)
        
        requestedBtn.setButtonProperties(title: "REQUESTED", font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), titleColor: ColorManager.darkGrey.color)
        requestedBtn.cornerRadius  = 5.0
        requestedBtn.layer.borderWidth = 1.0
        requestedBtn.layer.borderColor = ColorManager.darkGrey.color.cgColor
        requestedBtn.backgroundColor = ColorManager.backgroundGrey.color
        
        jobDetailsBtn.setButtonProperties(title: "VIEW JOB DETAILS", font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), titleColor: ColorManager.darkGrey.color)
        jobDetailsBtn.cornerRadius  = 5.0
        jobDetailsBtn.layer.borderWidth = 1.0
        jobDetailsBtn.layer.borderColor = ColorManager.darkGrey.color.cgColor
        jobDetailsBtn.backgroundColor = ColorManager.white.color
        
    }
    
    func setCellData(data : NotReviewedList) {
        self.nameLbel.text = data.customername ?? ""
        self.addressLabel.text = data.service_location ?? ""
        self.categoryLabel.text = data.category ?? ""
        
        if let reviewedDate = data.quote_accepted_on, !reviewedDate.isEmpty {
            
            let date = reviewedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
            let activityDate = "\(date?.toString(format: "dd MMM yyyy") ?? "")"
            self.timeStampLabel.text = "Posted: \(activityDate)"
        }
        
    }
    
    @IBAction func onTapJobDetailsButton(_ sender: UIButton) {
        self.jobDetailsAction?()
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
