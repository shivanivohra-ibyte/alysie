//
//  SearchProductListVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/29/21.
//

import UIKit

class SearchProductListVC: UIViewController {

    @IBOutlet weak var sortFilterView: UIView!
    var selectProductName: String?
    var arrProductList: [ProductSearchListModel]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortFilterView.addShadow()
        lblTitle.text = selectProductName
        let trimmed = selectProductName?.trimmingCharacters(in: .whitespaces)
        print("trimmed Character-------------------\(trimmed ?? "")")
        callSearcListhApi(trimmed ?? "")
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func seacrhAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchProductListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableVCell", for: indexPath) as? ProductListTableVCell else {return UITableViewCell()}
        cell.configCell(arrProductList?[indexPath.row] ?? ProductSearchListModel(with: [:]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as? ProductDetailVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchProductListVC {
    func callSearcListhApi(_ text: String){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProductSearch + "product?keyword=" + "\(text )" + "&available_for_sample=" + "\("")" + "&sort_by=" + "\("")" + "&category=" + "\("")" + "&price_range=" + "\("")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = dictResponse as? [String:Any]
            if  let data = response?["data"] as? [[String:Any]]{
                self.arrProductList = data.map({ProductSearchListModel.init(with: $0)})
            }
            self.tableView.reloadData()
        }
    }
}
class ProductListTableVCell: UITableViewCell{
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblProductCategoryName: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(_ data: ProductSearchListModel){
        lblProductName.text = data.title
        lblProductPrice.text = "$" + (data.product_price ?? "")
        lblStoreName.text = data.store_name
        lblProductCategoryName.text = data.product_category_name
        lblReview.text = "\(data.total_reviews ?? 0)"
    }
}
