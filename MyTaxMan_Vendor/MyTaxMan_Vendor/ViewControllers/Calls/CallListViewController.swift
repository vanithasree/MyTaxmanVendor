//
//  CallListViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire

class CallListViewController: BaseViewController {
    
    @IBOutlet weak var callListTableView: UITableView!
    
    private var callViewModel = CallViewModel()
    var callHistoryList : [CallHistroyIlist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calls"
        setupTableView()
        self.getCallHistory()
        let image = UIImage(named: "verticalDots")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let rightBarButtonItem = UIBarButtonItem(image:image, style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        // Do any additional setup after loading the view.
    }
    @objc func addTapped(){
        // self.redirectToSubmitTaskVC()
        let menuOptionVC = MenuOptionViewController.instantiateFromAppStoryboard(appStoryboard: .Calls)
        menuOptionVC.modalPresentationStyle = .fullScreen
        menuOptionVC.optionList = ["Call Settings"]
        menuOptionVC.callSettingsAction = {[weak self] in
            print("Call Settings Clicked")
            self?.redirectToCallSettings()
        }
        let navigationController = UINavigationController(rootViewController: menuOptionVC)
        navigationController.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(navigationController, animated: true, completion: {})
    }
    
    func redirectToCallSettings() {
        let menuOptionVC = CallSettingsViewController.instantiateFromAppStoryboard(appStoryboard: .Calls)
        self.navigationController?.pushViewController(menuOptionVC, animated: true)
    }
    
    
    func setupTableView() {
        callListTableView.register(CallListTableViewCell.nib, forCellReuseIdentifier: CallListTableViewCell.identifier)
        callListTableView.tableFooterView = UIView()
        callListTableView.delegate = self
        callListTableView.separatorStyle = .none
        callListTableView.dataSource = self
        callListTableView.backgroundColor = ColorManager.white.color
        callListTableView.estimatedRowHeight = UITableView.automaticDimension
        callListTableView.rowHeight = UITableView.automaticDimension
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

extension CallListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.callHistoryList.count > 0){
            tableView.backgroundView = nil
            return 1
        }
        let noDataView : NoDataView = UIView.fromNib()
        noDataView.frame = tableView.bounds
        tableView.backgroundView = noDataView
        noDataView.setData(information: "No Calls Yet")
        return 0
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.callHistoryList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : CallListTableViewCell = tableView.dequeueReusableCell(withIdentifier: CallListTableViewCell.identifier) as? CallListTableViewCell else { return UITableViewCell() }
        cell.setCallData(data: self.callHistoryList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

extension CallListViewController {
    func getCallHistory() {
        let params: Parameters = [
            "vendorid":UserDetails.shared.userId
        ]
        LoadingIndicator.shared.show(forView: self.view)
        callViewModel.callVendorCallHistory(input: params) { (result: CallHistoryBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.callHistoryList = result.desc?.ilist ?? []
                }
                else
                {
                    self.presentAlert(withTitle: "", message: "Please check the input") {}
                }
                doOnMain {
                    self.callListTableView.reloadData()
                }
            }
            else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}
