//
//  MarketPlaceCreateStoreVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/3/21.
//

import UIKit

class MarketPlaceCreateStoreVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var dummyArr = ["1"]
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

extension MarketPlaceCreateStoreVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateStoreCell") as? CreateStoreCell else{return UITableViewCell()}
        cell.txtStore.tag = indexPath.row
        cell.configCell(dummyArr, index: indexPath.row)
        cell.txtStore.placeholder = "Type"
        cell.addCellCallBack = {
            self.count = self.count + 1
            self.dummyArr.append("\(self.count)")
            tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 40
    }
    
}
class CreateStoreCell: UITableViewCell{
    
    @IBOutlet weak var txtStore: UITextField!
    
    //var addCellCallBack:(() -> Void)? = nil
    var addCellCallBack: (() -> Void)? = nil
    var model: [String]?
    var index: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        txtStore.delegate = self
        txtStore.textColor = UIColor.white
    }
    
    func configCell(_ data: [String], index: Int){
        self.model = data
        self.index = index
    }
    
}

extension CreateStoreCell: UITextFieldDelegate{
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if self.index ?? 0 <= self.model?.count ?? 0{
//        addCellCallBack?()
//        }else{
//            print("No addition")
//        }
//        return true
//    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //if self.index ?? 0 <= self.model?.count ?? 0 && self.index ==  {
            if self.index ==  (self.model?.count ?? 0) - 1  {
        addCellCallBack?()
        }else{
            print("No addition")
        }
        return true
    }
}
