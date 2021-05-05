//
//  PostDescTableViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/26/21.
//

import UIKit

class PostDescTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var lblPostDesc: UILabel!
    @IBOutlet weak var lblPostLikeCount: UILabel!
    @IBOutlet weak var lblPostCommentCount: UILabel!
    @IBOutlet weak var imageHeightCVConstant: NSLayoutConstraint!
    @IBOutlet weak var imagePostCollectionView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    
    var data: NewFeedDataModel?
    var likeCallback:((Int) -> Void)? = nil
    var islike: Int?
    var index: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.masksToBounds = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(likeAction))
        self.viewLike.addGestureRecognizer(tap)
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configCell(_ data: NewFeedDataModel, _ index: Int){
        self.data = data
        self.index = index
        userName.text = data.subjectId?.name
        userNickName.text = data.subjectId?.companyName
        lblPostDesc.text = data.body
        lblPostLikeCount.text = "\(data.likeCount ?? 0)"
        lblPostCommentCount.text = "\(data.commentCount ?? 0)"
        //islike = data.likeFlag
        if data.attachmentCount == 0 {
            imageHeightCVConstant.constant = 0
            imagePostCollectionView.isHidden = true
        }else{
            imageHeightCVConstant.constant = 220
            imagePostCollectionView.isHidden = false
        }
        self.userImage.setImage(withString: kImageBaseUrl + String.getString(data.subjectId?.avatarId?.attachmentUrl))
        likeImage.image = data.likeFlag == 0 ? UIImage(named: "like_icon") : UIImage(named: "liked_icon")
    }
    @objc func likeAction(_ tap: UITapGestureRecognizer){
        if self.data?.likeFlag == 0 {
            islike = 1
        }else{
            islike = 0
        }
        callLikeUnlikeApi(self.islike, self.data?.activityActionId, self.index)
    }


}
extension PostDescTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.attachmentCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imagePostCollectionView.dequeueReusableCell(withReuseIdentifier: "PostImageCollectionViewCell", for: indexPath) as? PostImageCollectionViewCell else{return UICollectionViewCell()}
        return cell
    }
    
    
}

extension PostDescTableViewCell {
    
    func callLikeUnlikeApi(_ isLike: Int?, _ postId: Int? ,_ indexPath: Int?){
        let params: [String:Any] = [
            "post_id": postId ?? 0,
            "like_or_unlike": isLike ?? 0
        ]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kLikeApi, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            self.likeCallback?(indexPath ?? 0)
        }
    }
}

class PostImageCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var imagePost: UIImageView!
}


