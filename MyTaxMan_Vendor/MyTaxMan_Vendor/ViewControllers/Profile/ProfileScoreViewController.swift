//
//  ProfileScoreViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 02/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class ProfileScoreViewController: BaseViewController {
    
    @IBOutlet weak var profileDescriptionLabel: UILabel!
    @IBOutlet weak var profileScoreLabel: UILabel!
    @IBOutlet weak var scoreTableView: UITableView!
    var profileDetailsBaseForScoreScreen : VenProfileBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.title = "Profile Score"
        
        profileScoreLabel.setLabelCustomProperties(titleText:"\(self.profileDetailsBaseForScoreScreen?.profile_score ?? 0)/100" , textColor: .black, font: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(25.0)), numberOfLines: 0, alignment: .center)
        
        profileDescriptionLabel.setLabelCustomProperties(titleText:"Get an easy 10 points by adding\na profile image" , textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .center)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupTableView() {
        scoreTableView.register(ProfileScoreTableViewCell.nib, forCellReuseIdentifier: ProfileScoreTableViewCell.identifier)
        scoreTableView.tableFooterView = UIView()
        scoreTableView.delegate = self
        scoreTableView.separatorStyle = .none
        scoreTableView.dataSource = self
        scoreTableView.backgroundColor = ColorManager.white.color
        scoreTableView.estimatedRowHeight = UITableView.automaticDimension
        scoreTableView.rowHeight = UITableView.automaticDimension
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func redirectToAddDescriptionVC() {
        let desVC = AddDescriptionViewController.instantiateFromAppStoryboard(appStoryboard: .Profile)
        desVC.hidesBottomBarWhenPushed = true
        desVC.vendorProfileDetails = self.profileDetailsBaseForScoreScreen
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    func redirectToContactDetailsVC() {
          let desVC = ContactDetailsViewController.instantiateFromAppStoryboard(appStoryboard: .Profile)
          desVC.hidesBottomBarWhenPushed = true
          desVC.vendorProfileDetails = self.profileDetailsBaseForScoreScreen
          self.navigationController?.pushViewController(desVC, animated: true)
      }
    
}


extension ProfileScoreViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        guard let cell : ProfileScoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileScoreTableViewCell.identifier) as? ProfileScoreTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        if let profile = self.profileDetailsBaseForScoreScreen {
            switch indexPath.row {
            case 0:
                cell.setDataForFirstRow(data: profile)
                break
            case 1:
                cell.setDataForSecondRow(data: profile)
                break
            case 2:
                cell.setDataForThirdRow(data: profile)
                break
            case 3:
                cell.setDataForFourthRow(data: profile)
                break
            case 4:
                cell.setDataForFifthRow(data: profile)
                break
            case 5:
                cell.setDataForSixthRow(data: profile)
                break
            case 6:
                cell.setDataForSeventhRow(data: profile)
                break
            default:
                break
                
            }
        }
        
        cell.editBtnAction = { [weak self] in
            switch indexPath.row {
            case 0:
                print("upload profile picture")
            case 2:
                print("upload document")
            case 3:
                print("upload profile picture")
            case 4:
                self?.redirectToContactDetailsVC()
                print("Edit contact information")
            case 5:
                print("Add description")
                self?.redirectToAddDescriptionVC()
            case 6:
                print("Add reviews")
            default:
                break
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
