//
//  LeadsListViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire



class LeadsListViewController: BaseViewController {
    
    @IBOutlet weak var serviceAreaTitleLabel: UILabel!
    @IBOutlet weak var serviceAreaAddressLabel: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var leadsTitleLabel: UILabel!
    @IBOutlet weak var filterBtn: UIButton!
    
    private var leadViewModel = LeadViewModel()
    
    var currentPageCount : Int = 1
    var isNeedToCallApi : Bool = true
    
    var leadsList : [Leads] = []
    var totalLeadsCount : Int = 0
    
    
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupViewUI() {
        
        leadsTitleLabel.setLabelCustomProperties(titleText: "Leads(\(totalLeadsCount))", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(19.0)), numberOfLines: 0, alignment: .left)
        serviceAreaTitleLabel.setLabelCustomProperties(titleText: "Service Area", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(19.0)), numberOfLines: 0, alignment: .left)
        
        serviceAreaAddressLabel.setLabelCustomProperties(titleText: UserDetails.shared.userLoginData?.services_areas ?? "", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .natural)
        
        filterBtn.setGreenColor(btn: filterBtn, title: "FILTERS")
        viewBtn.setGreenColor(btn: viewBtn, title: "View")
        viewBtn.backgroundColor = .clear
        
        self.setupTableViews()
        
        self.getLeadListBasedOnPageCount(pageCount: currentPageCount)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isHideNavigationBar = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isHideNavigationBar = false
    }
    func setupTableViews() {
        listTableView.register(LeadsListTableViewCell.nib, forCellReuseIdentifier: LeadsListTableViewCell.identifier)
        listTableView.tableFooterView = UIView()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.backgroundColor = ColorManager.white.color
        listTableView.estimatedRowHeight = UITableView.automaticDimension
        listTableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func didTapServiceAreaViewBtn(_ sender: UIButton) {
        
        let serviceAreaVC = ServiceAreaViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        serviceAreaVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(serviceAreaVC, animated: true)
    }
    
    
    @IBAction func onTapFilterBtn(_ sender: UIButton) {
        let filterVC = FilterViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        filterVC.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        filterVC.choosenData = { stringOne, stringTwo in
            // do stuff
            print(stringOne,stringTwo)
            self.getLeadListByFilter(filterOption: stringOne, sortOption: stringTwo)
        }
        self.present(filterVC, animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func redirectToJobDetailVC(taskId:String) {
        let detailVC = LeadDetailViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.taskId = taskId
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
extension LeadsListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.leadsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : LeadsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: LeadsListTableViewCell.identifier) as? LeadsListTableViewCell else { return UITableViewCell() }
        cell.setCellDate(leadData: self.leadsList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.redirectToJobDetailVC(taskId: self.leadsList[indexPath.row].tasskid?.first?.tasskid ?? "")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
extension LeadsListViewController {
    //MARK:-
    func getLeadListByFilter(filterOption:String, sortOption:String) {
        
        let params: Parameters = [
            "vendorid":UserDetails.shared.userId,
            "filteroption" : filterOption,
            "sortoption":sortOption
        ]
        LoadingIndicator.shared.show(forView: self.view)
        leadViewModel.getLeadsListByFilter(pageNumber: "1", input:params) { (result: LeadsListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.totalLeadsCount  = Int(result.total_rows ?? "0") ?? 0
                    self.leadsTitleLabel.text = "Leads(\(self.totalLeadsCount))"
                    if let leadsCount = result.desc?.leads {
                        self.leadsList = leadsCount
                    }
                }
                else
                {
                    self.presentAlert(withTitle: "", message: "Please check the input") {}
                }
                doOnMain {
                    self.listTableView.reloadData()
                }
            }
            else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    
    
    func getLeadListBasedOnPageCount(pageCount:Int) {
        if self.isNeedToCallApi {
            let params: Parameters = [
                "page_no": "\(pageCount)",
                "vendorid": UserDetails.shared.userId
            ]
            LoadingIndicator.shared.show(forView: self.view)
            leadViewModel.getLeadsList(pageNumber: "\(pageCount)", input:params) { (result: LeadsListBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if let success = result.code, success == "1" {
                        self.totalLeadsCount  = Int(result.total_rows ?? "0") ?? 0
                        self.leadsTitleLabel.text = "Leads(\(self.totalLeadsCount))"
                        if let leadsCount = result.desc?.leads {
                            self.leadsList.append(contentsOf: leadsCount)
                        }
                    }
                    else
                    {
                        self.presentAlert(withTitle: "", message: "Please check the input") {}
                    }
                    doOnMain {
                        self.listTableView.reloadData()
                    }
                }
                else if let alert = alert {
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
            }
        }
    }
}
