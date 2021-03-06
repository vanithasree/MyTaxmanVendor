//
//  ChatTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 30/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
//    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var jobStatusLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var lastMessageLabel: UILabel!
    @IBOutlet var readStatusImageView: UIImageView!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
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
    
    func setupViews(){
        
//        doOnMain {
//            self.profileImageView.cornerRadius = self.profileImageView.frame.size.width / 2
//        }
//        profileImageView.contentMode = .scaleAspectFill
        
        //deliveryStatusImageView.contentMode = .scaleAspectFit
        
        nameLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0))
        
        jobStatusLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        jobStatusLabel.backgroundColor = ColorManager.textVeryLiteGreenColor.color
        jobStatusLabel.cornerRadius = 5
        jobStatusLabel.textColor = ColorManager.textThickDarkGreenColor.color
        
        chatLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        chatLabel.textColor = ColorManager.lightGrey.color
        
        timeStampLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        timeStampLabel.textColor = ColorManager.lightGrey.color
        
        
        lastMessageLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // do your thing
//        profileImageView.cornerRadius = profileImageView.frame.size.width / 2
    }
    
    func setValue(data: Inboxlist){
//
//        if let profilePic = data.profile_pic, !profilePic.isEmpty {
//            profileImageView.load(from: Constant.imageBaseUrlString + profilePic)
//        }
//        else {
        readStatusImageView.image = UIImage(named: "tick")?.withRenderingMode(.alwaysTemplate)
        readStatusImageView.tintColor = ColorManager.darkTheme.color
//        }
        
        nameLabel.text = data.customername ?? ""
        var quote_status = ""
        switch data.quote_status ?? "" {
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
            if data.task_status ?? "" == "0"{
                quote_status = "Marked as won"
            }else if data.task_status ?? "" == "1"{
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
        jobStatusLabel.text = "  \(quote_status)  "
        chatLabel.text = data.category ?? ""
        lastMessageLabel.text = data.message ?? ""
        
        if let acceptedDate = data.quote_accepted_on, !acceptedDate.isEmpty {
            
            let date = acceptedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
            let activityDate = "\(date?.toString(format: "dd MMM") ?? "")"
            timeStampLabel.text = activityDate
        }
        else {
            if let quotedDate = data.quoted_on, !quotedDate.isEmpty {
                let date = quotedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                let activityDate = "\(date?.toString(format: "dd MMM") ?? "")"
                timeStampLabel.text = activityDate
            }
        }
    }
}
