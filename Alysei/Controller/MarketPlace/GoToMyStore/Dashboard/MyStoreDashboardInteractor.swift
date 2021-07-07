//
//  MyStoreDashboardInteractor.swift
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

protocol MyStoreDashboardBusinessLogic
{
  func doSomething(request: MyStoreDashboard.Something.Request)
    func callDashBoardApi()
    func callCategoryApi()
}

protocol MyStoreDashboardDataStore
{
  //var name: String { get set }
}

class MyStoreDashboardInteractor: MyStoreDashboardBusinessLogic, MyStoreDashboardDataStore
{
  var presenter: MyStoreDashboardPresentationLogic?
  var worker: MyStoreDashboardWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: MyStoreDashboard.Something.Request)
  {
    worker = MyStoreDashboardWorker()
    worker?.doSomeWork()
    
    let response = MyStoreDashboard.Something.Response()
    presenter?.presentSomething(response: response)
  }
    
    func callDashBoardApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetDashbordScreen, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            
            let imgBanner = response?["logo"] as? String
            let imgCover = response?["banner"] as? String
            let totalProduct = response?["total_product"] as? Int
            
            self.presenter?.passDashboardData(imgBanner ?? "",imgCover ?? "",totalProduct ?? 0)
        }
    }
    
    func callCategoryApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetCategories, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            
            let CategoryCount = response?["count"] as? Int
            
            self.presenter?.getCategoryValue(CategoryCount ?? 0)
        }
    }
}
