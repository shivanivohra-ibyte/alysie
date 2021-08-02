//
//  ProductDetailTableVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductDetailTableVC: UITableViewCell {
    
    @IBOutlet weak var collectonView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension ProductDetailTableVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageColectionViewCell", for: indexPath) as? ProductImageColectionViewCell else {return UICollectionViewCell()}
        return cell
    }
    
    
}

class ProductImageColectionViewCell: UICollectionViewCell{
    
}
