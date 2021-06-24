//
//  MarketPlaceHomeVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/31/21.
//

import UIKit

class MarketPlaceHomeVC: AlysieBaseViewC {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var btnCreateStore: UIButton!
    @IBOutlet weak var marketplaceView: UIView!
    var isCreateStore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "\(UserRoles.producer.rawValue)"{
            self.btnCreateStore.isHidden = false
        }else{
            self.btnCreateStore.isHidden = true
        }
        self.btnCreateStore.setTitleColor(UIColor.init(hexString: "#4BB3FD"), for: .normal)
        marketplaceView.backgroundColor = UIColor.init(hexString: "#4BB3FD")
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPost))
        self.postView.addGestureRecognizer(tap)
        
        if kSharedUserDefaults.loggedInUserModal.isStoreCreated == "1" || self.isCreateStore == true{
            self.btnCreateStore.setTitle("Go to My Store", for: .normal)
            self.btnCreateStore.isUserInteractionEnabled = false
        }else{
            self.btnCreateStore.setTitle("Create your Store", for: .normal)
            self.btnCreateStore.isUserInteractionEnabled = true
        }
         
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceHomeVC") as! MarketPlaceHomeVC
//
//        vc.view.frame = self.containerView.bounds
//        self.addChild(vc)
//        self.containerView.addSubview(vc.view)
//        vc.didMove(toParent: self)
//    }
    @objc func openPost(){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnGotoStores(_ sender: UIButton){
       
        //if kSharedUserDefaults.loggedInUserModal.isStoreCreated == "0"{
        if btnCreateStore.title(for: .normal) == "Create your Store"{
        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceWalkthroughVC") as! MarketPlaceWalkthroughVC
        
        vc.view.frame = self.containerView.bounds
        self.addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        }else{
            _ = pushViewController(withName: MyStoreVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? MyStoreVC
        }
    }

}
