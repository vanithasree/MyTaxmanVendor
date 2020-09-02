//
//  QuoteNowViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire
import TweeTextField

class QuoteNowViewController: BaseViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quoterNameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var saveAndDraftBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    
    @IBOutlet weak var flatBtn: UIButton!
    @IBOutlet weak var hourlyBtn: UIButton!
    
    @IBOutlet weak var costEstimateTitleLabel: UILabel!
    @IBOutlet weak var costEstimateSwitch: UISwitch!
    @IBOutlet weak var flatHourlyHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var infoDescriptionLabel: UILabel!
    @IBOutlet weak var inspectionNeededDescriptionLabel: UILabel!
    @IBOutlet weak var inspectionNeededLabel: UILabel!
    @IBOutlet weak var informationNeedLabel: UILabel!
    @IBOutlet weak var additionalCommentsLabel: UILabel!
    
    @IBOutlet weak var commentsView: UIView!
    @IBOutlet weak var inspectionSwitch: UISwitch!
    @IBOutlet weak var informationSwitch: UISwitch!
    @IBOutlet weak var additionalCommentSwitch: UISwitch!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var commentsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextField: TweeAttributedTextField!
    
    
    @IBOutlet weak var termsView: UIView!
    
    let descriptionLabeL = "We will let the customer know you will be in touch and that a cost estimate is not final untial a site inspection is arranged."
    
    
    private var leadViewModel = LeadViewModel()
    var quoteDetail : Ilist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        // Do any additional setup after loading the view.
    }
    func setupViewUI() {
        self.title = "New Quote"
        titleLabel.setLabelCustomProperties(titleText:"Choose atleast one option below to continue your converstion with", textColor: .black, font:  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .center)
        quoterNameLabel.setLabelCustomProperties(titleText:self.quoteDetail?.customername ?? "", textColor:ColorManager.textDarkGreenColor.color, font:  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .center)
        
        
        costLabel.setLabelCustomProperties(titleText: "COST: \(self.quoteDetail?.task_credits ?? "0") Credits", textColor:ColorManager.darkGrey.color, font:  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .center)
        
        
        saveAndDraftBtn.setDarkGreenTheme(btn: saveAndDraftBtn, title: "Save As Draft")
        submitBtn.setDarkGreenTheme(btn: submitBtn, title: "SUBMIT")
        
        
        costEstimateTitleLabel.setLabelCustomProperties(titleText:"Cost Estimate", textColor:ColorManager.darkGrey.color, font:  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .center)
        
        
        flatBtn.setDarkGreenTheme(btn: flatBtn, title: "FLAT")
        flatBtn.isSelected = true
        
        hourlyBtn.setButtonProperties(title: "HOURLY", font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), titleColor: ColorManager.textThickDarkGreenColor.color)
        hourlyBtn.isSelected = false
        
        self.flatHourlyHeightConstraint.constant = 60
        self.firstView.isHidden = false
        self.secondView.isHidden = true
        
        
        /*  flatBtn.setButtonProperties(title: "FLAT", font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), titleColor: ColorManager.textThickDarkGreenColor.color)
         hourlyBtn.setButtonProperties(title: "HOURLY", font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), titleColor: ColorManager.textThickDarkGreenColor.color)*/
        
        firstTextField.font =  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0))
        firstTextField.backgroundColor = .white
        firstTextField.keyboardType = .numberPad
        firstTextField.textAlignment = .center
        
        secondTextField.font =  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0))
        secondTextField.backgroundColor = .white
        secondTextField.keyboardType = .numberPad
        secondTextField.textAlignment = .center
        
        
        inspectionNeededDescriptionLabel.setLabelCustomProperties(titleText:"", textColor:ColorManager.lightGrey.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 0, alignment: .left)
        infoDescriptionLabel.setLabelCustomProperties(titleText:"", textColor:ColorManager.lightGrey.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 0, alignment: .left)
        
        
        inspectionNeededLabel.setLabelCustomProperties(titleText:"Site Inspection Needed", textColor:ColorManager.darkGrey.color, font:  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        informationNeedLabel.setLabelCustomProperties(titleText:"More Information Needed", textColor:ColorManager.darkGrey.color, font:  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        additionalCommentsLabel.setLabelCustomProperties(titleText:"Additional Comments", textColor:ColorManager.darkGrey.color, font:  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        noteLabel.setLabelCustomProperties(titleText:"Note: Customers appreciate information specific to their job", textColor:ColorManager.darkGrey.color, font:  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        costEstimateSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        inspectionSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        inspectionSwitch.isOn = false
        informationSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        informationSwitch.isOn = false
        additionalCommentSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        additionalCommentSwitch.isOn = false
        
        inspectionSwitch.tag = 100
        informationSwitch.tag = 101
        additionalCommentSwitch.tag = 102
        
        self.commentTextField.setTextFieldProperties(placeholderString: "Comments", isSecureText: false)
        
        self.checkSwitchState()
    }
    
    @IBAction func onTapFlatBtn(_ sender: UIButton) {
        self.flatBtn.isSelected = true
        self.hourlyBtn.isSelected = false
        self.flatHourlyHeightConstraint.constant = 60
        self.firstView.isHidden = false
        self.secondView.isHidden = true
        self.setButtonStateBasedOnSelection(btn: self.hourlyBtn)
        self.setButtonStateBasedOnSelection(btn: self.flatBtn)
    }
    
    @IBAction func onTapHourlyBtn(_ sender: UIButton) {
        self.flatBtn.isSelected = false
        self.hourlyBtn.isSelected = true
        self.firstView.isHidden = false
        self.secondView.isHidden = false
        self.flatHourlyHeightConstraint.constant = 130
        self.setButtonStateBasedOnSelection(btn: self.hourlyBtn)
        self.setButtonStateBasedOnSelection(btn: self.flatBtn)
    }
    func setButtonStateBasedOnSelection(btn:UIButton) {
        if btn.isSelected {
            btn.setDarkGreenTheme(btn: btn, title: btn.titleLabel?.text ?? "")
        }
        else {
            btn.setButtonProperties(title:btn.titleLabel?.text ?? "", font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), titleColor: ColorManager.textThickDarkGreenColor.color)
        }
        setHeightConstraint()
    }
    
    func setHeightConstraint() {
        //  self.scrollViewHeightConstraint.constant = self.termsView.frame.origin.x + self.termsView.frame.height + 20
    }
    
    func checkSwitchState() {
        if self.inspectionSwitch.isOn {
            self.inspectionNeededDescriptionLabel.text = self.descriptionLabeL
        }
        else
        {
            self.inspectionNeededDescriptionLabel.text = ""
        }
        
        if self.informationSwitch.isOn {
            self.infoDescriptionLabel.text = self.descriptionLabeL
        }
        else {
            self.infoDescriptionLabel.text = ""
        }
        
        if self.additionalCommentSwitch.isOn {
            self.commentsViewHeightConstraint.constant = 50
            self.commentsView.isHidden = false
        }
        else {
            self.commentsViewHeightConstraint.constant = 0
            self.commentsView.isHidden = true
        }
        setHeightConstraint()
    }
    
    
    @objc func switchChanged(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        switch mySwitch.tag {
        case 100:
            if value {
                self.inspectionNeededDescriptionLabel.text = self.descriptionLabeL
            }
            else {
                self.inspectionNeededDescriptionLabel.text = ""
            }
            break
        case 101:
            if value {
                self.infoDescriptionLabel.text = self.descriptionLabeL
            }
            else {
                self.infoDescriptionLabel.text = ""
            }
            break
        case 102:
            if value {
                self.commentsViewHeightConstraint.constant = 50
                self.commentsView.isHidden = false
            }
            else {
                self.commentsViewHeightConstraint.constant = 0
                self.commentsView.isHidden = true
            }
            break
        default:
            break
        }
        setHeightConstraint()
        // Do something
    }
    
    
    @IBAction func onTappedDraftBtn(_ sender: UIButton) {
        self.saveDraft()
        
    }
    
    @IBAction func onTappedSubmitBtn(_ sender: UIButton) {
        self.checkAllConditions()
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

extension QuoteNowViewController {
    func checkAllConditions() {
        if self.flatBtn.isSelected {
            print("flatbtn is selected")
            if let text = self.firstTextField.text, text.isEmpty {
                self.showToast(message: "Flat cost is required")
                return
            }
            self.callSubmitApi()
        }
        else if self.hourlyBtn.isSelected {
            print("hourly is selected")
            if let text = self.firstTextField.text, text.isEmpty {
                self.showToast(message: "Hourly cost is required")
                return
            }
            if let text = self.secondTextField.text, text.isEmpty {
                self.showToast(message: "Hourly cost value is required")
                return
            }
            self.callSubmitApi()
        }
    }
    
    func callSubmitApi() {
        
        let input  : Parameters = ["vendorid" :UserDetails.shared.userId,"taskid" : self.quoteDetail?.taskid ?? "","customerid" : self.quoteDetail?.customerid ?? "","device_currentdatetime" : Date().dateAndTimetoString(),
                                   "cost_estimate_flat" : self.firstTextField.text ?? "","cost_estimate_hourly" : self.firstTextField.text ?? "","cost_estimate_hourlyhours" : self.secondTextField.text ?? "",
                                   "site_inspection" : self.inspectionSwitch.isOn ? "Yes" : "No","more_information" : self.informationSwitch.isOn ? "Yes" : "No","additional_comments" : self.commentTextField.text ?? ""]
        LoadingIndicator.shared.show(forView: self.view)
        
        leadViewModel.doSubmitQuote(input: input) { (result: SubmitQuoteBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.presentAlert(withTitle:"" , message: result.desc ?? "") {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    
                } else {
                    self.presentAlert(withTitle: "", message: "Please check the input") {}
                }
                
                
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    func saveDraft() {
        
        let input  : Parameters = ["vendorid" :UserDetails.shared.userId,"taskid" : self.quoteDetail?.taskid ?? "","customerid" : self.quoteDetail?.customerid ?? "","device_currentdatetime" : Date().dateAndTimetoString(),
                                   "cost_estimate_flat" : self.firstTextField.text ?? "","cost_estimate_hourly" : self.firstTextField.text ?? "","cost_estimate_hourlyhours" : self.secondTextField.text ?? "",
                                   "site_inspection" : self.inspectionSwitch.isOn ? "Yes" : "No","more_information" : self.informationSwitch.isOn ? "Yes" : "No","additional_comments" : self.commentTextField.text ?? ""]
        LoadingIndicator.shared.show(forView: self.view)
        
        leadViewModel.doDraftQuote(input: input) { (result: DraftQuoteBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.presentAlert(withTitle:"" , message: result.desc ?? "") {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    
                } else {
                    self.presentAlert(withTitle: "", message: "Please check the input") {}
                }
                
                
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}
