//
//  taskDetailTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class taskDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var serviceLocationValueLbel: UILabel!
    @IBOutlet weak var serviceLocationTitleLabel: UILabel!
    @IBOutlet weak var seventhView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var sixthView: UIView!
    @IBOutlet weak var fifthView: UIView!
    
    @IBOutlet weak var fourthView: UIView!
    
    @IBOutlet weak var page7ValueLabel: UILabel!
    @IBOutlet weak var page7TitleLabel: UILabel!
    @IBOutlet weak var page6ValueLabel: UILabel!
    @IBOutlet weak var page6TitleLabel: UILabel!
    @IBOutlet weak var page5ValueLabel: UILabel!
    @IBOutlet weak var page5TitleLabel: UILabel!
    @IBOutlet weak var page4ValueLabel: UILabel!
    @IBOutlet weak var page4TitleLabel: UILabel!
    @IBOutlet weak var page3ValueLabel: UILabel!
    @IBOutlet weak var page3TitleLabel: UILabel!
    @IBOutlet weak var page2TitleLabel: UILabel!
    
    @IBOutlet weak var page2ValueLabel: UILabel!
    @IBOutlet weak var page1ValueLabel: UILabel!
    @IBOutlet weak var page1TitleValue: UILabel!
    @IBOutlet weak var taskStackView: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var startDateTitleLabel: UILabel!
    
    
    
    @IBOutlet weak var startDateValueLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentBGView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewUI()
    }
    func setupViewUI() {
        contentBGView.backgroundColor = .white
        /* contentBGView.layer.borderColor = UIColor.clear.cgColor
         contentBGView.layer.borderWidth = 1.0
         contentBGView.cornerRadius = 5.0
         
         taskStackView.cornerRadius = 5.0*/
        taskStackView.addBorder(color: UIColor.lightGray, backgroundColor: .white, thickness: 1.0)
        
        
        
        
        titleLabel.setLabelCustomProperties(titleText:"TASK DETAILS", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .center)
        
        startDateTitleLabel.setLabelCustomProperties(titleText:"Start Date:", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        startDateValueLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        serviceLocationTitleLabel.setLabelCustomProperties(titleText:"Service Location:", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        serviceLocationValueLbel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        
        page1TitleValue.setLabelCustomProperties(titleText:"", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        page1ValueLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        
        page2TitleLabel.setLabelCustomProperties(titleText:"", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        page2ValueLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        page3TitleLabel.setLabelCustomProperties(titleText:"", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        page3ValueLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        page4TitleLabel.setLabelCustomProperties(titleText:"", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        page4ValueLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        page5TitleLabel.setLabelCustomProperties(titleText:"", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        page5ValueLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        
        page6TitleLabel.setLabelCustomProperties(titleText:"", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        page6ValueLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
        
        
        page7TitleLabel.setLabelCustomProperties(titleText:"", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        page7ValueLabel.setLabelCustomProperties(titleText:"", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .right)
    }
    
    func setData(ilist:Ilist?) {
        self.startDateValueLabel.text = ilist?.task_submitted_on ?? ""
        self.serviceLocationValueLbel.text = ilist?.service_location ?? ""
        
        
        
        if let page1TitleString = ilist?.page1_title, !page1TitleString.isEmpty {
            self.page1TitleValue.text = page1TitleString
            
            if let page1ValueString = ilist?.page1, !page1ValueString.isEmpty {
                self.page1ValueLabel.text = page1ValueString
            }
        }
        else {
            
            /* self.taskStackView.removeArrangedSubview(self.firstView)
             self.firstView.removeFromSuperview()*/
        }
        
        //Page 2
        if let page2TitleString = ilist?.page2_title, !page2TitleString.isEmpty {
            self.page2TitleLabel.text = page2TitleString
            
            if let page2ValueString = ilist?.page2, !page2ValueString.isEmpty {
                self.page2ValueLabel.text = page2ValueString
            }
        }
        else {
            /*self.taskStackView.removeArrangedSubview(self.secondView)
             self.secondView.removeFromSuperview()*/
        }
        
        //Page 3
        
        if let page3TitleString = ilist?.page3_title, !page3TitleString.isEmpty {
            self.page3TitleLabel.text = page3TitleString
            
            if let page3ValueString = ilist?.page3, !page3ValueString.isEmpty {
                self.page3ValueLabel.text = page3ValueString
            }
        }
        else {
            /* self.taskStackView.removeArrangedSubview(self.thirdView)
             self.thirdView.removeFromSuperview()*/
        }
        
        //page 4
        if let page4TitleString = ilist?.page4_title, !page4TitleString.isEmpty {
            self.page4TitleLabel.text = page4TitleString
            
            if let page4ValueString = ilist?.page4, !page4ValueString.isEmpty {
                self.page4ValueLabel.text = page4ValueString
            }
        }
        else {
            /*  self.taskStackView.removeArrangedSubview(self.fourthView)
             self.fourthView.removeFromSuperview()*/
        }
        
        //page 5
        if let page5TitleString = ilist?.page5_title, !page5TitleString.isEmpty {
            self.page5TitleLabel.text = page5TitleString
            
            if let page5ValueString = ilist?.page5, !page5ValueString.isEmpty {
                self.page5ValueLabel.text = page5ValueString
            }
        }
        else {
            /* self.taskStackView.removeArrangedSubview(self.fifthView)
             self.fifthView.removeFromSuperview()*/
        }
        
        //page 6
        if let page6TitleString = ilist?.page6_title, !page6TitleString.isEmpty {
            self.page6TitleLabel.text = page6TitleString
            
            if let page6ValueString = ilist?.page6, !page6ValueString.isEmpty {
                self.page6ValueLabel.text = page6ValueString
            }
        }
        else {
            /*   self.taskStackView.removeArrangedSubview(self.sixthView)
             self.sixthView.removeFromSuperview()*/
        }
        
        
        //page 7
        if let page7TitleString = ilist?.page7_title, !page7TitleString.isEmpty {
            self.page7TitleLabel.text = page7TitleString
            
            if let page7ValueString = ilist?.page7, !page7ValueString.isEmpty {
                self.page7ValueLabel.text = page7ValueString
            }
        }
        else {
            /*  self.taskStackView.removeArrangedSubview(self.seventhView)
             self.seventhView.removeFromSuperview()*/
            
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
