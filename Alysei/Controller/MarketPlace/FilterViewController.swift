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
    
    var arrOption = ["Availabel for Sample","Category","Price Range"]
    var arrAlyseiBrandOption = ["Yes","No"]
    var arrPriceOption = ["0$-10$","10$-50$","50$-200$","200$-500$"]
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //optionTableView.layer.backgroundColor = UIColor.init(hexString: "#E8E8E8").cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
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
                return arrPriceOption.count
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
                    cell.labelSubOptions.text =  arrPriceOption[indexPath.row]
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
         let cell = optionTableView.cellForRow(at: indexPath) as? FilterOptionTableVCell
        cell?.vwBackground.layer.backgroundColor = UIColor.white.cgColor
        self.selectedIndex = indexPath.row
        selectedIndex  = indexPath.row
        self.subOptionTableView.reloadData()
    }
}


extension FilterViewController{
    func callCategoryApi(){
        
    }
}
