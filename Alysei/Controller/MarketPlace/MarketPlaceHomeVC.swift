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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPost))
        self.postView.addGestureRecognizer(tap)
        
//        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceWalkthroughVC") as! MarketPlaceWalkthroughVC
//        vc.view.frame = self.containerView.bounds
//        self.containerView.willRemoveSubview(vc.view)
         
    }
    
    @objc func openPost(){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnGotoStores(_ sender: UIButton){
        //_ = pushViewController(withName: MarketPlaceWalkthroughVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
        
        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceWalkthroughVC") as! MarketPlaceWalkthroughVC
        
        vc.view.frame = self.containerView.bounds
        self.addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }

}
