//
//  AddDescriptionViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 02/09/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit

class AddDescriptionViewController: BaseViewController {
    var descriptionString : String = ""
    var vendorProfileDetails : VenProfileBase?

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Description"
        submitBtn.setDarkGreenTheme(btn: submitBtn, title: "DONE")
        submitBtn.cornerRadius = 5.0
        
        textView.text = "Add your description here"
        textView.layer.borderColor = ColorManager.darkGrey.color.cgColor
        textView.layer.borderWidth = 1.0
        textView.delegate = self
        textView.cornerRadius = 5.0
        textView.textColor = UIColor.lightGray
        textView.font =  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(15.0))
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapSubmitBtn(_ sender: UIButton) {
        if self.descriptionString.isEmpty {
            self.showToast(message: "Description is required")
            return
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

extension AddDescriptionViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        self.descriptionString = text
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.descriptionString = textView.text
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}
