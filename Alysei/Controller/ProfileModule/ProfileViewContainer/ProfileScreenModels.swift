//
//  ProfileScreenModels.swift
//  Alysei
//
//  Created by Janu Gandhi on 26/06/21.
//

import Foundation


enum ProfileScreenModels {

    struct VoyagersConnectRequest: Codable {
        var userID: Int
        var followStatus: Int // 0 for unfollow and 1 for follow

        private enum CodingKeys: String, CodingKey {
            case userID = "follow_user_id"
            case followStatus = "follow_or_unfollow"
        }

        func urlEncoded() -> Data? {
            let body = "follow_user_id=\(userID)&follow_or_unfollow=\(followStatus)"

            return body.data(using: .utf8)
        }
    }

}
