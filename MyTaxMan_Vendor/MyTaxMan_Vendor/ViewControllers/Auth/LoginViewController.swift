//
//  LoginViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 19/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire
import TweeTextField

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var passwordTextField: TweeAttributedTextField!
    @IBOutlet weak var emailMobileTextField: TweeAttributedTextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getStartedBtn: UIButton!
    @IBOutlet weak var bottomTitleLabel: UILabel!
    @IBOutlet weak var businessAccountLabel: UILabel!
    
    private var authViewModel = AuthViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViewUI() {
        
        isTransparent = true
        
        titleLabel.setLabelCustomProperties(titleText: "MyTaxman Business", textColor: .black, font: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(28.0)), numberOfLines: 1, alignment: .center)
        
        emailMobileTextField.setTextFieldProperties(placeholderString:"Email/Mobile Number", isSecureText: false)
        passwordTextField.setTextFieldProperties(placeholderString:"Password", isSecureText: true)
        
        emailMobileTextField.delegate = self
        passwordTextField.delegate = self
        
        loginBtn.setDarkGreenTheme(btn: loginBtn, title: "LOGIN")
        loginBtn.cornerRadius = 5.0
        
        
        forgotPasswordBtn.setButtonProperties(title: "FORGOT YOUR PASSWORD?", font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(10.0)), titleColor: ColorManager.darkGrey.color)
        businessAccountLabel.text = "Don't have a business account?"
        businessAccountLabel.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(12.0))
        businessAccountLabel.textColor = ColorManager.darkText.color
        
        let eyeShowButton = UIButton(type: .custom)
        eyeShowButton.setImage(UIImage(named: "eyeShow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        eyeShowButton.setImage(UIImage(named: "eyeHide")?.withRenderingMode(.alwaysTemplate), for: .selected)
        eyeShowButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        eyeShowButton.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 30), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        eyeShowButton.addTarget(self, action: #selector(self.showOrHide), for: .touchUpInside)
        eyeShowButton.tintColor = ColorManager.darkBGTheme.color
        passwordTextField.rightView = eyeShowButton
        passwordTextField.rightViewMode = .always
        
        getStartedBtn.setButtonProperties(title: "Get started", font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0)), titleColor: .systemBlue)
        bottomTitleLabel.setLabelCustomProperties(titleText: "- its free to browse jobs!", textColor: ColorManager.darkText.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 1, alignment: .left)
        
        emailMobileTextField.text = "9894909595"
        passwordTextField.text = "Qq123456"
        
    }
    
    @IBAction func showOrHide(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
        passwordTextField.isSecureTextEntry.toggle()
    }
    fileprivate func redirectToOtpScreenVC(mobileNumber:String) {
        let mobileVC = OTPViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        mobileVC.mobileNumberString = mobileNumber
        self.navigationController?.pushViewController(mobileVC, animated: true)
    }
    
    
    @IBAction func onTapGetStartedBtn(_ sender: UIButton) {
        let vendorScreeVC = VendorRegistrationViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(vendorScreeVC, animated: true)
    }
    @IBAction func onTapForgotPasswordBtn(_ sender: UIButton) {
        let forgotVC = ForgotViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    @IBAction func onTapLoginBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let verifyEmail : ValidationMessage = authViewModel.validateUsernameTextField(textField: emailMobileTextField)
        let verifyPassword : ValidationMessage = authViewModel.validatePasswordTextField(passwordTextField: passwordTextField)
        if verifyEmail.status && verifyPassword.status {
            let params: Parameters = [
                "venemail": emailMobileTextField.text ?? "",
                "venpassword": passwordTextField.text ?? ""
            ]
            LoadingIndicator.shared.show(forView: self.view)
            authViewModel.requestLogin(input: params) { (result: LoginBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if let success = result.code, success == "1" {
                        UserDetails.shared.setUserLoginData(data: try! JSONEncoder().encode(result))
                        self.redirectToDashboardVC()
                        
                    }
                    else  if let success = result.code, success == "3" {
                        self.redirectToOtpScreenVC(mobileNumber: "")
                    }
                    else
                    {
                        self.presentAlert(withTitle: "", message: result.desc ?? "") {}
                    }
                }
                else if let alert = alert {
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
            }
        }
        else {
            self.validateTextField(textField: emailMobileTextField)
            self.validateTextField(textField: passwordTextField)
        }
    }
    
    func redirectToDashboardVC() {
        let tabBar = TBViewController.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true) {
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

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            textField.hideInfo()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let existText = textField.text, let textRange = Range(range, in: existText) else { return false }
        let newText = existText.replacingCharacters(in: textRange, with: string)
        switch textField {
        case emailMobileTextField:
            if newText.isNumber {
                return 10 >= newText.count ? true : false
            } else {
                return 100 >= newText.count ? true : false
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
    
    func validateTextField(textField:TweeAttributedTextField) {
        if textField == emailMobileTextField {
            let nameValidation:ValidationMessage = authViewModel.validateUsernameTextField(textField: emailMobileTextField)
            if nameValidation.status == false {
                textField.showInfo(nameValidation.errorMessage ?? "")
            } else {
                textField.hideInfo()
            }
        } else if textField == passwordTextField {
            let passwordValidation:ValidationMessage = authViewModel.validatePasswordTextField(passwordTextField: passwordTextField)
            if passwordValidation.status == false {
                textField.showInfo(passwordValidation.errorMessage ?? "")
            } else {
                textField.hideInfo()
            }
        }
    }
}
