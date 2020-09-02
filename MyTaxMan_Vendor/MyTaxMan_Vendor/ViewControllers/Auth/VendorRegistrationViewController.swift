//
//  VendorRegistrationViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
protocol choosenServicesOrLocationDelegate {
    func choosenServicesFromTheList(services stringValue: String)
    func choosenLocationFromTheList(location stringValue: String)
}
class VendorRegistrationViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var servicesTitleLabel: UILabel!
    @IBOutlet weak var servicesValueLabel: UILabel!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationValueLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var servicesView: UIView!
    
    var servicesValueString: String = ""
    var locationValuString : String = ""
    var delegate : choosenServicesOrLocationDelegate?
    private var authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setViewUI() {
        self.title = "Step 1"
        
        self.titleLabel.setLabelCustomProperties(titleText: "Register to connect with new customers today", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(20.0)), numberOfLines: 0, alignment: .left)
        
        self.servicesTitleLabel.setLabelCustomProperties(titleText: "What services do you offer?", textColor: ColorManager.darkGrey.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(13.0)), numberOfLines: 0, alignment: .left)
        
        self.locationTitleLabel.setLabelCustomProperties(titleText: "Where are you based?", textColor: ColorManager.darkGrey.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(13.0)), numberOfLines: 0, alignment: .left)
        
        self.servicesValueLabel.setLabelCustomProperties(titleText: servicesValueString, textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        self.locationValueLabel.setLabelCustomProperties(titleText: locationValuString, textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        
        let serviceTap = UITapGestureRecognizer(target: self, action: #selector(singleServiceTapped))
        let locationTap = UITapGestureRecognizer(target: self, action: #selector(singleLocationTapped))
        locationTap.numberOfTapsRequired = 1
        serviceTap.numberOfTapsRequired = 1
        self.servicesView.addGestureRecognizer(serviceTap)
        self.locationView.addGestureRecognizer(locationTap)
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "NEXT")
    }
    
    
    @objc func singleServiceTapped() {
        // do something here
        let serviceVC = ServicesListViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        serviceVC.selectedServicesString = self.servicesValueString
        serviceVC.delegate = self
        self.navigationController?.pushViewController(serviceVC, animated: true)
    }
    @objc func singleLocationTapped() {
        // do something here
        let serviceVC = GetPlacesViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        serviceVC.delegate = self
        self.navigationController?.pushViewController(serviceVC, animated: true)
    }
    
    @IBAction func onTapNextBtn(_ sender: UIButton) {
        let serviceValidation : ValidationMessage = authViewModel.validateServicesText(text: self.servicesValueString)
        if serviceValidation.status == false {
            return self.showToast(message: "Please choose the services list")
        }
        
        let locationValidation : ValidationMessage = authViewModel.validateName(self.locationValuString)
        if locationValidation.status == false {
            return self.showToast(message: "Address should not be empty")
        }
        
        let vendorTwoVC = VendorRegistrationScreen2ViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        vendorTwoVC.serviceTypeString = self.servicesValueString
        vendorTwoVC.locationString = self.locationValuString
        self.navigationController?.pushViewController(vendorTwoVC, animated: true)
        
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
extension VendorRegistrationViewController : choosenServicesOrLocationDelegate {
    func choosenServicesFromTheList(services stringValue: String) {
        self.servicesValueString = stringValue
        self.servicesValueLabel.text = self.servicesValueString
    }
    
    func choosenLocationFromTheList(location stringValue: String) {
        self.locationValuString = stringValue
        self.locationValueLabel.text = self.locationValuString
    }
    
    
}
