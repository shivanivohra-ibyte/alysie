//
//  MyStoreProductCVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/24/21.
//

import UIKit

class MyStoreProductCVCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow()
    }
    
}
