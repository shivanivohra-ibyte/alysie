//
//  PostCommentsModels.swift
//  Alysei
//
//  Created by Shivani Vohra Gandhi on 11/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum PostComments {
    // MARK: Use cases

    enum Post {
        struct Request: Codable {
            var post_owner_id: Int
            var user_id: Int
            var post_id: Int
            var comment: String
        }
    }

    enum Comment {
        struct Request {
        }
        struct Response: Codable {
            var data: [data]
        }
        struct ViewModel {
        }


        struct data: Codable {
            var body: String
            var updatedAt : String
            var createdAt : String
            var poster: poster?

            private enum CodingKeys: String, CodingKey {
                case updatedAt = "updated_at"
                case createdAt = "created_at"
                case body
                case poster

            }

            func convertDate() -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let date = dateFormatter.date(from: self.createdAt)


                let calendar = Calendar.current
                let date1 = calendar.startOfDay(for: date ?? Date())
                let date2 = calendar.startOfDay(for: Date())

                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date1, to: date2)

                if let year = components.year, year > 0 {
                    return "\(year) y"
                } else if let month = components.month, month > 0 {
                    return "\(month) m"
                } else if let day = components.day, day > 0 {
                    return "\(day) d"
                } else if let hour = components.hour, hour > 0 {
                    return "\(hour) h"
                } else if let minute = components.minute, minute > 0 {
                    return "\(minute) m"
                }


                return ""

            }
        }
        struct poster: Codable {
            var roleID: Int
            var userID: Int
            var name: String?
            var email: String?
            var companyName: String?
            var restaurantName: String?
            var avatarID: Avatar

            private enum CodingKeys: String, CodingKey {
                case roleID = "role_id"
                case userID = "user_id"
                case name
                case email
                case companyName = "company_name"
                case restaurantName = "restaurant_name"
                case avatarID = "avatar_id"
            }
        }

    }
}
