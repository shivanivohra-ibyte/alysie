//
//  RatingReviewModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/6/21.
//

import Foundation

class RatingReviewModel {
    var marketplace_review_rating_id: Int?
    var user_id: Int?
    var id: Int?
    var rating: Int?
    var review: String?
    var user: UserModel?
    var created_at: String?

    
    init(with data: [String:Any]){
        self.marketplace_review_rating_id = Int.getInt(data["marketplace_review_rating_id"])
        self.user_id = Int.getInt(data["user_id"])
        self.id = Int.getInt(data["id"])
        self.rating = Int.getInt(data["rating"])
        self.review = String.getString(data["review"])
        self.created_at = String.getString(data["created_at"])
        if let userData = data["user"] as? [String:Any]{
            self.user = UserModel.init(withDictionary: userData)
        }
    }
}
