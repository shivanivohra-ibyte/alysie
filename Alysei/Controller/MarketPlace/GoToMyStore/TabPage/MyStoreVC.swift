//
//  MyStoreVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/23/21.
//

import UIKit

class MyStoreVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var dashboardView: UIView!
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var inquiryView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //stackView.addSubview
        self.loadDashboard()
    
        let dashboardTap = UITapGestureRecognizer(target: self, action: #selector(loadDashboard))
        self.dashboardView.addGestureRecognizer(dashboardTap)
        
        let productTap = UITapGestureRecognizer(target: self, action: #selector(loadProduct))
        self.productView.addGestureRecognizer(productTap)
        
        let storeTap = UITapGestureRecognizer(target: self, action: #selector(loadStore))
        self.storeView.addGestureRecognizer(storeTap)
        
        let inquiryTap = UITapGestureRecognizer(target: self, action: #selector(loadinquiry))
        self.inquiryView.addGestureRecognizer(inquiryTap)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func loadDashboard(){
        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MyStoreDashboardViewController") as! MyStoreDashboardViewController
        
        vc.view.frame = self.containerView.bounds
        self.addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    @objc func loadProduct(){
    
        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MyStoreProductViewController") as! MyStoreProductViewController
        
        vc.view.frame = self.containerView.bounds
        self.addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    @objc func loadStore(){
        print("load Store")
        let vc = UIStoryboard(name: StoryBoardConstants.kMarketplace, bundle: nil).instantiateViewController(withIdentifier: "MarketPlaceCreateStoreVC") as! MarketPlaceCreateStoreVC
        vc.fromVC = .myStoreDashboard
        vc.view.frame = self.containerView.bounds
        self.addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    @objc func loadinquiry(){
        print("load Inquiry")
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}
