//
//  SendAReplyViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 01/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Alamofire
import FloatRatingView

class SendAReplyViewController: BaseViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ratingsView: FloatRatingView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var replyToLabekl: UILabel!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    var reviewDetails : ReviewListDesc? = nil
    
    var commentedString : String = ""
    private var reviewViewModel = ReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        // Do any additional setup after loading the view.
    }
    func setupViewUI() {
        self.title = "Review"
        nameLabel.setLabelCustomProperties(titleText:self.reviewDetails?.customername ?? "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .center)
        
        self.ratingsView.rating =  Double(self.reviewDetails?.star_given ?? "0")!
        
        reviewLabel.setLabelCustomProperties(titleText:self.reviewDetails?.review ?? "", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(18.0)), numberOfLines: 0, alignment: .left)
        
        
        
        timeStampLabel.setLabelCustomProperties(titleText:"", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .left)
        
        if let reviewedDate = self.reviewDetails?.quote_accepted_on, !reviewedDate.isEmpty {
            
            let date = reviewedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
            let activityDate = "\(date?.toString(format: "dd MMM yyyy") ?? "")"
            self.timeStampLabel.text = activityDate
        }
        
        
        replyToLabekl.setLabelCustomProperties(titleText: "Reply: \(self.reviewDetails?.customername ?? "")", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .left)
        submitButton.setDarkGreenTheme(btn: submitButton, title: "SUBMIT REPLY")
        submitButton.cornerRadius = 5.0
        
        commentTextView.text = "e.g.: Thanks for leaving your feedback"
        commentTextView.layer.borderColor = ColorManager.darkGrey.color.cgColor
        commentTextView.layer.borderWidth = 1.0
        commentTextView.delegate = self
        commentTextView.cornerRadius = 5.0
        commentTextView.textColor = UIColor.lightGray
        commentTextView.font =  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(15.0))
    }
    
    
    @IBAction func onTapSubmitBtn(_ sender: UIButton) {
        if self.commentedString.isEmpty {
            self.showToast(message: "Comment is required")
            return
        }
        
        let input : Parameters = [
            "taskid" : self.reviewDetails?.taskid ?? "",
            "vendor_review" : self.commentedString,
            "vendor_review_givenon" : Date().dateAndTimetoString()
        ]
        LoadingIndicator.shared.show(forView: self.view)
        reviewViewModel.giveReviews(input: input) { (result: DraftQuoteBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.presentAlert(withTitle: "", message: result.desc ?? "") {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else
                {
                    self.presentAlert(withTitle: "", message: result.desc ?? "") {}
                }
                
            }
            else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
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

extension SendAReplyViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        self.commentedString = text
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.commentedString = textView.text
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.black
        }
    }
}
