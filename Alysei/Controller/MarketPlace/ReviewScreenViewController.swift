//
//  ReviewScreenViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class ReviewScreenViewController: AlysieBaseViewC {
    @IBOutlet weak var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadow()

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addReview(_ sender: UIButton){
        _ = self.pushViewController(withName: AddReviewViewController.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddReviewViewController
    }
}


extension ReviewScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewScreenTableViewCell", for: indexPath) as? ReviewScreenTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
