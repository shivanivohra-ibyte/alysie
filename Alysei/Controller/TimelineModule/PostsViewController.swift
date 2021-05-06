//
//  PostsViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/26/21.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    var scrollCallBack: (() -> Void)? = nil
    var newFeedModel: NewFeedModel?
    var arrNewFeedDataModel = [NewFeedDataModel]()
    var selectedPostId: Int?
    var likeUnlike: Int?
    var indexOfPageToRequest = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // callNewFeedApi(pageNo)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrNewFeedDataModel.removeAll()
        callNewFeedApi(1)
    }
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - (self.view.frame.height * 2) {

            // increments the number of the page to request
            indexOfPageToRequest += 1

            // call your API for more data
            callNewFeedApi(indexOfPageToRequest)

            // tell the table view to reload with the new data
            self.postTableView.reloadData()
        }
    }
}


extension PostsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        return 1
        }else{
            return arrNewFeedDataModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        guard let cell = postTableView.dequeueReusableCell(withIdentifier: "DiscoverTableViewCell") as? DiscoverTableViewCell else{return UITableViewCell()}
            cell.selectionStyle = .none
        return cell
        }else{
            guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostDescTableViewCell") as? PostDescTableViewCell else{return UITableViewCell()}
            cell.selectionStyle = .none
            cell.configCell(arrNewFeedDataModel[indexPath.row] , indexPath.row)
            let data = arrNewFeedDataModel[indexPath.row]
            cell.likeCallback = { index in
                //self.postTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
                cell.lblPostLikeCount.text = "\(data.likeCount ?? 0)"
                cell.likeImage.image = data.likeFlag == 0 ? UIImage(named: "like_icon") : UIImage(named: "liked_icon")

            }
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0{
//        return 150
//        }else{
//            return UITableView.automaticDimension
//        }
   // }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row + 1 == newFeedModel?.data?.count {
//            print("do something")
//            pageNo = pageNo + 1
//            self.callNewFeedApi(pageNo)
//        }
//    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.section == 1 &&
//            indexPath.row == (arrNewFeedDataModel.count - 1) {
//            // Notify interested parties that end has been reached
//            print("do something")
//             pageNo = pageNo + 1
//             self.callNewFeedApi(pageNo)
//        }
//    }
    
}


extension PostsViewController {
    func callNewFeedApi(_ pageNo: Int?){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetFeed + "\(pageNo ?? 1)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newFeedModel = NewFeedModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrNewFeedDataModel.removeAll() }
                self.arrNewFeedDataModel.append(contentsOf: self.newFeedModel?.data ?? [NewFeedDataModel(with: [:])])
            }
           
            print("Count -------------------\(self.arrNewFeedDataModel.count)")
            DispatchQueue.main.async { self.postTableView.reloadData()}
            
        }
    }
   
}
