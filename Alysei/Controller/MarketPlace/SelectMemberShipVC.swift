//
//  SelectMemberShipVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/3/21.
//

import UIKit

class SelectMemberShipVC: AlysieBaseViewC {
   
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnFreeMemberShip: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnNext.isUserInteractionEnabled = false
        btnFreeMemberShip.setImage(UIImage(named: "Ellipse 22"), for: .normal)
        btnNext.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        btnNext.setTitleColor(UIColor.white, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnFreeMemberShipAction(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        self.btnFreeMemberShip.setImage((sender.isSelected == true) ? UIImage(named: "icons8_checkmark_2") : UIImage(named: "Ellipse 22"), for: .normal)
        if sender.isSelected == true{
            btnNext.layer.backgroundColor = UIColor.init(hexString: "#004577").cgColor
            btnNext.isUserInteractionEnabled = true
        }else{
            btnNext.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            btnNext.isUserInteractionEnabled = false
        }
    }
    @IBAction func btnNextAction(_ sender: UIButton){
        _ = pushViewController(withName: MarketPlaceCreateStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
    }
}
