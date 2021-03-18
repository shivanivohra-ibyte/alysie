//
//  RoleCollectionCellCollectionViewCell.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 13/01/21.
//

import UIKit

class RoleCollectionCell: UICollectionViewCell {
   
  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgVRole: UIImageView!
  @IBOutlet weak var lblRoleName: UILabel!
  @IBOutlet weak var imgViewSelected: UIImageView!
  
  //MARK: - Public Methods -
  
  public func configureData(withGetRoleDataModel model: GetRoleDataModel) -> Void{
      
    imgVRole.setImage(withString: String.getString(model.image), placeholder: nil)
    lblRoleName.text = model.name
    
    if model.isSelected == true{
      
      self.imgViewSelected.isHidden = false
      self.imgViewSelected.image = UIImage(named: "overlay_on_role_selection")
    }
    else{
      self.imgViewSelected.isHidden = true
    }
  }
}
