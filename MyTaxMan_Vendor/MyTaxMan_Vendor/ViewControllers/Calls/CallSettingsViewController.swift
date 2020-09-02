//
//  CallSettingsViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import AVFoundation

class CallSettingsViewController: BaseViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var rowTitleArray = ["Location Settings", "Microphone Settings"]
    var locationString: String = ""
    var microPhoneString : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkMicroPhoneAccessStatus()
        setupTableView()
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate    func setupTableView() {
        settingsTableView.register(CallSettingsTableViewCell.nib, forCellReuseIdentifier: CallSettingsTableViewCell.identifier)
        settingsTableView.tableFooterView = UIView()
        settingsTableView.delegate = self
        settingsTableView.separatorStyle = .none
        settingsTableView.dataSource = self
        settingsTableView.backgroundColor = ColorManager.white.color
        settingsTableView.estimatedRowHeight = UITableView.automaticDimension
        settingsTableView.rowHeight = UITableView.automaticDimension
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func checkMicroPhoneAccessStatus() {
        let microPhoneStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        
        switch microPhoneStatus {
        case .authorized:
            // Has access
            self.microPhoneString = "Not authorized"
            break
        case .denied:
            // No access granted
            self.microPhoneString = "Denied"
            
            break
        case .restricted:
            // Microphone disabled in settings
            self.microPhoneString = "Restricted"
            break
        case .notDetermined:
            self.microPhoneString = "Not determined"
            break
        // Didn't request access yet
        default:
            break
            
        }
    }
    
    
}

extension CallSettingsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : CallSettingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CallSettingsTableViewCell.identifier) as? CallSettingsTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = self.rowTitleArray[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.valueLabel.text = self.locationString
            break
        case 1:
            cell.valueLabel.text = self.microPhoneString
            break
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // open the app permission in Settings app
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
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
