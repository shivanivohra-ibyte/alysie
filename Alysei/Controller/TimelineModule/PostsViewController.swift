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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        guard let cell = postTableView.dequeueReusableCell(withIdentifier: "DiscoverTableViewCell") as? DiscoverTableViewCell else{return UITableViewCell()}
        return cell
        }else{
            guard let cell = postTableView.dequeueReusableCell(withIdentifier: "PostDescTableViewCell") as? PostDescTableViewCell else{return UITableViewCell()}
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
        return 120
        }else{
            return 410
        }
    }
    
}

