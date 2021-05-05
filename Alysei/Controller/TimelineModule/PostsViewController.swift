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
    var selectedPostId: Int?
    var likeUnlike: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callNewFeedApi()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callNewFeedApi()
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("Top Reached")
    }
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("Scroll to Top")
//        scrollCallBack?()
//    }
}


extension PostsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        return 1
        }else{
            return newFeedModel?.data?.count ?? 0
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
            cell.configCell(newFeedModel?.data?[indexPath.row] ?? NewFeedDataModel(with: [:]), indexPath.row)
            cell.likeCallback = { index in
               // let indexPath = IndexPath(item: index, section: 1)
                //tableView.reloadRows(at: [indexPath], with: .fade)
                self.callNewFeedApi()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
        return 150
        }else{
            return UITableView.automaticDimension
        }
    }
    
}


extension PostsViewController {
    func callNewFeedApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetFeed, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newFeedModel = NewFeedModel.init(with: data)
            }
            self.postTableView.reloadData()
        }
    }
   
}
