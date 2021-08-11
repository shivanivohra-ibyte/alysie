//
//  FilterViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/4/21.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var subOptionTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    
    var arrOption = ["Availabel for Sample","Category","Price Range"]
    var arrAlyseiBrandOption = ["Yes","No"]
    var arrPriceOption = ["0$-10$","10$-50$","50$-200$","200$-500$", "above <500"]
    var arrProductCategory: [MyStoreProductDetail]?
    
    var selectedProductName : String?
    var selectedSampleOption: String?
    var selectedCategoryArr : Int?
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.addShadow()
        //optionTableView.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clearFilters(_ sender: UIButton){
        callFilterApi()
    }
    @IBAction func btnApplyFilter(_ sender: UIButton){
        
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == optionTableView{
        return 3
        }else{
            switch selectedIndex {
            case 0:
                return arrAlyseiBrandOption.count
            case 1:
                return arrProductCategory?.count ?? 0
            default:
                return arrPriceOption.count
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == optionTableView{
        guard let cell = optionTableView.dequeueReusableCell(withIdentifier: "FilterOptionTableVCell", for: indexPath) as? FilterOptionTableVCell else {return UITableViewCell()}
        cell.vwBackground.layer.backgroundColor = UIColor.systemGray4.cgColor
            cell.labelOptionName.text = arrOption[indexPath.row]
        return cell
        }else{
            guard let cell = subOptionTableView.dequeueReusableCell(withIdentifier: "FilterSubOptionsTableVCell", for: indexPath) as? FilterSubOptionsTableVCell else {return UITableViewCell()}
                switch selectedIndex {
                case 0:
                    cell.labelSubOptions.text =  arrAlyseiBrandOption[indexPath.row]
                case 1:
                    cell.labelSubOptions.text =  arrProductCategory?[indexPath.row].name
                default:
                    cell.labelSubOptions.text =  arrPriceOption[indexPath.row]
                }
                
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == optionTableView {
        return 50
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == optionTableView{
         let cell = optionTableView.cellForRow(at: indexPath) as? FilterOptionTableVCell
        cell?.vwBackground.layer.backgroundColor = UIColor.white.cgColor
        self.selectedIndex = indexPath.row
        if indexPath.row == 1{
            self.callCategoryApi()
        }
        }else{
            if self.selectedIndex == 1{
                self.selectedCategoryArr = arrProductCategory?[indexPath.row].marketplace_product_category_id  ?? 0
               // self.selectedCategoryArr.append(arrProductCategory?[indexPath.row].marketplace_product_category_id ?? 0)
            }
        }
        self.subOptionTableView.reloadData()
    }
}


extension FilterViewController{
    func callCategoryApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProductCategory, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error , errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.arrProductCategory = data.map({MyStoreProductDetail.init(with: $0)})
            }
            self.subOptionTableView.reloadData()
        }
    }
    
    func callFilterApi(){
        
       // let CategoryArr =  self.selectedCategoryArr.components(separatedBy: ",")
          
        let urlString = APIUrl.kProductListing + "\(selectedProductName ?? "")" + "&available_for_sample=" + "\(selectedSampleOption ?? "")" + "&sort_by=" + "" + "&category=" + "\(selectedCategoryArr ?? 0)" + "&price_rfrom=" + "" + "&price_to="
        let urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        TANetworkManager.sharedInstance.requestApi(withServiceName: urlString1, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            switch statusCode{
            case 200:
                print("Success")
            default:
                self.showAlert(withMessage: "No products found")
            }
        }
    }
}

  //  let Arr =  self.selectStateId?.components(separatedBy: ",")
   // controller?.passSelectOptionId = Arr ?? [""]}
