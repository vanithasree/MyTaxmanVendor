//
//  AuthViewModel.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


struct ValidationMessage {
    var status: Bool = false
    var errorMessage:String?
    var tag:Int?
}
struct RegisterInput {
    var businessName: String?
    var contactName: String?
    var mobileNumber: String?
    var email:String?
    var password:String?
    var abn:String?
    // var imageData: String?
}

class AuthViewModel {
    
    var registerInputs: RegisterInput?
    
    func validateRegisterInputs() -> [ValidationMessage] {
        
        var result : [ValidationMessage] = []
        
        guard let registerInputs = registerInputs else {
            result.append(ValidationMessage(status: false, errorMessage: "Kindly fill all fields", tag: 1000))
            return result
        }
        let businessName =  validateBusinessName(text: registerInputs.businessName)
        let contactName = validateContactName(text: registerInputs.contactName)
        let mobile = validateMobile(registerInputs.mobileNumber)
        let email = validateEmail(registerInputs.email)
        let abn = validateAbnName(text: registerInputs.abn)
        let password = validatePassword(registerInputs.password)
        
        let validated = [businessName,contactName,mobile, email, abn, password]
        
        let fields = validated.filter({!$0.status})
        
        result.append(contentsOf: fields)
        return result
    }
    
    
    func validateServicesText(text:String?) -> ValidationMessage {
        guard let name = text, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage:"Services should not be empty", tag:1))
        }
        
        return (ValidationMessage(status: true, errorMessage: "", tag: 1))
    }
    func validateLocationText(text:String?) -> ValidationMessage {
        guard let name = text, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage:"Location should not be empty", tag:1))
        }
        
        return (ValidationMessage(status: true, errorMessage: "", tag: 1))
    }
    
    
    func validateEmailTextField(textField:UITextField) -> ValidationMessage {
        let emailString = textField.text
        guard let name = emailString, !name.isBlank, !name.isEmpty else {
            return (ValidationMessage(status: false, errorMessage: emailRequired, tag:0))
        }
        if emailString!.isContainsChar {
            if !(emailString!.isEmail) {
                return (ValidationMessage(status: false, errorMessage: emailValidationMessage, tag:0))
            }
        }
        return (ValidationMessage(status: true, errorMessage: "", tag:0))
    }
    
    func validateContactName(text:String?) -> ValidationMessage {
        
        let username = text
        guard let name = username, !name.isBlank, !name.isEmpty else {
            return (ValidationMessage(status: false, errorMessage: "Contact name field is required", tag:2))
        }
        return (ValidationMessage(status: true, errorMessage: "", tag:2))
    }
    
    func validateBusinessName(text:String?) -> ValidationMessage {
        
        let username = text
        guard let name = username, !name.isBlank, !name.isEmpty else {
            return (ValidationMessage(status: false, errorMessage: "Business name field is required", tag:1))
        }
        return (ValidationMessage(status: true, errorMessage: "", tag:1))
    }
    func validateAbnName(text:String?) -> ValidationMessage {
        
        let username = text
        guard let name = username, !name.isBlank, !name.isEmpty else {
            return (ValidationMessage(status: false, errorMessage: "ABN field is required", tag:10))
        }
        /* if !username?.isValidABNNumber() {
         return (ValidationMessage(status: false, errorMessage: "Please enter the valid ABN number", tag:10))
         }*/
        return (ValidationMessage(status: true, errorMessage: "", tag:10))
    }
    
    func validateUsernameTextField(textField:UITextField) -> ValidationMessage {
        
        let username = textField.text
        guard let name = username, !name.isBlank, !name.isEmpty else {
            return (ValidationMessage(status: false, errorMessage: userNameRequired, tag:0))
        }
        if username!.isContainsChar {
            if !(username!.isEmail) {
                return (ValidationMessage(status: false, errorMessage: emailValidationMessage, tag:0))
            }
        }
        else if !(username!.isMobileNumber) {
            return (ValidationMessage(status: false, errorMessage: mobileValidationMessage, tag:0))
        }
        return (ValidationMessage(status: true, errorMessage: "", tag:0))
    }
    
    func validatePasswordTextField(passwordTextField:UITextField) -> ValidationMessage {
        let passwordStr = passwordTextField.text
        guard let password = passwordStr, !password.isBlank else {
            return (ValidationMessage(status: false, errorMessage: passwordRequired, tag: 1))
        }
        
        if password.isValidPassword {
            return (ValidationMessage(status: true, errorMessage: "", tag: 5))
        } else {
            return (ValidationMessage(status: false, errorMessage: "Password should be minimum 6 characters", tag: 5))
            //            return (ValidationMessage(status: false, errorMessage: "Password should be 5 to 16, must use uppercase, lowercase, numbers and symbols !@#$%^&*()\\-_=+{}|?>.<,:;~`’", tag: 5))
        }
        //        return (ValidationMessage(status: true, errorMessage: "", tag:1))
        
        /* if passwordStr!.isValidPassword {
         return (ValidationMessage(status: true, errorMessage: "", tag: 1))
         } else {
         return (ValidationMessage(status: false, errorMessage: "Password should be 5 to 16", tag: 1))
         }*/
    }
    
    
    func validateNameForSignup(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage:nameRequired, tag:1))
        }
        
        if name.count  >= 2 {
            return (ValidationMessage(status: true, errorMessage: "", tag: 1))
        }
        else {
            return (ValidationMessage(status: false, errorMessage: "Name should be greater than 2 characters", tag: 1))
        }
        
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 1))
         } else {
         return (ValidationMessage(status: false, errorMessage: "First name length should be 3 to 32", tag: 1))
         }*/
    }
    
    
    func validateName(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage:nameRequired, tag:1))
        }
        if name.count  >= 2 {
            return (ValidationMessage(status: true, errorMessage: "", tag: 1))
        }
        else {
            return (ValidationMessage(status: false, errorMessage: "Name should be greater than 2 characters", tag: 1))
        }
        
        //        return (ValidationMessage(status: true, errorMessage: "", tag: 1))
        
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 1))
         } else {
         return (ValidationMessage(status: false, errorMessage: "First name length should be 3 to 32", tag: 1))
         }*/
        
        
    }
    func validateCompanyName(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage:"Company name field is required", tag:1000))
        }
        return (ValidationMessage(status: true, errorMessage: "", tag: 1000))
        
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 1))
         } else {
         return (ValidationMessage(status: false, errorMessage: "First name length should be 3 to 32", tag: 1))
         }*/
        
    }
    
    func validateOtherMobile(_ number: String?) -> ValidationMessage {
        
        guard let number = number, !number.isBlank else {
            return (ValidationMessage(status: false, errorMessage: "Other number field is required", tag:2000))
        }
        
        if number.isPhone() {
            return (ValidationMessage(status: true, errorMessage: "", tag: 2000))
        }
        else {
            return (ValidationMessage(status: false, errorMessage: "Other number is invalid", tag: 2000))
        }
        
        /*  if number.isMobileNumber {
         return (ValidationMessage(status: true, errorMessage: "", tag: 3))
         } else {
         return (ValidationMessage(status: false, errorMessage: "Mobile number length should be 8 to 11", tag: 3))
         }*/
        
    }
    
    func validateMobile(_ number: String?) -> ValidationMessage {
        
        let mobilenumber = ValidationManager().getMobileNumber(mobileNumber: number ?? "")
        
        if mobilenumber.isBlank {
            return (ValidationMessage(status: false, errorMessage: mobileNumberRequired, tag:3))
        }
        
        if !(mobilenumber.isMobileNumber) {
            return (ValidationMessage(status: false, errorMessage: mobileValidationMessage, tag:0))
        }
        
        /*   if number.isPhone() {
         return (ValidationMessage(status: true, errorMessage: "", tag: 3))
         }
         else {
         return (ValidationMessage(status: false, errorMessage: "Contact number is invalid", tag: 3))
         }*/
        
        return (ValidationMessage(status: true, errorMessage: "", tag: 3))
        
        /*  if number.isMobileNumber {
         return (ValidationMessage(status: true, errorMessage: "", tag: 3))
         } else {
         return (ValidationMessage(status: false, errorMessage: "Mobile number length should be 8 to 11", tag: 3))
         }*/
        
    }
    
    func validateEmail(_ email: String?) -> ValidationMessage {
        
        guard let email = email, !email.isBlank else {
            return (ValidationMessage(status: false, errorMessage: emailRequired, tag: 4))
        }
        
        if email.isEmail {
            return (ValidationMessage(status: true, errorMessage: "", tag: 4))
        } else {
            return (ValidationMessage(status: false, errorMessage: emailValidationMessage, tag: 4))
        }
    }
    
    
    func validatePassword(_ password: String?) -> ValidationMessage {
        guard let password = password, !password.isBlank else {
            return (ValidationMessage(status: false, errorMessage: passwordRequired, tag: 5))
        }
        
        if password.isValidPassword {
            return (ValidationMessage(status: true, errorMessage: "", tag: 5))
        } else {
            return (ValidationMessage(status: false, errorMessage: "Password should be minimum 6 characters", tag: 5))
            //            return (ValidationMessage(status: false, errorMessage: "Password should be 5 to 16, must use uppercase, lowercase, numbers and symbols !@#$%^&*()\\-_=+{}|?>.<,:;~`’", tag: 5))
        }
    }
    
    func validateNewPassword(_ password: String?) -> ValidationMessage {
        guard let password = password, !password.isBlank else {
            return (ValidationMessage(status: false, errorMessage: "Please enter new password!", tag: 10))
        }
        
        if password.isValidPassword {
            return (ValidationMessage(status: true, errorMessage: "", tag: 10))
        } else {
            return (ValidationMessage(status: false, errorMessage: "Password should be minimum 6 characters", tag: 10))
            //            return (ValidationMessage(status: false, errorMessage: "Password should be 5 to 16, must use uppercase, lowercase, numbers and symbols !@#$%^&*()\\-_=+{}|?>.<,:;~`’", tag: 5))
        }
    }
    
    func validateConfirmPassword(_ confirmPassword: String?, password: String?) -> ValidationMessage {
        guard let confirmPassword = confirmPassword, !confirmPassword.isBlank else {
            return (ValidationMessage(status: false, errorMessage: conformPasswordRequired, tag: 6))
        }
        
        if let password = password, confirmPassword != password {
            return (ValidationMessage(status: false, errorMessage: passwordSame, tag: 6))
        }
        return (ValidationMessage(status: true, errorMessage: "", tag: 6))
    }
    
    
    func validateMeterNumber(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage: meterNumberRequired, tag:100))
        }
        
        if name.count < 9 {
            return (ValidationMessage(status: false, errorMessage: "Meter number should be 9 characters", tag: 100))
        }
        
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 100))
         } else {
         return (ValidationMessage(status: false, errorMessage: "Meter number length should be 3 to 32", tag: 100))
         }*/
        return (ValidationMessage(status: true, errorMessage: "", tag: 100))
        
    }
    func validateTRNNumber(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage: trnRequired, tag:300))
        }
        if name.count < 9 {
            return (ValidationMessage(status: false, errorMessage: "TRN should be 9 characters", tag: 300))
        }
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 100))
         } else {
         return (ValidationMessage(status: false, errorMessage: "TRN number length should be 3 to 32", tag: 100))
         }*/
        return (ValidationMessage(status: true, errorMessage: "", tag: 300))
    }
    
    func validateAddressLine1(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage: addressLine1Required, tag:105))
        }
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 100))
         } else {
         return (ValidationMessage(status: false, errorMessage: "TRN number length should be 3 to 32", tag: 100))
         }*/
        return (ValidationMessage(status: true, errorMessage: "", tag: 105))
    }
    func validateAddressLine2(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: true, errorMessage: addressLine2Required, tag:106))
        }
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 100))
         } else {
         return (ValidationMessage(status: false, errorMessage: "TRN number length should be 3 to 32", tag: 100))
         }*/
        return (ValidationMessage(status: true, errorMessage: "", tag: 106))
    }
    
    func validateAddressLine3(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: true, errorMessage: addressLine3Required, tag:107))
        }
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 100))
         } else {
         return (ValidationMessage(status: false, errorMessage: "TRN number length should be 3 to 32", tag: 100))
         }*/
        return (ValidationMessage(status: true, errorMessage: "", tag: 107))
    }
    func validateParish(_ name: String?) -> ValidationMessage {
        guard let name = name, !name.isBlank else {
            return (ValidationMessage(status: false, errorMessage: parishRequired, tag:108))
        }
        
        if name.lowercased() == "parish" {
            return (ValidationMessage(status: false, errorMessage: parishRequired, tag:108))
        }
        /* if name.isName {
         return (ValidationMessage(status: true, errorMessage: "", tag: 100))
         } else {
         return (ValidationMessage(status: false, errorMessage: "TRN number length should be 3 to 32", tag: 100))
         }*/
        return (ValidationMessage(status: true, errorMessage: "", tag: 108))
    }
}

extension AuthViewModel {
    
    func requestLogin(input: Parameters, handler: @escaping (_ user: LoginBase?, _ error: AlertMessage?)->()) {
        AuthApiManager().requestLogIn(input: input, handler: handler)
    }
    func registerBusinessProfile(input: Parameters, handler: @escaping (_ user: RegisterBase?, _ error: AlertMessage?)->()) {
        AuthApiManager().requestSignup(input: input, handler: handler)
    }
    func vendorOTPVerification(input: Parameters, handler: @escaping (_ user: LoginBase?, _ error: AlertMessage?)->()) {
        AuthApiManager().requestOtpVerification(input: input, handler: handler)
    }
    func vendorResendOTPVerification(input: Parameters, handler: @escaping (_ user: OtpVerifyBase?, _ error: AlertMessage?)->()) {
        AuthApiManager().requestResendOtp(input: input, handler: handler)
    }
    func forgotPassword(input: Parameters, handler: @escaping (_ user: OtpVerifyBase?, _ error: AlertMessage?)->()) {
        AuthApiManager().requestForgotPassword(input: input, handler: handler)
    }
}
