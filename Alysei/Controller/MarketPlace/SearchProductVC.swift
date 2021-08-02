//
//  SearchProductVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 7/28/21.
//

import UIKit

class SearchProductVC: UIViewController {
    
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        vwHeader.addShadow()
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension SearchProductVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProductTableVC", for: indexPath) as? SearchProductTableVC else { return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SearchProductListVC") as? SearchProductListVC else {return}
                self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
