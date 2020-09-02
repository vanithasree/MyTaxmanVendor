//
//  ServiceAreaViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 26/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import TweeTextField

class ServiceAreaViewController: BaseViewController {
    
    @IBOutlet weak var searchTextField: TweeAttributedTextField!
    @IBOutlet weak var locationTableView: UITableView!
    
    @IBOutlet weak var submitBtn: UIButton!
    var arrSelectedRows:[Int] = []
    
    var autocompleteResults :[GApiResponse.Autocomplete] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        // Do any additional setup after loading the view.
    }
    fileprivate func setupViewUI() {
        
        submitBtn.setDarkGreenTheme(btn: submitBtn, title: "Choose Location")
        searchTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),
                                   for: .editingChanged)
        
        searchTextField.setTextFieldProperties(placeholderString: "Choose Location", isSecureText: false)
        
        self.locationTableView.delegate = self
        self.locationTableView.dataSource = self
        self.locationTableView.register(GetPlacesTableViewCell.nib, forCellReuseIdentifier: GetPlacesTableViewCell.identifier)
        
        self.locationTableView.separatorStyle = .none
        self.locationTableView.backgroundColor = .clear
        self.locationTableView.estimatedRowHeight = 200
        self.locationTableView.rowHeight = UITableView.automaticDimension
        self.locationTableView.keyboardDismissMode = .onDrag;
        self.locationTableView.keyboardDismissMode = .interactive;
    }
    @objc func textFieldDidChange(textField: UITextField) {
        //  fetcher?.sourceTextHasChanged(textField.text!)
        if let text = textField.text {
            self.showResults(string:text)
        }
    }
    @IBAction func onTapSubmitBtn(_ sender: UIButton) {
    }
    fileprivate func showResults(string:String){
        var input = GInput()
        input.keyword = string
        GoogleApi.shared.callApi(input: input) { (response) in
            if response.isValidFor(.autocomplete) {
                DispatchQueue.main.async {
                    
                    self.autocompleteResults = response.data as! [GApiResponse.Autocomplete]
                    //self.autocompleteResults.append(<#T##newElement: GApiResponse.Autocomplete##GApiResponse.Autocomplete#>)
                    self.arrSelectedRows.removeAll()
                    //self.showOrHideTableView()
                    self.locationTableView.reloadData()
                    
                }
            } else { print(response.error ?? "ERROR") }
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

extension ServiceAreaViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.autocompleteResults.count > 0){
            tableView.backgroundView = nil
            return 1
        }
        let noDataView : NoDataView = UIView.fromNib()
        noDataView.frame = tableView.bounds
        tableView.backgroundView = noDataView
        noDataView.setData(information: "No results found")
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.autocompleteResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GetPlacesTableViewCell.identifier) as? GetPlacesTableViewCell else {
            return UITableViewCell()
        }
        cell.accessoryType = .checkmark
        cell.tintColor = ColorManager.textLiteGreenColor.color
        if arrSelectedRows.contains(indexPath.row){
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        cell.addressLabel.text =    self.autocompleteResults[indexPath.row].formattedAddress
        cell.selectionStyle = .none
        return cell
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
        self.locationTableView.reloadData()
    }
}
