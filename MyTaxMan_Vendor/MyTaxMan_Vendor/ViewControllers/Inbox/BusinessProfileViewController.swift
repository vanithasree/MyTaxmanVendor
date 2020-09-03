//
//  BusinessProfileViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
class BusinessProfileViewController: UIViewController {
    @IBOutlet var profileTableView: UITableView!
    var inbox: Inboxlist?
    private var inboxViewModel = InboxViewModel()
    var vendorProfile : VendorProfile_Base?
    @IBOutlet var browseLeadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        requestVenProfile()
    }
    
    func setupViews(){
        profileTableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.identifier)
        profileTableView.register(JobStatusTableViewCell.nib, forCellReuseIdentifier: JobStatusTableViewCell.identifier)
        profileTableView.register(JobHeaderView.nib, forHeaderFooterViewReuseIdentifier: JobHeaderView.identifier)
        profileTableView.tableFooterView = UIView()
        profileTableView.estimatedRowHeight = UITableView.automaticDimension
        profileTableView.reloadData()
        
        browseLeadButton.setGreenColor(btn: browseLeadButton, title: "Browse Leads")
    }
    @IBAction func didTapBrowseLeadAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
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

extension BusinessProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell : JobStatusTableViewCell = tableView.dequeueReusableCell(withIdentifier:
                JobStatusTableViewCell.identifier) as? JobStatusTableViewCell else { return UITableViewCell() }
            cell.setJobStatusValue(vendorProfile : vendorProfile, index: indexPath.row)
            return cell
        case 1:
            guard let cell : JobStatusTableViewCell = tableView.dequeueReusableCell(withIdentifier: JobStatusTableViewCell.identifier) as? JobStatusTableViewCell else { return UITableViewCell() }
            cell.setContactValue(vendorProfile : vendorProfile, index: indexPath.row)
            return cell
        case 2:
            guard let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) as? QuoteTableViewCell else { return UITableViewCell() }
            cell.setJobValue(vendorProfile : vendorProfile, index: indexPath.row)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobHeaderView.identifier) as? JobHeaderView else{
            return UIView()
        }
        headerView.backgroundColor = .clear
        switch section {
        case 0:
            return UIView()
            //headerView.titleLabel.text = "Job Status"
        case 1:
            headerView.titleLabel.text = "Contact Details"
            break
        case 2:
            headerView.titleLabel.text = "Job Details"
            break
        default:
            break
        }
        return headerView
    }
}

extension BusinessProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : Utility.dynamicSize(50)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension
        case 2:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
}

extension BusinessProfileViewController {
    func requestVenProfile() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "vendorid" : inbox?.vendorid ?? "",
        ]
        inboxViewModel.requestVenProfile(input: params) { (result: VendorProfile_Base?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.vendorProfile = result
                    doOnMain {
                        self.profileTableView.reloadData()
                    }
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: "Try again")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}
