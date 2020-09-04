//
//  BusinessDetailsViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 03/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import TweeTextField
import Alamofire

class BusinessDetailsViewController: BaseViewController {
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var changeProfilePicBtn: UIButton!
    
    @IBOutlet weak var businessNameTextField: TweeAttributedTextField!
    
    @IBOutlet weak var abnTextfield: TweeAttributedTextField!
    
    @IBOutlet weak var streetAddressTextField: TweeAttributedTextField!
    
    @IBOutlet weak var locationTextField: TweeAttributedTextField!
    
    @IBOutlet weak var descriptionTextField: TweeAttributedTextField!
    
    @IBOutlet weak var websiteTextField: TweeAttributedTextField!
    
    
    
    private var authViewModel = AuthViewModel()
    private var profileViewModel = ProfileViewModel()
    var vendorProfileDetails : VenProfileBase?
    var base64String : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Business details"
        
        profileImageView.cornerRadius = profileImageView.frame.width / 2
        changeProfilePicBtn.setButtonProperties(title: "Change business photo", font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(17.0)), titleColor: ColorManager.textLiteGreenColor.color)
        self.setTextFieldPropertiesOnBusinessDetails(textField: self.businessNameTextField, placeHolder: "Business name", isSecureText: false, keypadType: .default, tag: 1)
        
        self.setTextFieldPropertiesOnBusinessDetails(textField: self.abnTextfield, placeHolder: "ABN", isSecureText: false, keypadType: .numberPad, tag: 2)
        
        self.setTextFieldPropertiesOnBusinessDetails(textField: self.streetAddressTextField, placeHolder: "Street address", isSecureText: false, keypadType: .default, tag: 3)
        
        self.setTextFieldPropertiesOnBusinessDetails(textField: self.locationTextField, placeHolder: "Location", isSecureText: false, keypadType: .default, tag: 4)
        
        self.setTextFieldPropertiesOnBusinessDetails(textField: self.websiteTextField, placeHolder: "Website", isSecureText: false, keypadType: .webSearch, tag: 5)
        
        self.setTextFieldPropertiesOnBusinessDetails(textField: self.descriptionTextField, placeHolder: "Description", isSecureText: false, keypadType: .webSearch, tag: 6)
        
        let rightBarButtonItem = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(doneTappedInBP))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        setViewData()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func doneTappedInBP() {
        self.view.endEditing(true)
        let inputs : BusinessDetailsInput = .init(businessName: self.businessNameTextField.text, abn: self.abnTextfield.text, streetAddress: self.streetAddressTextField.text, location: self.locationTextField.text, website: self.websiteTextField.text)
        authViewModel.businessDetails = inputs
        
        let validationResult = authViewModel.validateBusinessDetailsInputs()
        
        if !validationResult.isEmpty {
            self.businessNameTextField.hideInfo()
            abnTextfield.hideInfo()
            streetAddressTextField.hideInfo()
            locationTextField.hideInfo()
            websiteTextField.hideInfo()
            
            
            print(validationResult)
            validationResult.forEach { (validation) in
                
                switch validation.tag {
                case 1:
                    businessNameTextField.showInfo(validation.errorMessage ?? "")
                case 10:
                    abnTextfield.showInfo(validation.errorMessage ?? "")
                case 105:
                    streetAddressTextField.showInfo(validation.errorMessage ?? "")
                case 106:
                    locationTextField.showInfo(validation.errorMessage ?? "")
                case 107:
                    websiteTextField.showInfo(validation.errorMessage ?? "")
                    
                default:
                    break
                }
            }
            return
            
        }
        self.updateBusinessProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.cornerRadius = profileImageView.frame.width / 2
    }
    
    func setViewData() {
        
        if let profilePic = self.vendorProfileDetails?.profile_pic, !profilePic.isEmpty {
            profileImageView.load(from:profilePic)
        }
        else {
            profileImageView.image = UIImage(named: "profile")
        }
        
        
        self.businessNameTextField.text = self.vendorProfileDetails?.desc?.first?.business_name ?? ""
        self.abnTextfield.text = self.vendorProfileDetails?.desc?.first?.aBN ?? ""
        self.streetAddressTextField.text = self.vendorProfileDetails?.desc?.first?.street_address ?? ""
        self.locationTextField.text = self.vendorProfileDetails?.desc?.first?.location ?? ""
        self.websiteTextField.text = self.vendorProfileDetails?.desc?.first?.website ?? ""
        self.descriptionTextField.text = self.vendorProfileDetails?.desc?.first?.description ?? ""
    }
    
    func setTextFieldPropertiesOnBusinessDetails(textField:TweeAttributedTextField, placeHolder:String, isSecureText:Bool, keypadType: UIKeyboardType, tag : Int) {
        
        textField.setTextFieldProperties(placeholderString: placeHolder, isSecureText: isSecureText)
        textField.borderStyle = .none
        textField.tag = tag
        textField.backgroundColor = .clear
        textField.keyboardType = keypadType
        textField.clearButtonMode = .always
        textField.delegate = self
    }
    
    
    @IBAction func onTapProfilePicBtn(_ sender: UIButton) {
        self.openCamera()
    }
    fileprivate func openCamera() {
        CameraHandler.shared.showActionSheet(vc: self )
        CameraHandler.shared.imagePickedBlock = { (image,name) in
            self.profileImageView.image = image
            let imageData: Data? = image.jpegData(compressionQuality: 1.0)
            self.base64String = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
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

extension BusinessDetailsViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = textField as? TweeAttributedTextField {
            field.hideInfo()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let field = textField as? TweeAttributedTextField {
            var errorMessage = ""
            
            switch field {
            case businessNameTextField:
                errorMessage =   authViewModel.validateBusinessName(text: field.text).errorMessage ?? ""
            case abnTextfield:
                errorMessage = authViewModel.validateAbnName(text: field.text).errorMessage ?? ""
            case streetAddressTextField:
                errorMessage = authViewModel.validateAddressLine1(field.text).errorMessage ?? ""
            case locationTextField:
                errorMessage = authViewModel.validateAddressLine2(field.text).errorMessage ?? ""
            case websiteTextField:
                errorMessage = authViewModel.validateWebsite(field.text).errorMessage ?? ""
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

extension BusinessDetailsViewController {
    func updateBusinessProfile() {
        
        let params : Parameters = [
            "vendorid" : UserDetails.shared.userId,
            "business_name" : self.businessNameTextField.text ?? "",
            "street_address" : self.streetAddressTextField.text ?? "",
            "location" : self.locationTextField.text ?? "",
            "website" : self.websiteTextField.text ?? "",
            "description" : self.descriptionTextField.text ?? ""]
        LoadingIndicator.shared.show(forView: self.view)
        profileViewModel.updateBusinessProfileDetails(input: params) { (result: VenBusinessDetailsBase?, alert: AlertMessage?) in
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
