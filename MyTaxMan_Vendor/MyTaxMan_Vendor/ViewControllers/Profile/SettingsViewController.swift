//
//  SettingsViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire


class SettingsViewController: BaseViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var titleArrays = ["Profile score", "Service area", "Service types", "Business details", "Contact details", "Wallet"]
    private var profileViewModel = ProfileViewModel()
    var isNeedToLoadApi : Bool = true
    var profileDetailsBase : VenProfileBase?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func setupTableView() {
        settingsTableView.register(CallSettingsTableViewCell.nib, forCellReuseIdentifier: CallSettingsTableViewCell.identifier)
        settingsTableView.register(ProfileHeaderTableViewCell.nib, forCellReuseIdentifier: ProfileHeaderTableViewCell.identifier)
        settingsTableView.tableFooterView = UIView()
        settingsTableView.delegate = self
        settingsTableView.separatorStyle = .none
        settingsTableView.dataSource = self
        settingsTableView.backgroundColor = ColorManager.white.color
        settingsTableView.estimatedRowHeight = UITableView.automaticDimension
        settingsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.getProfileDetails()
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
extension SettingsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.profileDetailsBase != nil {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.titleArrays.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell : ProfileHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderTableViewCell.identifier) as? ProfileHeaderTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            if let profile = self.profileDetailsBase {
                cell.setCellData(data: profile)
            }
            return cell
        }
        else {
            guard let cell : CallSettingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CallSettingsTableViewCell.identifier) as? CallSettingsTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.titleLabel.text = self.titleArrays[indexPath.row - 1]
            if let profile = self.profileDetailsBase {
                switch indexPath.row {
                case 1:
                    cell.valueLabel.text = "\(profile.profile_score ?? 0)/100"
                case 2:
                    cell.valueLabel.text = profile.desc?.first?.service_areas ?? ""
                case 3:
                    cell.valueLabel.text = profile.desc?.first?.service_types ?? ""
                case 4:
                    cell.valueLabel.text = "Business name, ABN, Street address, Location"
                case 5:
                    cell.valueLabel.text = "Contact person, Mobile number, Landline, Email"
                case 6:
                    cell.valueLabel.text = "Credit balance and Transcation history"
                default:
                    break
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.redirectToProfileScoreVC()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 44.0 // standard tableViewCell height
        tableView.rowHeight = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension SettingsViewController {
    
    func redirectToProfileScoreVC() {
        let scoreVC = ProfileScoreViewController.instantiateFromAppStoryboard(appStoryboard: .Profile)
        scoreVC.hidesBottomBarWhenPushed = true
        scoreVC.profileDetailsBaseForScoreScreen = self.profileDetailsBase
        self.navigationController?.pushViewController(scoreVC, animated: true)
    }
    
    
    
    func getProfileDetails() {
        if isNeedToLoadApi {
            
            let params: Parameters = [
                "vendorid":UserDetails.shared.userId
            ]
            LoadingIndicator.shared.show(forView: self.view)
            
            profileViewModel.getVendorProfile(input: params) { (result: VenProfileBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if let success = result.code, success == "1" {
                        self.profileDetailsBase = result
                    }
                    else
                    {
                        self.presentAlert(withTitle: "", message: "Please check the input") {}
                    }
                    doOnMain {
                        self.settingsTableView.reloadData()
                    }
                }
                else if let alert = alert {
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
            }
        }
    }
}
