//
//  BusinessButtonTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class BusinessButtonTableCell: UITableViewCell {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var btnBusiness: UIButtonExtended!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.btnBusiness.makeCornerRadius(radius: 6.0)
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBusiness(_ sender: UIButton) {
    
  }
  
  //MARK: - Public Methods -
  
  public func configureData(withBusinessDataModel model: BusinessDataModel) -> Void{
    
    self.btnBusiness.setTitle(model.businessHeading, for: .normal)
    
  }
}
