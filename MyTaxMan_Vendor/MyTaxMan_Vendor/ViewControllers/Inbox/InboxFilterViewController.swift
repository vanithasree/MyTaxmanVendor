//
//  InboxFilterViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Prem kumar on 02/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class InboxFilterViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet var filterTableView: UITableView!
    @IBOutlet var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViews()
    }
    func setupViews() {
        
        filterTableView.tableFooterView = UIView()
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.backgroundColor = ColorManager.white.color
        filterTableView.reloadData()
    }
    
    @IBAction func didTapCancelAction(_ sender: Any) {
    }
    
    @IBAction func didTapResetAction(_ sender: Any) {
    }
    
    @IBAction func didTapApplyAction(_ sender: Any) {
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

extension InboxFilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension InboxFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utility.dynamicSize(60)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
