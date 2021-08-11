//
//  StoreDescViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit
import GoogleMaps

class StoreDescViewController: AlysieBaseViewC {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgCover : UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelAvgRating: UILabel!
    @IBOutlet weak var labelTotalReview: UILabel!
    @IBOutlet weak var lblTotalProducts: UILabel!
    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblStoreDesc: UILabel!
    @IBOutlet weak var lblProducerName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var imgProducer: UIImageView!
    @IBOutlet weak var vwHeader: UIView!
    
    
    var storeDetails: MyStoreProductDetail?
    var storeProducts: [ProductSearchListModel]?
    var passStoreId: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        callStoreDetailApi()
        imgProfile.layer.cornerRadius = 60
        imgProducer.layer.cornerRadius = 25
        imgProfile.layer.borderWidth = 0.5
        imgProfile.layer.borderColor = UIColor.white.cgColor
        vwHeader.addShadow()
        // Do any additional setup after loading the view.
    }
    func setUIData(){
        lblStoreName.text = storeDetails?.name
        lblTotalProducts.text = "\(storeProducts?.count ?? 0)"
        lblStoreDesc.text = storeDetails?.description
        lblProducerName.text = storeDetails?.prefilled?.companyName
        lblCategories.text = "\(storeDetails?.totalCategory ?? 0)"
       // labelAvgRating.text = storeDetails?.avg_rating
        //labelTotalReview.text = (storeDetails?.total_reviews ?? "0") + "Reviews"
        self.imgProfile.setImage(withString: kImageBaseUrl + String.getString(storeDetails?.logo_id))
        self.imgCover.setImage(withString: kImageBaseUrl + String.getString(storeDetails?.banner_id))
        self.imgProducer.setImage(withString: kImageBaseUrl + String.getString(storeDetails?.prefilled?.avatarId?.attachmentUrl))
        
        
    }
    
    @IBAction func btnViewAllReview(_ sender: UIButton){
        _ = pushViewController(withName: ReviewScreenViewController.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? ReviewScreenViewController
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension StoreDescViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreRatingReviewTableVCell", for: indexPath) as? StoreRatingReviewTableVCell else {return UITableViewCell()}
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreDescProductTableVCell", for: indexPath) as? StoreDescProductTableVCell else {return UITableViewCell()}
            cell.configCell(storeProducts)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
        return 300
        }else {
                return CGFloat((250 * ((self.storeProducts?.count ?? 0) / 2 )))
            
           // return CGFloat((250 * (6 / 2)))
            }
    }
    
    
}
extension StoreDescViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeDetails?.store_gallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "StoreDescImageCollectionVCell", for: indexPath) as? StoreDescImageCollectionVCell else {return UICollectionViewCell()}
        cell.imgStore.setImage(withString: kImageBaseUrl + String.getString(storeDetails?.store_gallery?[indexPath.row].attachment_url))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.imageCollectionView.frame.width / 2, height: 220)
    }
}

extension StoreDescViewController{
    func callStoreDetailApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetSellerProfile + "\(passStoreId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
             let response = dictResponse as? [String:Any]
            
            if let data = response?["data"] as? [String:Any]{
                self.storeDetails = MyStoreProductDetail.init(with: data)
            }
            
            if let arrData = response?["store_products"] as? [[String:Any]]{
                self.storeProducts = arrData.map({ProductSearchListModel.init(with: $0)})
            }
            self.setUIData()
            self.imageCollectionView.reloadData()
            self.tableView.reloadData()
        }
    }
}
