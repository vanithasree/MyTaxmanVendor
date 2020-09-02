//
//  MenuOptionViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class MenuOptionViewController: BaseViewController {
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var bgView: UIView!
    
    var optionList: [String] = []
    var callSettingsAction : (() ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isTransparent = true
        isHideNavigationBar = true
        setupViews()
        // Do any additional setup after loading the view.
    }
    fileprivate func setupViews(){
        self.view.backgroundColor = ColorManager.darkText.color.withAlphaComponent(0.3)
        
        bgView.backgroundColor = ColorManager.white.color
        bgView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(onTapBgView(tapGesture:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
        
        optionTableView.register(CallOptionTableViewCell.nib, forCellReuseIdentifier: CallOptionTableViewCell.identifier)
        optionTableView.delegate = self
        optionTableView.dataSource = self
        optionTableView.tableFooterView = UIView()
        optionTableView.backgroundColor = ColorManager.white.color
        doOnMain {
            self.tableViewHeightConstraint.constant = CGFloat((self.optionList.count * 60) + 50)
            self.tableViewHeightConstraint.isActive = true
        }
    }
    @objc func onTapBgView(tapGesture:UITapGestureRecognizer) {
        self.dismiss(animated: true) {}
        //        self.navigationController?.popViewController(animated: true)
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

extension MenuOptionViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

extension MenuOptionViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : CallOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: CallOptionTableViewCell.identifier) as? CallOptionTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.titleLabel.text = optionList[indexPath.row]
        switch optionList[indexPath.row] {
        case "Call Settings":
           // cell.imgView.image = UIImage(named: "hire")
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch optionList[indexPath.row] {
        case "Call Settings":
            callSettingsAction?()
            break
        default:
            break
        }
        self.dismiss(animated: true) {}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
