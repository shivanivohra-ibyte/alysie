//
//  Membership.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/8/21.
//

import Foundation

class Membership{
    var marketplacePackageId: Int?
    var name: String?
    var amount: String?
    var isSelected = false
    
    
    init(with data: [String:Any]?) {
        self.marketplacePackageId = Int.getInt(data?["marketplace_package_id"])
        self.name = String.getString(data?["name"])
        self.amount = String.getString(data?["amount"])

    }
}
