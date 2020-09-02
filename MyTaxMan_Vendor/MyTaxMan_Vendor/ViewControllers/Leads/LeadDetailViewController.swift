//
//  LeadDetailViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire

class LeadDetailViewController: BaseViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var quoteNowBtn: UIButton!
    @IBOutlet weak var ignoreLeadBtn: UIButton!
    var taskId : String = ""
    private var leadViewModel = LeadViewModel()
    var taskDetail : Ilist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewUI()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //  isHideNavigationBar = true
        self.getTaskDetail()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //   isHideNavigationBar = false
    }
    
    
    func setUpViewUI() {
        
        ignoreLeadBtn.setDarkGreenTheme(btn: ignoreLeadBtn, title: "IGNORE THE LEAD")
        quoteNowBtn.setDarkGreenTheme(btn: quoteNowBtn, title: "QUOTE NOW")
        
        detailTableView.register(MobileAndEmailTableViewCell.nib, forCellReuseIdentifier: MobileAndEmailTableViewCell.identifier)
        detailTableView.register(DetailHeaderViewTableViewCell.nib, forCellReuseIdentifier: DetailHeaderViewTableViewCell.identifier)
        detailTableView.register(taskDetailTableViewCell.nib, forCellReuseIdentifier: taskDetailTableViewCell.identifier)
        
        detailTableView.backgroundColor = .clear
        detailTableView.separatorStyle = .none
        detailTableView.estimatedRowHeight = 500
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    @objc func didTapTermsButtonOnStopService() {
        /* print("Terms Clicked")
         let termsVC = TermsAndConditionsViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
         termsVC.keyName = "Service Requests"
         self.navigationController?.pushViewController(termsVC, animated: true)*/
        
    }
    @IBAction func onTappedQuoteNowBtn(_ sender: UIButton) {
        let quoteVC = QuoteNowViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        quoteVC.quoteDetail = self.taskDetail
        self.navigationController?.pushViewController(quoteVC, animated: true)
    }
    
    
    @IBAction func onTapIgnoreBtn(_ sender: UIButton) {
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
extension LeadDetailViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell : DetailHeaderViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderViewTableViewCell.identifier) as? DetailHeaderViewTableViewCell else { return UITableViewCell() }
            cell.backAction = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            cell.setHeaderData(ilistData: self.taskDetail)
            cell.selectionStyle = .none
            return cell
            
        case 1:
            guard let cell : taskDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: taskDetailTableViewCell.identifier) as? taskDetailTableViewCell else { return UITableViewCell() }
            cell.setData(ilist: self.taskDetail)
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell : MobileAndEmailTableViewCell = tableView.dequeueReusableCell(withIdentifier: MobileAndEmailTableViewCell.identifier) as? MobileAndEmailTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            //cell.titleLabel.text = "Mobile Phone"
           // cell.valueLabel.text = self.taskDetail?.mobile ?? ""
           //cell.statusLabel.text = "VERIFIED"
            return cell
            
        case 3:
            guard let cell : MobileAndEmailTableViewCell = tableView.dequeueReusableCell(withIdentifier: MobileAndEmailTableViewCell.identifier) as? MobileAndEmailTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
          //  cell.titleLabel.text = "Email"
        //    cell.valueLabel.text = self.taskDetail?.email ?? ""
          //  cell.statusLabel.text = "VERIFIED"
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    /*  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     100
     }*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 120
        case 1:
            return UITableView.automaticDimension
        default:
            return 100
        }
    }
    /*  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     return 300
     /*  switch section {
     case 0:
     return UITableView.automaticDimension
     case 1:
     return 90
     default:
     return 70
     }*/
     }*/
    
    /*func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
     
     let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
     
     let titleLabel = UILabel(frame: CGRect(x:0,y: 0 ,width:footerView.frame.width,height:footerView.frame.height / 2 ))
     
     let termsBtn = UIButton(frame: CGRect(x:0,y: titleLabel.frame.origin.y + titleLabel.frame.height - 20,  width:footerView.frame.width,height:footerView.frame.height / 2 ))
     
     titleLabel.setFooterTitle(titleText: "By clicking submit, you are agree to our")
     titleLabel.numberOfLines = 0
     titleLabel.textColor = ColorManager.darkText.color
     
     let yourAttributes: [NSAttributedString.Key: Any] = [
     .font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(12.0))!,
     .foregroundColor: ColorManager.textThickDarkGreenColor.color,
     .underlineStyle: NSUnderlineStyle.single.rawValue]
     
     let attributeString = NSMutableAttributedString(string: "Terms & Conditions.",
     attributes: yourAttributes)
     termsBtn.setAttributedTitle(attributeString, for: .normal)
     //Set Target to your button only once.
     //termsBtn.addTarget(self, action: #selector(didTapTermsButtonOnStopService), for: .touchUpInside)
     
     
     titleLabel.textAlignment = .center
     footerView.addSubview(titleLabel)
     footerView.addSubview(termsBtn)
     
     footerView.backgroundColor = .clear
     return footerView
     
     }*/
}

extension LeadDetailViewController {
    func getTaskDetail() {
        let params: Parameters = [
            "taskid":self.taskId
        ]
        LoadingIndicator.shared.show(forView: self.view)
        leadViewModel.getTaskDetailsListFromServer(input: params) { (result: TaskDetailsBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    
                    if let ilistValue = result.desc?.ilist?.first {
                        self.title = ilistValue.category
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
