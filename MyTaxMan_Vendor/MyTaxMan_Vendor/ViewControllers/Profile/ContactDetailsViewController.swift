//
//  ContactDetailsViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 03/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import TweeTextField
import Alamofire

class ContactDetailsViewController: BaseViewController {
    
    var vendorProfileDetails : VenProfileBase?
    
    @IBOutlet weak var contactPersonTextField: TweeAttributedTextField!
    @IBOutlet weak var emailAddressTextField: TweeAttributedTextField!
    @IBOutlet weak var landLineTextField: TweeAttributedTextField!
    @IBOutlet weak var mobileNumberTextField: TweeAttributedTextField!
    
    private var authViewModel = AuthViewModel()
    private var profileViewModel = ProfileViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact details"
        
        self.setTextFieldPropertiesOnContactDetails(textField: contactPersonTextField, placeHolder: "Contact person", isSecureText: false, keypadType: .default, tag: 1)
        
        self.setTextFieldPropertiesOnContactDetails(textField: mobileNumberTextField, placeHolder: "Mobile number", isSecureText: false, keypadType: .numberPad, tag: 2)
        
        
        self.setTextFieldPropertiesOnContactDetails(textField: landLineTextField, placeHolder: "Landline", isSecureText: false, keypadType: .numberPad, tag: 3)
        
        
        self.setTextFieldPropertiesOnContactDetails(textField: emailAddressTextField, placeHolder: "Email address", isSecureText: false, keypadType: .emailAddress, tag: 14)
        
        let rightBarButtonItem = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.setViewData()
        
        
        // Do any additional setup after loading the view.
    }
    @objc func doneTapped() {
        self.view.endEditing(true)
        let inputs : ContactDetailsInput = .init(contactName: self.contactPersonTextField.text, mobileNumber: self.mobileNumberTextField.text, email: self.emailAddressTextField.text, landline: self.landLineTextField.text)
        authViewModel.contactDetails = inputs
        let validationResult = authViewModel.validateContactDetailsInputs()
        
        if !validationResult.isEmpty {
            contactPersonTextField.hideInfo()
            emailAddressTextField.hideInfo()
            mobileNumberTextField.hideInfo()
            landLineTextField.hideInfo()
            
            
            print(validationResult)
            validationResult.forEach { (validation) in
                
                switch validation.tag {
                    
                case 2:
                    contactPersonTextField.showInfo(validation.errorMessage ?? "")
                case 4:
                    emailAddressTextField.showInfo(validation.errorMessage ?? "")
                case 3:
                    mobileNumberTextField.showInfo(validation.errorMessage ?? "")
                case 10:
                    landLineTextField.showInfo(validation.errorMessage ?? "")
                    
                default:
                    break
                }
            }
            return
            
        }
        self.updateContactDetails()
        
    }
    
    func setViewData() {
        self.contactPersonTextField.text = self.vendorProfileDetails?.desc?.first?.vendorname ?? ""
        self.mobileNumberTextField.text = self.vendorProfileDetails?.desc?.first?.mobile_no ?? ""
        self.landLineTextField.text = self.vendorProfileDetails?.desc?.first?.landline ?? ""
        self.emailAddressTextField.text = self.vendorProfileDetails?.desc?.first?.email ?? ""
        
    }
    
    func setTextFieldPropertiesOnContactDetails(textField:TweeAttributedTextField, placeHolder:String, isSecureText:Bool, keypadType: UIKeyboardType, tag : Int) {
        
        textField.setTextFieldProperties(placeholderString: placeHolder, isSecureText: isSecureText)
        textField.borderStyle = .none
        textField.tag = tag
        textField.backgroundColor = .clear
        textField.keyboardType = keypadType
        textField.delegate = self
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
extension ContactDetailsViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = textField as? TweeAttributedTextField {
            field.hideInfo()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let field = textField as? TweeAttributedTextField {
            var errorMessage = ""
            
            switch field  {
                
            case contactPersonTextField:
                errorMessage =   authViewModel.validateContactName(text: field.text).errorMessage ?? ""
            case emailAddressTextField:
                errorMessage = authViewModel.validateEmail(field.text).errorMessage ?? ""
            case mobileNumberTextField:
                errorMessage = authViewModel.validateMobile(field.text).errorMessage ?? ""
            case landLineTextField:
                errorMessage = authViewModel.validateLandline(text: field.text).errorMessage ?? ""
            default:
                break
            }
            
            if errorMessage == "" {
                field.hideInfo()
                return
            }
            field.showInfo(errorMessage)
            
        }
    }
}
extension ContactDetailsViewController {
    func updateContactDetails() {
        let params : Parameters = ["vendorid" : UserDetails.shared.userId, "contactname" :self.contactPersonTextField.text ?? "", "landlineno" : self.landLineTextField.text ?? "",
                                   "emailaddress" : self.emailAddressTextField.text ?? ""]
        LoadingIndicator.shared.show(forView: self.view)
        profileViewModel.updateVendorContactDetails(input: params) { (result: VenContactDetailsBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result{
                if let success = result.code, success == "1" {
                    self.presentAlert(withTitle: "", message: "Updated successfully") {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else {
                    self.presentAlert(withTitle: "", message: "") {}
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}
