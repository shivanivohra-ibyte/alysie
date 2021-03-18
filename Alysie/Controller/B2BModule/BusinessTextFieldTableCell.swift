//
//  BusinessTextFieldTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class BusinessTextFieldTableCell: UITableViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var txtFieldBusiness: UITextFieldExtended!
  
  override func awakeFromNib() {
      
    super.awakeFromNib()
    self.txtFieldBusiness.makeCornerRadius(radius: 6.0)
    self.txtFieldBusiness.attributedPlaceholder = NSAttributedString(string: "Keyword Search",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: AppColors.liteGray.color])
  }

}
