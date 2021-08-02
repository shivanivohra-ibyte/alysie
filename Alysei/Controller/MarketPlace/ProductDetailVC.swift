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

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()
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
        return cell
        }else if indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTableVC", for: indexPath) as? ProductDescriptionTableVC else {return UITableViewCell()}
            return cell
        }else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 7{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescOptionTableVC", for: indexPath) as? ProductDescOptionTableVC else {return UITableViewCell()}
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
            return 150
        }else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 7{
            return 60
        }else {
            return 300
        }
    }
    
}


