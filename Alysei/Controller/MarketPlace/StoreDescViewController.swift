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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
        return 300
        }else {
               // return CGFloat((250 * ((self.productDetail?.related_products?.count ?? 0) / 2 )))
            
            return CGFloat((250 * (6 / 2)))
            }
    }
    
    
}
extension StoreDescViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "StoreDescImageCollectionVCell", for: indexPath) as? StoreDescImageCollectionVCell else {return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.imageCollectionView.frame.width / 2, height: 220)
    }
}
