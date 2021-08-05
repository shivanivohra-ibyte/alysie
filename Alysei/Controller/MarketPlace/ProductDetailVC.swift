//
//  ProductDetailVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductDetailVC: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!

    var marketplaceProductId : String?
    var productDetail: ProductDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()
        callProductDetailApi()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableVC", for: indexPath) as? ProductDetailTableVC else {return UITableViewCell()}
            cell.pageControl.currentPage = indexPath.row
            cell.selectionStyle = .none
            cell.configCell(productDetail ?? ProductDetailModel(with: [:]))
            
        return cell
        }else if indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTableVC", for: indexPath) as? ProductDescriptionTableVC else {return UITableViewCell()}
            cell.configCell(productDetail ?? ProductDetailModel(with: [:]), indexPath.row)
            return cell
        }else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 7{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescOptionTableVC", for: indexPath) as? ProductDescOptionTableVC else {return UITableViewCell()}
            cell.configCell(productDetail ?? ProductDetailModel(with: [:]), indexPath.row)
            return cell
        }else if indexPath.row == 8{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductRatingTableVCell", for: indexPath) as? ProductRatingTableVCell else {return UITableViewCell()}
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarProductTableVCell", for: indexPath) as? SimilarProductTableVCell else {return UITableViewCell()}
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
        return 580
        }else if indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6{
            return UITableView.automaticDimension
        }else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 7{
            return 60
        }else {
            return 300
        }
    }
    
}

extension ProductDetailVC {
    
    func callProductDetailApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetProductMarketDetail + (marketplaceProductId ?? ""), requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.productDetail = ProductDetailModel.init(with: data)
            }
            self.tableView.reloadData()
        }
    }
}

