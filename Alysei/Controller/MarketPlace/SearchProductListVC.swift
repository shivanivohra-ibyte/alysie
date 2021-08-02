//
//  SearchProductListVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/29/21.
//

import UIKit

class SearchProductListVC: UIViewController {

    @IBOutlet weak var sortFilterView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortFilterView.addShadow()
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension SearchProductListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableVCell", for: indexPath) as? ProductListTableVCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


class ProductListTableVCell: UITableViewCell{
    
}
