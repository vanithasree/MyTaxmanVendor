//
//  CallListTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class CallListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var objectContainerView: UIView!
    @IBOutlet weak var callerAddressLabel: UILabel!
    @IBOutlet weak var callerNameLabel: UILabel!
    
    @IBOutlet weak var callerCreditsLabel: UILabel!
    @IBOutlet weak var callerTimeStampLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewUI()
    }
    
    func setupViewUI() {
        
        objectContainerView.cornerRadius = 7.5
        objectContainerView.layer.borderWidth = 0.8
        objectContainerView.layer.borderColor = ColorManager.lightGrey.color.cgColor
        
        callerNameLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        callerAddressLabel.setLabelCustomProperties(titleText: "", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .left)
        
        callerCreditsLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.textDarkGreenColor.color, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 1, alignment: .center)
        
        callerTimeStampLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.lightGrey.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 1, alignment: .center)
        
        dateLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkText.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 1, alignment: .left)
        
        
    }
    
    func setCallData(data : CallHistroyIlist) {
        self.callerNameLabel.text = data.customername ?? ""
        self.callerAddressLabel.text = data.service_location ?? ""
        self.callerCreditsLabel.text = "\(data.task_credits ?? "0") Credits"
        self.callerTimeStampLabel.text = data.called_on ?? ""
        
        
        if let hourString = data.called_on, !hourString.isEmpty {
            
            let date = hourString.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
            let activityDate = "\(date?.toString(format: "h:mm a") ?? "")"
            self.callerTimeStampLabel.text = activityDate
            
            let newDate =  "\(date?.toString(format: "yyyy-MM-dd") ?? "")"
            self.dateLabel.text = newDate
        }
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
