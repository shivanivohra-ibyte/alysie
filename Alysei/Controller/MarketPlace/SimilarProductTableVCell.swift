//
//  SimilarProductTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class SimilarProductTableVCell: UITableViewCell {
    

    @IBOutlet weak var collectonView: UICollectionView!
    var data: ProductDetailModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configCell(_ data: ProductDetailModel){
        self.data = data
        self.collectonView.reloadData()
    }

}

extension SimilarProductTableVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.related_products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarProductCollectionVCell", for: indexPath) as? SimilarProductCollectionVCell else {return UICollectionViewCell()}
        cell.labelProductName.text = data?.related_products?[indexPath.row].title
        cell.imgProduct.setImage(withString: kImageBaseUrl + String.getString(data?.related_products?[indexPath.row].product_gallery?.first?.attachment_url))

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectonView.frame.width / 2, height: 250)
    }

}

class SimilarProductCollectionVCell: UICollectionViewCell{
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var lblavgRating: UILabel!
    @IBOutlet weak var lblTotalRating: UILabel!
}
