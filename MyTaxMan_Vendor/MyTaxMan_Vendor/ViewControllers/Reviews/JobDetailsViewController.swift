//
//  JobDetailsViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 01/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire
struct DetailsData {
    var title = ""
    var value = ""
    var isStatusImageViewVisible : Bool = false
}

class JobDetailsViewController: BaseViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var details : NotReviewedList? = nil
    private var leadViewModel = LeadViewModel()
    var taskDetail : Ilist?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.details?.category ?? ""
        setupTableView()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getTaskDetail()
    }
    
    func setupTableView() {
        detailTableView.register(taskDetailTableViewCell.nib, forCellReuseIdentifier: taskDetailTableViewCell.identifier)
        detailTableView.backgroundColor = .clear
        detailTableView.separatorStyle = .none
        detailTableView.estimatedRowHeight = 50
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.delegate = self
        detailTableView.dataSource = self
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

extension JobDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : taskDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: taskDetailTableViewCell.identifier) as? taskDetailTableViewCell else { return UITableViewCell() }
        if let taskDetailValue = self.taskDetail {
            cell.setData(ilist: taskDetailValue)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension JobDetailsViewController {
    
    fileprivate func getTaskDetail() {
        let params: Parameters = [
            "taskid":self.details?.taskid ?? ""
        ]
        LoadingIndicator.shared.show(forView: self.view)
        leadViewModel.getTaskDetailsListFromServer(input: params) { (result: TaskDetailsBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    
                    if let ilistValue = result.desc?.ilist?.first {
                        self.taskDetail = ilistValue
                    }
                } else {
                    self.presentAlert(withTitle: "", message: "Please check the input") {}
                }
                
                doOnMain {
                    self.detailTableView.reloadData()
                }
                
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    
    
}
