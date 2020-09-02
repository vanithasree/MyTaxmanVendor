//
//  ReviewListViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire
import WMSegmentControl

class ReviewListViewController: BaseViewController {
    
    @IBOutlet weak var segmentControl: WMSegment!
    
    @IBOutlet weak var reviewListTableView: UITableView!
    
    var notReviewedList : [NotReviewedList] = []
    var reviewedList : [ReviewListDesc] = []
    
    private var reviewViewModel = ReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getTechReviewList()
    }
    func setupViewUI() {
        self.title = "Reviews"
        segmentControl.selectorType = .bottomBar
        segmentControl.SelectedFont = UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0))!
        segmentControl.bottomBarHeight = 2.0
        segmentControl.borderColor = ColorManager.textLiteGreenColor.color
        segmentControl.selectorTextColor = ColorManager.textDarkGreenColor.color
        segmentControl.selectorColor = ColorManager.textDarkGreenColor.color
        segmentControl.normalFont = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(18.0))!
        //Using callbacks
        self.getNotReviewedList()
        segmentControl.onValueChanged = { index in
            print("I have selected index \(index) from WMSegment!")
            self.reviewListTableView.reloadData()
        }
        
        setupTableView()
    }
    fileprivate func setupTableView() {
        reviewListTableView.register(ReviewedListTableViewCell.nib, forCellReuseIdentifier: ReviewedListTableViewCell.identifier)
        reviewListTableView.register(NotReviewedListTableViewCell.nib, forCellReuseIdentifier: NotReviewedListTableViewCell.identifier)
        reviewListTableView.delegate = self
        reviewListTableView.separatorStyle = .none
        reviewListTableView.dataSource = self
        reviewListTableView.backgroundColor = ColorManager.white.color
        reviewListTableView.estimatedRowHeight = UITableView.automaticDimension
        reviewListTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func redirectToSendAReplyVC(data: ReviewListDesc?) {
        let replyVC = SendAReplyViewController.instantiateFromAppStoryboard(appStoryboard: .Reviews)
        replyVC.hidesBottomBarWhenPushed = true
        replyVC.reviewDetails = data
        self.navigationController?.pushViewController(replyVC, animated: true)
    }
    func redirectToJobDetail(data: NotReviewedList?) {
        let replyVC = JobDetailsViewController.instantiateFromAppStoryboard(appStoryboard: .Reviews)
        replyVC.hidesBottomBarWhenPushed = true
        replyVC.details = data
        self.navigationController?.pushViewController(replyVC, animated: true)
    }
    
}
extension ReviewListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        /*switch segmentControl.selectedSegmentIndex {
         case 0:
         if (self.reviewedList.count > 0){
         tableView.backgroundView = nil
         return 1
         }
         let noDataView : NoDataView = UIView.fromNib()
         noDataView.frame = tableView.bounds
         tableView.backgroundView = noDataView
         noDataView.setData(information: "No results found")
         return 0
         break
         case 1:
         if (self.notReviewedList.count > 0){
         tableView.backgroundView = nil
         return 1
         }
         let noDataView : NoDataView = UIView.fromNib()
         noDataView.frame = tableView.bounds
         tableView.backgroundView = noDataView
         noDataView.setData(information: "No results found")
         return 0
         break
         
         default:
         break
         }*/
        
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return self.reviewedList.count
        case 1:
            return self.notReviewedList.count
        default:
            break
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            guard let cell : ReviewedListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReviewedListTableViewCell.identifier) as? ReviewedListTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setCellData(data: self.reviewedList[indexPath.row])
            cell.sendAReplyAction = { [weak self] in
                print(indexPath.row)
                self?.redirectToSendAReplyVC(data:self?.reviewedList[indexPath.row])
            }
            return cell
            
        case 1:
            guard let cell : NotReviewedListTableViewCell = tableView.dequeueReusableCell(withIdentifier: NotReviewedListTableViewCell.identifier) as? NotReviewedListTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setCellData(data: self.notReviewedList[indexPath.row])
            cell.jobDetailsAction = { [weak self] in
                self?.redirectToJobDetail(data: self?.notReviewedList[indexPath.row])
            }
            return cell
            
            
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 44.0 // standard tableViewCell height
        tableView.rowHeight = UITableView.automaticDimension
        
        return UITableView.automaticDimension
        //return 200
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension ReviewListViewController  {
    func getNotReviewedList() {
        let input : Parameters = ["vendorid" : UserDetails.shared.userId ]
        LoadingIndicator.shared.show(forView: self.view)
        reviewViewModel.getNotReviewedListFromServer(input: input) { (result: NotReviewedListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.notReviewedList = result.notReviewedList ?? []
                    
                }
                else
                {
                    self.presentAlert(withTitle: "", message: "Please check the input") {}
                }
                doOnMain {
                    self.reviewListTableView.reloadData()
                }
            }
            else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    func getTechReviewList() {
        let input : Parameters = ["vendorid" : UserDetails.shared.userId ]
        LoadingIndicator.shared.show(forView: self.view)
        reviewViewModel.getReviewedListFromServer(input: input) { (result: ReviewedListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.reviewedList = result.desc ?? []
                    
                }
                else
                {
                    self.presentAlert(withTitle: "", message: "Please check the input") {}
                }
                doOnMain {
                    self.reviewListTableView.reloadData()
                }
            }
            else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}
