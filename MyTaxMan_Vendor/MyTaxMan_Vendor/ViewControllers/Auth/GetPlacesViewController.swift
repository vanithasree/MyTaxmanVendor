//
//  GetPlacesViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 25/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import GooglePlaces
import TweeTextField

class GetPlacesViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var locationSearchTextField: TweeAttributedTextField!
    
    
    var delegate : choosenServicesOrLocationDelegate?
    
    var locationAddress : String = ""
    var autocompleteResults :[GApiResponse.Autocomplete] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViewUI() {
        
        
        
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText: "Where do you want it?")
        
        locationSearchTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),
                                           for: .editingChanged)
        
        
        locationSearchTextField.setTextFieldProperties(placeholderString: "Choose Location", isSecureText: false)
       
        
        doneBtn.setDarkGreenTheme(btn: doneBtn, title: "DONE")
        checkifLocationChoosen()
        showOrHideTableView()
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.register(GetPlacesTableViewCell.nib, forCellReuseIdentifier: GetPlacesTableViewCell.identifier)
        
        self.listTableView.separatorStyle = .none
        self.listTableView.backgroundColor = .clear
        self.listTableView.estimatedRowHeight = 200
        self.listTableView.rowHeight = UITableView.automaticDimension
    }
    @objc func textFieldDidChange(textField: UITextField) {
        //  fetcher?.sourceTextHasChanged(textField.text!)
        if let text = textField.text {
            self.showResults(string:text)
        }
    }
    
    @IBAction func onTappedDoneBtn(_ sender: UIButton) {
        if !self.locationAddress.isEmpty {
            self.delegate?.choosenLocationFromTheList(location: self.locationAddress)
            self.navigationController?.popViewController(animated: true)
        }
        else {
            self.showToast(message: "Location address should not be empty")
        }
    }
    
    fileprivate func showResults(string:String){
        var input = GInput()
        input.keyword = string
        GoogleApi.shared.callApi(input: input) { (response) in
            if response.isValidFor(.autocomplete) {
                DispatchQueue.main.async {
                    
                    self.autocompleteResults = response.data as! [GApiResponse.Autocomplete]
                    self.showOrHideTableView()
                    self.listTableView.reloadData()
                    
                }
            } else { print(response.error ?? "ERROR") }
        }
    }
    func showOrHideTableView() {
        self.listTableView.isHidden = self.autocompleteResults.count > 0 ? false : true
        
    }
    func checkifLocationChoosen() {
        
        /* if self.locationAddress.isEmpty {
         self..isHidden = true
         }
         else {
         self.nextView.isHidden = false
         }*/
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
extension GetPlacesViewController : UITextFieldDelegate {
    
}
extension GetPlacesViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.autocompleteResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GetPlacesTableViewCell.identifier) as? GetPlacesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.addressLabel.text =    self.autocompleteResults[indexPath.row].formattedAddress
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.locationAddress = self.autocompleteResults[indexPath.row].formattedAddress
        self.locationSearchTextField.text = self.locationAddress
        self.checkifLocationChoosen()
        self.locationSearchTextField.resignFirstResponder()
        
    }
}
