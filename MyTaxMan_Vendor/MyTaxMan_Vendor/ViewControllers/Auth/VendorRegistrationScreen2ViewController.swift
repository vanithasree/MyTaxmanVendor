//
//  VendorRegistrationScreen2ViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import TweeTextField
import Alamofire

class VendorRegistrationScreen2ViewController: BaseViewController {
    
    @IBOutlet weak var titleTabel: UILabel!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var optionalTitleLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var passwordTextField: TweeAttributedTextField!
    @IBOutlet weak var emailAddressTextField: TweeAttributedTextField!
    @IBOutlet weak var businessNameTextField: TweeAttributedTextField!
    @IBOutlet weak var contactNameTextField: TweeAttributedTextField!
    
    @IBOutlet weak var abnNumber: TweeAttributedTextField!
    @IBOutlet weak var mobileNumberTextField: TweeAttributedTextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    private var authViewModel = AuthViewModel()
    
    var serviceTypeString: String = ""
    var locationString: String = ""
    var base64String: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewUI()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.base64String = ""
    }
    
    func setViewUI() {
        
        self.title = "Step 2"
        
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "NEXT")
        
        self.titleTabel.setLabelCustomProperties(titleText: "Register to connect with new customers today", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .left)
        
        self.photoLabel.setLabelCustomProperties(titleText: "Photo or Logo", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .left)
        
        self.optionalTitleLabel.setLabelCustomProperties(titleText: "(optional)", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .left)
        
        
        
        self.setTextFieldPropertiesOnView(textField: self.businessNameTextField, placeHolder: "Business Name", isSecureText: false, keypadType: .default)
        
        self.setTextFieldPropertiesOnView(textField: self.contactNameTextField, placeHolder: "Contact Name", isSecureText: false, keypadType: .default)
        
        self.setTextFieldPropertiesOnView(textField: self.emailAddressTextField, placeHolder: "Email Address", isSecureText: false, keypadType: .emailAddress)
        
        self.setTextFieldPropertiesOnView(textField: self.mobileNumberTextField, placeHolder: "Mobile Number", isSecureText: false, keypadType: .numberPad)
        
        self.setTextFieldPropertiesOnView(textField: self.abnNumber, placeHolder: "ABN", isSecureText: false, keypadType: .numberPad)
        
        self.setTextFieldPropertiesOnView(textField: self.passwordTextField, placeHolder: "Password", isSecureText: true, keypadType: .default)
        
        self.profilePicImageView.layer.cornerRadius = self.profilePicImageView.frame.width / 2
        
        
        let profilePicTap = UITapGestureRecognizer(target: self, action: #selector(onTappedProfilePicture))
        profilePicTap.numberOfTapsRequired = 1
        self.profilePicImageView.isUserInteractionEnabled = true
        self.profilePicImageView.addGestureRecognizer(profilePicTap)
        
    }
    
    @objc func onTappedProfilePicture() {
        self.openCamera()
    }
    
    func setTextFieldPropertiesOnView(textField:TweeAttributedTextField, placeHolder:String, isSecureText:Bool, keypadType: UIKeyboardType) {
        
        textField.setTextFieldProperties(placeholderString: placeHolder, isSecureText: isSecureText)
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.keyboardType = keypadType
        textField.delegate = self
    }
    
    @IBAction func onTapNextBtn(_ sender: Any) {
        self.view.endEditing(true)
        let inputs : RegisterInput = .init(businessName: self.businessNameTextField.text, contactName: self.contactNameTextField.text, mobileNumber: self.mobileNumberTextField.text, email: self.emailAddressTextField.text, password: self.passwordTextField.text, abn: self.abnNumber.text)
        
        authViewModel.registerInputs = inputs
        let valiationResult = authViewModel.validateRegisterInputs()
        if !valiationResult.isEmpty {
            businessNameTextField.hideInfo()
            contactNameTextField.hideInfo()
            emailAddressTextField.hideInfo()
            mobileNumberTextField.hideInfo()
            passwordTextField.hideInfo()
            abnNumber.hideInfo()
            
            /*  firstNameTextField.show()
             lastNameTextField.hideInfo()
             mobileNumberTextField.hideInfo()
             emailTextField.hideInfo()
             passwordTextField.hideInfo()
             conformPasswordTextField.hideInfo()*/
            print(valiationResult)
            
            
            var alertMessage : String = ""
            valiationResult.forEach { (validation) in
                
                switch validation.tag {
                case 1:
                    businessNameTextField.showInfo(validation.errorMessage ?? "")
                case 2:
                    contactNameTextField.showInfo(validation.errorMessage ?? "")
                case 4:
                    emailAddressTextField.showInfo(validation.errorMessage ?? "")
                case 3:
                    mobileNumberTextField.showInfo(validation.errorMessage ?? "")
                case 5:
                    passwordTextField.showInfo(validation.errorMessage ?? "")
                case 10:
                    abnNumber.showInfo(validation.errorMessage ?? "")
                    
                default:
                    break
                }
            }
            return
        }
        
        /* {
         "name" : "apitest",
         "mobile_no" : "0909909090",
         "email" : "test@gmail.com,
         "password" : "898989,
         "business_name" : "Test,
         "ABN": "90909090",
         "location" : "Sydney",
         "service_types" : "Tax Returns",
         "profile_pic" : "image_base64format",
         "device_currentdatetime" : "2020-06-22 12:37:39
         }
         
         */
        self.doRegister()
    }
    fileprivate func openCamera() {
        CameraHandler.shared.showActionSheet(vc: self )
        CameraHandler.shared.imagePickedBlock = { (image,name) in
            self.profilePicImageView.image = image
            
            let imageData: Data? = image.jpegData(compressionQuality: 1.0)
            self.base64String = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            
        }
    }
    func redirectToOtpScreenVC(mobileNumber:String = "", vendorId:String) {
        let mobileVC = OTPViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        mobileVC.mobileNumberString = mobileNumber
        mobileVC.vendorIdString = vendorId
        self.navigationController?.pushViewController(mobileVC, animated: true)
    }
    
    func doRegister() {
        let inputParams : Parameters = [
            "name" : contactNameTextField.text ?? "",
            "mobile_no" : mobileNumberTextField.text ?? "",
            "email" : emailAddressTextField.text ?? "",
            "password" : passwordTextField.text ?? "",
            "business_name" : businessNameTextField.text ?? "",
            "ABN": abnNumber.text ?? "",
            "location" : locationString,
            "service_types" : serviceTypeString,
            "profile_pic" : self.base64String,
            "device_currentdatetime" : Date().dateAndTimetoString()
        ]
        LoadingIndicator.shared.show(forView: self.view)
        authViewModel.registerBusinessProfile(input: inputParams) { (result: RegisterBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result{
                if let success = result.code, success == "1" {
                    self.presentAlert(withTitle: "", message: result.desc ?? "") {
                        // self.redirectToOtpScreenVC(mobileNumber: result.businessid?.first?.mobile_no ??, vendorId:result.businessid?.first?.vendorid ?? "")
                        self.redirectToOtpScreenVC(mobileNumber: result.businessid?.first?.mobile_no ?? "", vendorId: result.businessid?.first?.vendorid ?? "")
                    }
                    
                }
                else {
                    self.presentAlert(withTitle: "", message: result.desc ?? "") {}
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
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
extension VendorRegistrationScreen2ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = textField as? TweeAttributedTextField {
            field.hideInfo()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let field = textField as? TweeAttributedTextField {
            var errorMessage = ""
            
            switch field  {
            case businessNameTextField:
                errorMessage = authViewModel.validateBusinessName(text: field.text).errorMessage ?? ""
            case contactNameTextField:
                errorMessage =   authViewModel.validateContactName(text: field.text).errorMessage ?? ""
            case emailAddressTextField:
                errorMessage = authViewModel.validateEmail(field.text).errorMessage ?? ""
            case mobileNumberTextField:
                errorMessage = authViewModel.validateMobile(field.text).errorMessage ?? ""
            case passwordTextField:
                errorMessage = authViewModel.validatePassword(field.text).errorMessage ?? ""
            case abnNumber:
                errorMessage = authViewModel.validateAbnName(text: field.text).errorMessage ?? ""
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
