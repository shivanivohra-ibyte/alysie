//
//  UserProfile.swift
//  Alysei
//
//  Created by Janu Gandhi on 01/04/21.
//

import Foundation


enum UserProfile {
    struct profileTopSectionModel: Codable {
        var data: data?
        var success: Int?
    }

    struct data: Codable {
        var about: String?
        var postCount: Int?
        var followerCount: Int?
        var userData: userDataModel?

        private enum CodingKeys: String, CodingKey {
            case about
            case postCount = "post_count"
            case userData = "user_data"
            case followerCount = "follower_count"
        }
    }


    struct userDataModel: Codable {
        var avatar: avatar?
        var cover: cover?
        var userID: Int?
        var companyName: String?
        var username: String?
        var roleID: Int?
        var firstName: String?
        var lastName: String?
        var restaurantName: String?

         private enum CodingKeys: String, CodingKey {
            case avatar = "avatar_id"
            case cover = "cover_id"
            case userID = "user_id"
            case companyName = "company_name"
            case restaurantName = "restaurant_name"
            case username
            case roleID = "role_id"
            case firstName = "first_name"
            case lastName = "last_name"
         }
    }


    typealias avatar = imageAttachementModel
    typealias cover = imageAttachementModel

    struct imageAttachementModel: Codable {
        var id: Int?
        var imageURL: String?

        private enum CodingKeys: String, CodingKey {
            case id
            case imageURL = "attachment_url"
        }

    }
}
