//
//  ChatListViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire
class ChatListViewController: UIViewController {
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    private var inboxViewModel = InboxViewModel()
    var inboxList: [Inboxlist] = [] {
        didSet{
            doOnMain {
                self.chatTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Inbox"
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        requestCusinboxlist()
    }
    
    func setupViews() {
        let viewFN = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
        viewFN.backgroundColor = .clear
        let filterBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
        filterBtn.addTarget(self, action: #selector(self.filterAction), for: .touchUpInside)
        filterBtn.setGreenColor(btn: filterBtn, title: "FILTERS")
        filterBtn.backgroundColor = .clear
        viewFN.addSubview(filterBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewFN)
        
        searchTextField.placeholder = "Search..."
        searchTextField.delegate = self
        searchTextField.setRightPaddingImage(40, image: UIImage(named: "search")!, color: ColorManager.darkText.color)

        chatTableView.register(ChatTableViewCell.nib, forCellReuseIdentifier: ChatTableViewCell.identifier)
        chatTableView.tableFooterView = UIView()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.backgroundColor = ColorManager.white.color
        chatTableView.reloadData()

    }

    @objc func filterAction() {
        print("Filter")
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

extension ChatListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if (inboxList.count > 0){
            tableView.backgroundView = nil
            return 1
        }
        let noDataView : NoDataView = UIView.fromNib()
        noDataView.frame = tableView.bounds
        tableView.backgroundView = noDataView
        noDataView.setData(information: "You can start messaging with a business once they have sent you a quote")
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier) as? ChatTableViewCell else { return UITableViewCell() }
        cell.setValue(data: inboxList[indexPath.row])
        return cell
    }
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utility.dynamicSize(100)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inboxDetailsVC = InboxDetailsViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        inboxDetailsVC.hidesBottomBarWhenPushed = true
        inboxDetailsVC.inbox = inboxList[indexPath.row]
        self.navigationController?.pushViewController(inboxDetailsVC, animated: true)
    }
}

extension ChatListViewController {
    func requestCusinboxlist() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
        ]
        inboxViewModel.requestCusinboxlist(input: params) { (result: InboxListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.inboxList = result.desc?.ilist ?? []
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: "")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}

extension ChatListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
