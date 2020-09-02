//
//  ProfileScoreTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 02/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class ProfileScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var titleValue: UILabel!
    
    @IBOutlet weak var descriptionValue: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    var editBtnAction : (() ->Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleValue.setLabelCustomProperties(titleText: "Test", textColor:.black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        descriptionValue.setLabelCustomProperties(titleText: "Value", textColor:.lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .left)
        
        pointsLabel.setLabelCustomProperties(titleText: "10/100", textColor:ColorManager.textDarkGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .right)
        
        editBtn.setButtonProperties(title: "Edit contact", font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), titleColor: ColorManager.textLiteGreenColor.color)
    }
    

    @IBAction func onTapEditAction(_ sender: UIButton) {
        editBtnAction?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setDataForFirstRow(data : VenProfileBase?) {
        self.titleValue.text = "Logo"
        self.descriptionValue.text = ""
        self.editBtn.setTitle("Update profile picture", for: .normal)
        self.pointsLabel.text = "\(data?.logo_score ?? 0)/10 points"
    }
    
    func setDataForSecondRow(data : VenProfileBase?) {
        self.titleValue.text = "ABN"
        self.descriptionValue.text = ""
        self.editBtn.setTitle("", for: .normal)
        self.pointsLabel.text = "\(data?.abn_score ?? 0)/10 points"
    }
    
    func setDataForThirdRow(data : VenProfileBase?) {
        self.titleValue.text = "Insurance"
        self.descriptionValue.text = "Approved"
        self.editBtn.setTitle("Update another document", for: .normal)
        self.pointsLabel.text = "\(data?.insurance_score ?? 0)/10 points"
    }
    
    func setDataForFourthRow(data : VenProfileBase?) {
        self.titleValue.text = "Portfolio"
        self.descriptionValue.text = "\(data?.uploaded_pictures_count ?? 0) images uploaded"
        self.editBtn.setTitle("Update profile picture", for: .normal)
        self.pointsLabel.text = "\(data?.profile_score ?? 0)/10 points"
    }
    
    func setDataForFifthRow(data : VenProfileBase?) {
          self.titleValue.text = "Contact details"
          self.descriptionValue.text = ""
          self.editBtn.setTitle("Update contact information", for: .normal)
          self.pointsLabel.text = "\(data?.contactdetails_score ?? 0)/10 points"
      }
    
    func setDataForSixthRow(data : VenProfileBase?) {
            self.titleValue.text = "Description"
            self.descriptionValue.text = "Maximum 500 characters"
            self.editBtn.setTitle("Add description", for: .normal)
            self.pointsLabel.text = "\(data?.description_score ?? 0)/10 points"
        }
    func setDataForSeventhRow(data : VenProfileBase?) {
             self.titleValue.text = "Reviews"
        self.descriptionValue.text = "\(data?.reviewCount?.first?.review_count ?? "0")/10 reviews (4 points per review)"
             self.editBtn.setTitle("Request more reviews", for: .normal)
             self.pointsLabel.text = "\(data?.reviewcount_score ?? 0)/40 points"
         }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
