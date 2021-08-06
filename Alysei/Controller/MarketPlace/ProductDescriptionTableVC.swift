//
//  ProductDescriptionTableVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductDescriptionTableVC: UITableViewCell {
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!
    

    
    var arrTitle = ["Product Info","Handling Instructions","Dispatch Instructions"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data: ProductDetailModel, _ currentIndex: Int?){
        if currentIndex == 1{
            self.lblDesc.text = data.product_detail?.description
            self.lblTitle.text = arrTitle[0]
            btnDropDown.isHidden = true
        }else if currentIndex == 5{
            print("Handling Instruction------------------------\(data.product_detail?.handling_instruction ?? "")")
            self.lblDesc.text = data.product_detail?.handling_instruction
            self.lblTitle.text = arrTitle[1]
            btnDropDown.isHidden = false
        }else{
            print("Dispatch Instruction------------------------\(data.product_detail?.dispatch_instruction ?? "")")
            self.lblDesc.text = data.product_detail?.dispatch_instruction
            self.lblTitle.text = arrTitle[2]
            btnDropDown.isHidden = false
        }
    }

}
