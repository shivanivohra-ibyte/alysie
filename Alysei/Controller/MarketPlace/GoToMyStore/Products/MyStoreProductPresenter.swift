//
//  MyStoreProductPresenter.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/24/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MyStoreProductPresentationLogic
{
  func presentSomething(response: MyStoreProduct.Something.Response)
    func showProduct(_ productArr: [MyStoreProductDetail])
}

class MyStoreProductPresenter: MyStoreProductPresentationLogic
{
   
   
  weak var viewController: MyStoreProductDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: MyStoreProduct.Something.Response)
  {
    let viewModel = MyStoreProduct.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    func showProduct(_ productArr: [MyStoreProductDetail]) {
       // print("ProductArr----------------------------\(productArr)")
        self.viewController?.displayProductListData(productArr)
    }
    
    
}
