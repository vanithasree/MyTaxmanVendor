//
//  ForgotViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire
import TweeTextField

class ForgotViewController: BaseViewController {
    
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    @IBOutlet weak var emailTextField: TweeAttributedTextField!
    
    private var authViewModel = AuthViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forgot Password"
        emailTextField.setTextFieldProperties(placeholderString:"Email", isSecureText: false)
        emailTextField.delegate = self
        submitBtn.setDarkGreenTheme(btn: submitBtn, title: "RESET PASSWORD")
        captionLabel.setLabelCustomProperties(titleText: "You will receive an email from\nsupport@mytaxman.com.au", textColor: .lightGray, font:  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(12.0)), numberOfLines: 0, alignment: .center)
        
        // Do any additional setup after loading the view.
    }
    
    func redirectToRegisterScreen() {
        let vendorVC = VendorRegistrationViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(vendorVC, animated: true)
    }
    
    @IBAction func onTappedSubmitBtn(_ sender: UIButton) {
        let verifyEmail : ValidationMessage = authViewModel.validateEmailTextField(textField: emailTextField)
        if verifyEmail.status == false {
            self.validateTextField(textField: emailTextField)
        }
        else {
            LoadingIndicator.shared.show(forView: self.view)
            let params : Parameters = ["venemail" : emailTextField.text ?? ""]
            authViewModel.forgotPassword(input: params) { (result: OtpVerifyBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if let success = result.code, success == "1" {
                        self.presentAlert(withTitle: "", message: result.desc ?? "") {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else if result.code == "0" {
                        self.redirectToRegisterScreen()
                    }
                    else {
                        self.presentAlert(withTitle: error, message: result.desc ?? "")
                    }
                } else if let alert = alert {
                    print(alert.statusCode)
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
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
extension ForgotViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            textField.hideInfo()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let existText = textField.text,
            let textRange = Range(range, in: existText) else { return false }
        
        let newText = existText.replacingCharacters(in: textRange, with: string)
        
        switch textField {
        case emailTextField:
            if newText.isEmpty {
                emailTextField.rightViewMode = .always
            } else {
                emailTextField.rightViewMode = .never
                return 40 >= newText.count ? true : false
            }
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            self.validateTextField(textField: textField)
        }
    }
    
    fileprivate func validateTextField(textField:TweeAttributedTextField) {
        if textField == emailTextField {
            let nameValidation:ValidationMessage = authViewModel.validateEmailTextField(textField: emailTextField)
            
            if nameValidation.status == false {
                textField.showInfo(nameValidation.errorMessage ?? "")
                
            } else {
                textField.hideInfo()
            }
        }
    }
}
