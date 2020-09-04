//
//  WalletViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 04/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire
import WMSegmentControl

class WalletViewController: BaseViewController {
    
    @IBOutlet weak var segmentControl: WMSegment!
    @IBOutlet weak var walletTableView: UITableView!
    
    var profileDetails : VenProfileBase?
    private var profileViewModel = ProfileViewModel()
    var paymentHistory : [Payment_history] = []
    var creditHistory : [Credits_used_details] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyTaxman Wallet"
        setupSegment()
        setupTableView()
        self.getCreditHistory()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getPaymentHistory()
    }
    
    func setupSegment() {
        segmentControl.selectorType = .bottomBar
        segmentControl.SelectedFont = UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(15.0))!
        segmentControl.bottomBarHeight = 2.0
        segmentControl.borderColor = ColorManager.textLiteGreenColor.color
        segmentControl.selectorTextColor = ColorManager.textDarkGreenColor.color
        segmentControl.selectorColor = ColorManager.textDarkGreenColor.color
        segmentControl.normalFont = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(15.0))!
        segmentControl.onValueChanged = { index in
            print("I have selected index \(index) from WMSegment!")
            self.walletTableView.reloadData()
        }
    }
    func setupTableView() {
        walletTableView.register(WalletTableViewCell.nib, forCellReuseIdentifier: WalletTableViewCell.identifier)
        walletTableView.register(PaymentHistoryTableViewCell.nib, forCellReuseIdentifier: PaymentHistoryTableViewCell.identifier)
        walletTableView.delegate = self
        walletTableView.separatorStyle = .none
        walletTableView.dataSource = self
        walletTableView.backgroundColor = ColorManager.white.color
        walletTableView.estimatedRowHeight = UITableView.automaticDimension
        walletTableView.rowHeight = UITableView.automaticDimension
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
extension WalletViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return self.paymentHistory.count
        case 2:
            return self.creditHistory.count
        default:
            break
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            
            guard let cell : WalletTableViewCell = tableView.dequeueReusableCell(withIdentifier: WalletTableViewCell.identifier) as? WalletTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            if let profile = self.profileDetails {
                cell.walletBalanceValueLabel.text = profile.desc?.first?.wallet_balance ?? "0"
            }
            cell.rechargeButtonAction = {[weak self] (amount) in
                if amount.isEmpty {
                    self?.showToast(message: "Please choose any one")
                }
                else {
                    let checkOutVC = CheckOutViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
                    checkOutVC.hidesBottomBarWhenPushed = true
                    checkOutVC.choosenAmount = amount
                    self?.navigationController?.pushViewController(checkOutVC, animated: true)
                }
            }
            return cell
            
        case 1:
            guard let cell : PaymentHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: PaymentHistoryTableViewCell.identifier) as? PaymentHistoryTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setPaymentHistoryData(data: self.paymentHistory[indexPath.row])
            return cell
        case 2:
            guard let cell : PaymentHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: PaymentHistoryTableViewCell.identifier) as? PaymentHistoryTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setCreditHistoryData(data: self.creditHistory[indexPath.row])
            return cell
            
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return 400
        default:
            tableView.estimatedRowHeight = 44.0 // standard tableViewCell height
            tableView.rowHeight = UITableView.automaticDimension
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension WalletViewController {
    func getPaymentHistory() {
        let params : Parameters = [
            "vendorid" : UserDetails.shared.userId]
        LoadingIndicator.shared.show(forView: self.view)
        profileViewModel.getPaymentHistoryDetails(input: params) { (result: VenPaymentHistoryBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result{
                if let success = result.code, success == "1" {
                    self.paymentHistory = result.payment_history ?? []
                }
                else {
                    self.presentAlert(withTitle: "", message: "") {}
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    func getCreditHistory() {
        let params : Parameters = [
            "vendorid" : UserDetails.shared.userId]
        LoadingIndicator.shared.show(forView: self.view)
        profileViewModel.getCreditHistoryDetails(input: params) { (result: VenCreditHistoryBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result{
                if let success = result.code, success == "1" {
                    self.creditHistory = result.credits_used_details ?? []
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
