//
//  SelectedHubsCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class SelectedHubsCollectionCell: UICollectionViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewHubs: UIImageViewExtended!
  @IBOutlet weak var lblHubHeading: UILabel!
  @IBOutlet weak var lblHubSubHeading: UILabel!
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    self.layoutIfNeeded()
  }
  
  override func layoutIfNeeded() {
    
    super.layoutIfNeeded()
    
  }
  
  
}
