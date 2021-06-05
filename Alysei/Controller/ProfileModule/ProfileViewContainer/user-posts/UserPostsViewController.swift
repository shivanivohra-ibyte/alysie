//
//  UserPostsViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/3/21.
//

import UIKit

class UserPostsViewController: AlysieBaseViewC {
    
    @IBOutlet weak var userPost: UITableView!

    var pageNumber = 1

    //TODO: pagination is pending
    var count = 100

    var postData = [PostList.innerData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.fetchPostWithPhotsFromServer(pageNumber)

        self.userPost.tableFooterView = UIView()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func updatePostList() {
        self.userPost.reloadData()
    }

}

extension UserPostsViewController {
    func fetchPostWithPhotsFromServer(_ page: Int, count: Int = 30) {
        let urlString = APIUrl.Profile.postList + "?page=\(page)&per_page=\(count)"

        guard let request = WebServices.shared.buildURLRequest(urlString, method: .GET) else {
            return
        }
        WebServices.shared.request(request) { data, URLResponse, statusCode, error in
            print("some")

            guard statusCode == 200 else { return }

            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(PostList.request.self, from: data)
                print(response)

                var postData = response.data.data
                if self.pageNumber == 1 {
                    self.postData = postData
                } else {
                    self.postData.append(contentsOf: postData)
                }

                self.updatePostList()

            } catch {
                print(error.localizedDescription)
            }

        }
    }
}

extension UserPostsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = userPost.dequeueReusableCell(withIdentifier: "PostDescTableViewCell", for: indexPath) as? PostDescTableViewCell else { return UITableViewCell() }

        let data = self.postData[indexPath.row]
//        cell.lblPostDesc?.text = data.body
        cell.configCell(NewFeedSearchDataModel(data), indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 410
    }
}




enum PostList {
    struct request: Codable {
        var data: outerData
        var success: Int
    }

    struct outerData: Codable {
        var data: [innerData]
    }

    struct innerData: Codable {
        var attachments: [attachments]
        var body: String?
    }
    
    struct attachments: Codable {
        var attachment_link: attachment_link
    }

    struct attachment_link: Codable {
        var attachment_url: String
    }
}
