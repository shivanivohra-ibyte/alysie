//
//  AddStepsCollectionViewCell.swift
//  Alysei
//
//  Created by namrata upadhyay on 23/08/21.
//

import UIKit

class AddStepsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var desciptionTextView: UITextView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var step1Label: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
//    var delegate: CollectionViewCellDelegate?
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        desciptionTextView.delegate = self
        titleTextField.delegate = self
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.cornerRadius = 5
        descriptionView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        desciptionTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        titleView.layer.borderWidth = 1
        titleView.layer.cornerRadius = 5
        titleView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
    }
}
extension AddStepsCollectionViewCell : UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Your recipe direction text here..." {
            desciptionTextView.text = ""
            desciptionTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)
        }
        textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            descriptionView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            desciptionTextView.text = "Your recipe direction text here..."
            desciptionTextView.textColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        textView.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
      textField.becomeFirstResponder()
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.becomeFirstResponder()
    }
}

