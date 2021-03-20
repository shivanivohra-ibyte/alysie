//
//  ActiveCollectionViewCell.swift
//  Alysei
//
//  Created by Gitesh Dang on 19/03/21.
//

import UIKit

class ActiveCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgFlag: ImageLoader!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var imgContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgFlag.applyshadowWithCorner(containerView: imgContainer, cornerRadious: 30)
    }
    
    func configCell(_ data: CountryModel){
        lblCountryName.text = data.name
        if let strUrl = "\(kImageBaseUrl1)\(data.flagId?.attachmentUrl ?? "")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imgUrl = URL(string: strUrl) {
            print("\("FlagImageUrl---------------------------\(imgUrl)")")
            imgFlag.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
        }
    }
}
extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 1
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
