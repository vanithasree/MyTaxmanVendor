//
//  GetStartedViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 19/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginBgView: UIView!
    @IBOutlet weak var businessLabel: UILabel!
    @IBOutlet weak var findNewLeadsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTapNewLeadsBtn(_ sender: UIButton) {
        let vendorRegistrationVC = VendorRegistrationViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(vendorRegistrationVC, animated: true)
    }
    
    @IBAction func onTappedLoginBtn(_ sender: UIButton) {
        let vendorRegistrationVC = LoginViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(vendorRegistrationVC, animated: true)
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
