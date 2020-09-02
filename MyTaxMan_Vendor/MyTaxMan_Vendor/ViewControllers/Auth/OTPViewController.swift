//
//  OTPViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import SVPinView
import Alamofire

class OTPViewController: UIViewController {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var sendAgainBtn: UIButton!
    @IBOutlet weak var didnotReceiveCodeLabel: UILabel!
    @IBOutlet weak var pinView: SVPinView!
    @IBOutlet weak var titleHeaderLabel: UILabel!
    var mobileNumberString : String = ""
    var vendorIdString : String = ""
    
    private var authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViewUI() {
        
        self.titleHeaderLabel.setLabelCustomProperties(titleText: "Verification code has been sent to the registered mobile number\n\(mobileNumberString)", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(23.0)), numberOfLines: 0, alignment: .center)
        
        
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "VERIFY")
        
        self.pinViewSetup()
        
    }
    fileprivate func pinViewSetup() {
        pinView.style = .underline
        pinView.activeBorderLineThickness = 1.5
        pinView.borderLineColor = ColorManager.darkText.color
        pinView.activeBorderLineColor = ColorManager.darkBGTheme.color
        pinView.backgroundColor = ColorManager.white.color
        //pinView.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0))!
        pinView.pinLength = 4
        pinView.keyboardType = .phonePad
        pinView.shouldSecureText = false
        pinView.interSpace = 10
        pinView.textColor = ColorManager.darkText.color
        pinView.pinInputAccessoryView = UIView()
        pinView.becomeFirstResponderAtIndex = 0
        pinView.didFinishCallback = { [weak self] pin in
            print("The pin entered is \(pin)")
            self?.sendOTPtoMobileNumber(pin: pin)
        }
    }
    
    func sendOTPtoMobileNumber(pin: String) {
        let params: Parameters = [
            "vendorid": vendorIdString,
            "otp":pin
        ]
        LoadingIndicator.shared.show(forView: self.view)
        authViewModel.vendorOTPVerification(input: params) { (result: LoginBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    UserDetails.shared.setUserLoginData(data: try! JSONEncoder().encode(result))
                    self.redirectToDashBoardScreen()
                    //}
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: result.desc ?? "")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    
    @IBAction func onTapResendBtn(_ sender: UIButton) {
        self.resendOtp()
    }
    func resendOtp() {
        let params: Parameters = [
            "customerid": vendorIdString,
        ]
        LoadingIndicator.shared.show(forView: self.view)
        authViewModel.vendorResendOTPVerification(input: params) { (result: OtpVerifyBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.presentAlert(withTitle: "", message: result.desc ?? "") {}
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: result.desc ?? "")
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
extension OTPViewController {
    func redirectToDashBoardScreen() {
        let tabBar = TBViewController.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true) {}
    }
}
