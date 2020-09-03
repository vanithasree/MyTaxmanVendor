//
//  JobHeaderView.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class JobHeaderView: UITableViewHeaderFooterView {

    @IBOutlet var titleLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    func setupViews(){
        titleLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20)), numberOfLines: 0, alignment: .left)
        titleLabel.numberOfLines = 0
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
