//
//  NewFeedModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/4/21.
//

import Foundation

class NewFeedModel{
    var currentPage: Int?
    var data: [NewFeedDataModel]?
    
    init(with dictResponse: [String:Any]){
        self.currentPage = Int.getInt(dictResponse["current_page"])
        if let data = dictResponse["data"] as? [[String:Any]]{
            self.data = data.map({NewFeedDataModel.init(with: $0)})
        }
    }
}

class NewFeedDataModel{
    var activityActionId: Int?
    var subjectId: SubjectData?
    var body: String?
    //var shared_post_id:
    var attachmentCount: Int?
    var commentCount: Int?
    var likeCount: Int?
    var privacy: String?
    var likeFlag: Int?
    
    init(with dictResponse: [String:Any]){
        self.activityActionId = Int.getInt(dictResponse["activity_action_id"])
        if let subjectId = dictResponse["subject_id"] as? [String:Any]{
            self.subjectId = SubjectData.init(with: subjectId)
        }
        self.body = String.getString(dictResponse["body"])
        self.attachmentCount = Int.getInt(dictResponse["attachment_count"])
        self.commentCount = Int.getInt(dictResponse["comment_count"])
        self.likeCount = Int.getInt(dictResponse["like_count"])
        self.privacy = String.getString(dictResponse["privacy"])
        self.likeFlag = Int.getInt(dictResponse["like_flag"])
         
    }
}

class SubjectData {
    var userId: Int?
    var name: String?
    var email: String?
    var roleId: Int?
    var companyName: String?
    var restaurantName: String?
    var avatarId: Avatar?
    init(with dictResponse: [String:Any]){
        self.userId = Int.getInt(dictResponse["user_id"])
        self.name = String.getString(dictResponse["name"])
        self.email = String.getString(dictResponse["email"])
        self.roleId = Int.getInt(dictResponse["role_id"])
        self.companyName = String.getString(dictResponse["company_name"])
        self.restaurantName = String.getString(dictResponse["restaurant_name"])
        if let avatar = dictResponse["avatar_id"] as? [String:Any]{
            self.avatarId = Avatar.init(with: avatar)
        }
         
    }
    
}

class Avatar {
    var id: Int?
    var attachmentUrl: String?
    
    init(with dictResponse: [String:Any]){
        self.id = Int.getInt(dictResponse["id"])
        self.attachmentUrl = String.getString(dictResponse["attachment_url"])
    }
}
