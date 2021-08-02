//
//  ProductRecentSearchModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import Foundation

class ProductSearchListModel {
    
    var marketplaceRecentSearchId: Int?
    var userId: Int?
    var searchKeyword: String?
    var marketplaceProductId: Int?
    var title: String?
    var product_category_name: String?
    var product_price : String?
    var store_name: String?
    var total_reviews: Int?
    var available_for_sample: String?
    
    
    init(with data: [String:Any]){
        self.marketplaceRecentSearchId = Int.getInt(data["marketplace_recent_search_id"])
        self.userId = Int.getInt(data["user_id"])
        self.searchKeyword = String.getString(data["search_keyword"])
        self.marketplaceProductId = Int.getInt(data["marketplace_product_id"])
        self.title = String.getString(data["title"])
        self.product_category_name = String.getString(data["product_category_name"])
        self.product_price = String.getString(data["product_price"])
        self.store_name = String.getString(data["store_name"])
        self.total_reviews = Int.getInt(data["total_reviews"])
        self.available_for_sample = String.getString(data["available_for_sample"])
    }
    
}
