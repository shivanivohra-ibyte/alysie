//
//  PostCommentsCell.swift
//  Alysei
//
//  Created by Shivani Vohra Gandhi on 11/07/21.
//

import UIKit

class SelfPostCommentsCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var viewReplyButton: UIButton!
}

class OtherUserPostCommentsCell: SelfPostCommentsCell {
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var likeButton: UIButton!
}
