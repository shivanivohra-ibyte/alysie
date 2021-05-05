//
//  UserPostsViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/3/21.
//

import UIKit

class UserPostsViewController: AlysieBaseViewC {
    
    @IBOutlet weak var userPost: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension UserPostsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = userPost.dequeueReusableCell(withIdentifier: "UserPostsTableViewCell", for: indexPath) as? UserPostsTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 410
    }
}
