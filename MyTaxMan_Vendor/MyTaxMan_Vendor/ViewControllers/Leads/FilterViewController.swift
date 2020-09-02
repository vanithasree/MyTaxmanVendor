//
//  FilterViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import DLRadioButton

class FilterViewController: BaseViewController {
    
    @IBOutlet weak var sectionTwoTitleLAbel: UILabel!
    @IBOutlet weak var sectionOneTitleLAbel: UILabel!
    @IBOutlet weak var secondBtnSO: DLRadioButton!
    @IBOutlet weak var firstBrnSO: DLRadioButton!
    @IBOutlet weak var thirdBtnSO: DLRadioButton!
    
    @IBOutlet weak var firstBtnST: DLRadioButton!
    @IBOutlet weak var secondBtnST: DLRadioButton!
    @IBOutlet weak var thirdBtnST: DLRadioButton!
    
    @IBOutlet weak var onTapApplyBtn: UIButton!
    @IBOutlet weak var objectHoldingView: UIView!
    
    var sectionOneString:String = ""
    var sectionTwoString : String = ""
    
    /*Params
     1. Vendorid
     2. filteroption
     Latest , Draft , Ignore
     3. sortoption
     LowCreditsFirst , HighCreditsFirst  , all_leads*/
    var sortArray = ["LowCreditsFirst", "HighCredeitsFirst", "all_leads"]
    var filterArray = ["Latest", "Draft", "Ignore"]
    
    
    var choosenData: ((_ sectionOne: String, _ sectionTwoString: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionOneTitleLAbel.setLabelCustomProperties(titleText: "SORT BY", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        sectionTwoTitleLAbel.setLabelCustomProperties(titleText: "FILTER BY", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        self.setRadioButtonProperties(radioBtn: firstBrnSO, titleString: "Latest Leads",setTag: 0)
        self.setRadioButtonProperties(radioBtn: secondBtnSO, titleString: "Credits (low to high)",setTag: 1)
        self.setRadioButtonProperties(radioBtn: thirdBtnSO, titleString: "Credits(high to low)",setTag: 2)
        
        self.setRadioButtonProperties(radioBtn: firstBtnST, titleString: "All leads",setTag: 0)
        self.setRadioButtonProperties(radioBtn: secondBtnST, titleString: "Credits (low to high)",setTag: 1)
        self.setRadioButtonProperties(radioBtn: thirdBtnST, titleString: "Credits(high to low)",setTag: 2)
        
        self.onTapApplyBtn.setDarkGreenTheme(btn: self.onTapApplyBtn, title: "APPLY")
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        objectHoldingView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    @IBAction func onTapFilterBtn(_ sender: UIButton) {
        if self.sectionOneString.isEmpty && self.sectionTwoString.isEmpty {
            self.presentAlert(withTitle: "", message: "Please select atleast one")
        }
        else {
            
            choosenData?(self.sectionOneString, self.sectionTwoString)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setRadioButtonProperties(radioBtn : DLRadioButton, titleString : String, setTag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.isIconSquare = false
        radioBtn.tag = setTag
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    
    @objc @IBAction private func logSelectedBtnForSectionOne(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.sectionOneString = radioButton.selected()!.titleLabel!.text ?? ""
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    @objc @IBAction private func logSelectedBtnForSectionTwo(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.sectionTwoString = radioButton.selected()!.titleLabel!.text ?? ""
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension FilterViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
