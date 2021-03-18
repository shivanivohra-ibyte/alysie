//
//  FeaturedProductCollectionCell.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class FeaturedProductCollectionCell: UICollectionViewCell {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewProduct: UIImageView!
  @IBOutlet weak var lblProductName: UILabel!
  @IBOutlet weak var viewBorder: UIView!
  
  var pushedFrom: Int = 0
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    self.layoutIfNeeded()
  }
  
  override func layoutIfNeeded() {
    
    super.layoutIfNeeded()
    if pushedFrom == 0{
      self.viewBorder.layer.borderWidth = 1.0
      self.viewBorder.layer.borderColor = AppColors.gray.color.cgColor
      self.viewBorder.makeCornerRadius(radius: 8.0)
    }
  }
  
  //MARK: - Public Methods -
  
  public func configure(withAllProductsDataModel model: AllProductsDataModel?,pushedFrom: Int = 0) -> Void{
   
    self.imgViewProduct.setImage(withString: kImageBaseUrl + String.getString(model?.imagePath))
    self.lblProductName.text = model?.productTitle
  }
    
}
