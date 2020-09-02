//
//  DetailHeaderViewTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class DetailHeaderViewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var secondStatusLabel: UILabel!
    
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var firstStatusLabel: UILabel!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var firstimageView: UIImageView!
    
    
    
    @IBOutlet weak var backBtn: UIButton!
    var backAction : (() ->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setCellViewUI()
        // Initialization code
    }
    
    
    func setCellViewUI() {
        self.backBtn.isHidden = true
        statusLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .center)
        
        firstimageView.image = UIImage(named: "Radio")
        firstBtn.setThickGreenColor(btn: firstBtn, title: "")
        firstBtn.titleLabel?.font = UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(20.0))
        
        firstStatusLabel.setLabelCustomProperties(titleText: "", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .center)
        
        secondImageView.image = UIImage(named: "Radio")
        secondBtn.setThickGreenColor(btn: secondBtn, title: "")
        secondBtn.titleLabel?.font = UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(20.0))
        secondStatusLabel.setLabelCustomProperties(titleText: "", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .center)
        
    }
    
    func setHeaderData(ilistData : Ilist?) {
        var descriptionText : String = ""
        switch ilistData?.rmsg?.first?.received_quote_count {
        case "0":
            descriptionText = "Be The First"
        case "1", "2":
            descriptionText = "More Quotes Received"
        case "3":
            descriptionText = "Get in Quick"
            
        default:
            break
        }
        
        self.statusLabel.text = descriptionText.capitalized
        firstBtn.setTitle("\(ilistData?.task_credits ?? "0") Credits", for: .normal)
        firstStatusLabel.text = "COST TO QUOTE"
        secondBtn.setTitle("\( ilistData?.rmsg?.first?.received_quote_count ?? "0") of 4", for: .normal)
        secondStatusLabel.text = "QUOTES RECEIVED"
        
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
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        backAction?()
    }
    
}
