//
//  WalletTableViewCell.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 04/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import DLRadioButton

class WalletTableViewCell: UITableViewCell {

    @IBOutlet weak var walletBgView: UIImageView!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var rechargeTitleLabel: UILabel!
    @IBOutlet weak var walletBalanceValueLabel: UILabel!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var walletTitleLabel: UILabel!
    

    var choosenAmount : String = ""
    
      var rechargeButtonAction : ((_ choosenAmount: String) ->Void)?
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellViewUI()
    }
    
    func setCellViewUI() {
        
        walletBgView.backgroundColor = ColorManager.textVeryLiteGreenColor.color
        
    
        
        walletTitleLabel.setLabelCustomProperties(titleText: "WALLET BALANCE", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .center)
        walletBalanceValueLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .center)
        
        rechargeTitleLabel.setLabelCustomProperties(titleText: "Recharge Amount", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .center)
        
        submitBtn.setDarkGreenTheme(btn: submitBtn, title: "Recharge")
        submitBtn.cornerRadius = 5.0
        
        
        self.setRadioButtonPropertiesForWallet(radioBtn: firstBtn, titleString: "$ 25", setTag: 1)
        self.setRadioButtonPropertiesForWallet(radioBtn: secondBtn, titleString: "$ 50", setTag: 2)
        self.setRadioButtonPropertiesForWallet(radioBtn: thirdBtn, titleString: "$ 100", setTag: 3)
        
    }
    
    func setRadioButtonPropertiesForWallet(radioBtn : DLRadioButton, titleString : String, setTag:Int) {
         radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
          radioBtn.titleLabel?.font =  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0))
         radioBtn.marginWidth = 10.0
         radioBtn.isIconSquare = false
         radioBtn.tag = setTag
         radioBtn.icon = UIImage(named: "Radio")!
         radioBtn.iconSelected = UIImage(named: "RadioSelected")!
     }
    @objc @IBAction private func logSelectedBtnForWalletCell(radioButton : DLRadioButton) {
          if (radioButton.isMultipleSelectionEnabled) {
              for button in radioButton.selectedButtons() {
                  print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
              }
          } else {
              self.choosenAmount = radioButton.selected()!.titleLabel!.text ?? ""
              print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
          }
      }

    @IBAction func onTapRechargeBtn(_ sender: UIButton) {
        rechargeButtonAction?(self.choosenAmount)
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
