//
//  ServicesListViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class ServicesListViewController: UIViewController {
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    var arrSelectedRows:[Int] = []
    var selectedServicesString : String = ""
    
    var optionsArray:[String] = ["Tax Returns", "Accounting", "Financial Planning", "Super Funds", "Audit", "Legal Advice"]
    var delegate : choosenServicesOrLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableViewUI()
        
        self.formData()
        // Do any additional setup after loading the view.
    }
    
    func formData() {
        if !selectedServicesString.isEmpty  {
            let selectedServices = selectedServicesString.split(separator: ",")
            for (index, value) in selectedServices.enumerated() {
                print("\(index):\(value)")
                if self.optionsArray.contains(String(value)) {
                    if let index = self.optionsArray.firstIndex(of: String(value)) {
                        self.arrSelectedRows.append(index)
                    }
                }
            }
        }
    }
    
    func setUpTableViewUI() {
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ServiceListTableViewCell.nib, forCellReuseIdentifier: ServiceListTableViewCell.identifier)
        listTableView.estimatedRowHeight = UITableView.automaticDimension
        listTableView.separatorStyle = .none
        listTableView.tableFooterView = UIView()
        listTableView.backgroundColor = .clear
        
        doneBtn.setDarkGreenTheme(btn: doneBtn, title: "DONE")
    }
    
    @IBAction func onTappedDoneBtn(_ sender: UIButton) {
        if self.arrSelectedRows.count > 0 {
            var tempArray : [String] = []
            for (index, value) in self.arrSelectedRows.enumerated() {
                print("\(index):\(value)")
                tempArray.append(self.optionsArray[value])
            }
            
            let finalString = tempArray.joined(separator: ",")
            self.delegate?.choosenServicesFromTheList(services: finalString)
            self.navigationController?.popViewController(animated: true)
        }
        else {
            self.showToast(message: "Please select atleast one")
        }
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
extension ServicesListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.optionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : ServiceListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ServiceListTableViewCell.identifier) as? ServiceListTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = self.optionsArray[indexPath.row]
        
        if arrSelectedRows.contains(indexPath.row){
            cell.checkBoxImageView.image = UIImage(named: "Checkbox")
        }else{
            cell.checkBoxImageView.image = UIImage(named: "Check")
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.arrSelectedRows.contains(indexPath.row)  {
            if let index = self.arrSelectedRows.firstIndex(of: indexPath.row) {
                self.arrSelectedRows.remove(at: index)
            }
        }
        else {
            self.arrSelectedRows.append(indexPath.row)
        }
        self.listTableView.reloadData()
    }
    
}

