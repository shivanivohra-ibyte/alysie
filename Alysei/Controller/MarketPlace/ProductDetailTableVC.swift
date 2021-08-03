//
//  ProductDetailTableVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductDetailTableVC: UITableViewCell {
    
    @IBOutlet weak var collectonView: UICollectionView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
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
        lblProductName.text = data.product_detail?.title
        lblProductCategory.text = data.product_detail?.product_category_name
        lblProductPrice.text = "$" + (data.product_detail?.product_price ?? "")
        //lblRating.text = data.
    }

}

extension ProductDetailTableVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageColectionViewCell", for: indexPath) as? ProductImageColectionViewCell else {return UICollectionViewCell()}
        cell.imgProduct.setImage(withString: kImageBaseUrl + String.getString(data?.product_gallery?[indexPath.row].attachment_url))
        return cell
    }
    
    
}

class ProductImageColectionViewCell: UICollectionViewCell{
    @IBOutlet weak var btnFavUnFav: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnFavUnFav(_ sender: UIButton){
        
    }
}
