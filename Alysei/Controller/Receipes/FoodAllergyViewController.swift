//
//  FoodAllergyViewController.swift
//  Preferences
//
//  Created by mac on 25/08/21.
//

import UIKit

var arraySelectedFood : [Int]?
class FoodAllergyViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [UIImage]() // This is selected cell data array
   
    var arrFoodIntolerance = [SelectFoodIntoleranceDataModel]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FoodAllergyCollectionViewCell", bundle: .main ), forCellWithReuseIdentifier: "FoodAllergyCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 30
        nextButton.layer.borderColor = UIColor.init(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 30
        backButton.layer.borderColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        
        postRequestToGetFoodIntolerance()

    }
    @IBAction func tapNextToDiets(_ sender: Any) {
        
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "FollowDietsViewController") as! FollowDietsViewController
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSkip(_ sender: Any) {
        let viewAll = self.storyboard?.instantiateViewController(withIdentifier: "FollowDietsViewController") as! FollowDietsViewController
        self.navigationController?.pushViewController(viewAll, animated: true)
    }
    
    func postRequestToGetFoodIntolerance() -> Void{
       
       TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.Recipes.getFoodIntolerance, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (response, error, errorType, statusCode) in
           
           let res = response as? [String:Any]
           
           if let data = res?["data"] as? [[String:Any]]{
               self.arrFoodIntolerance = data.map({SelectFoodIntoleranceDataModel.init(with: $0)})
           }
           
           self.collectionView.reloadData()
       }
    }


}
extension FoodAllergyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFoodIntolerance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodAllergyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodAllergyCollectionViewCell", for: indexPath) as! FoodAllergyCollectionViewCell
        let imgUrl = (kImageBaseUrl + (arrFoodIntolerance[indexPath.row].imageId?.imgUrl ?? ""))
        cell.image1.setImage(withString: imgUrl)
        cell.imageNameLabel.text = arrFoodIntolerance[indexPath.row].foodName
        cell.viewOfImage.layer.cornerRadius = cell.viewOfImage.bounds.width/2
        cell.viewOfImage.layer.borderWidth = 4
        cell.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        
                cell.layoutSubviews()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? FoodAllergyCollectionViewCell

        if  arrFoodIntolerance[indexPath.row].isSelected == true {
            arrFoodIntolerance[indexPath.row].isSelected = false
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
//            nextButton.layer.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        } else {
            arrFoodIntolerance[indexPath.row].isSelected = true
            cell?.viewOfImage.layer.borderWidth = 4
            cell?.viewOfImage.layer.borderColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
            nextButton.layer.backgroundColor = UIColor.init(red: 59/255, green: 156/255, blue: 128/255, alpha: 1).cgColor
            
            arraySelectedFood?.append(arrFoodIntolerance[indexPath.row].foodId ?? 0)
        }

      }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width)/3, height: 120)
        return cellSize
        
    }
    
    
}
