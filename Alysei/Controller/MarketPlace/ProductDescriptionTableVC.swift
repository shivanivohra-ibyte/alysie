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
    
    var handlingInstrSelected = true
    //var DispatchInstrSelected = true
    var reloadTableView:(() -> Void)? = nil
    var arrTitle = ["Product Info","Handling Instructions","Dispatch Instructions"]
   // var
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblDesc.numberOfLines = 1
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
    @IBAction func btnDropDownAction(_ sender: UIButton){
        self.handlingInstrSelected = !self.handlingInstrSelected
        if self.handlingInstrSelected == false{
            self.lblDesc.numberOfLines = 0
            self.btnDropDown.setImage(UIImage(named: "up-arrow"), for: .normal)
        }else{
            self.lblDesc.numberOfLines = 1
            self.btnDropDown.setImage(UIImage(named: "icons8_forward"), for: .normal)
        }
        self.reloadTableView?()
    }
    
    }
    
//icons8_forward
//up-arrow"
