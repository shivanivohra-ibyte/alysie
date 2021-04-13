//
//  ReviewHubModel.swift
//  Alysei
//
//  Created by Gitesh Dang on 13/04/21.
//

import Foundation

enum ReviewHubModel {
    struct reviewHubModel: Codable{
        var data: data?
        var success: Int?
        
        private enum CodingKeys: String, CodingKey {
            case data = "data"
            case success = "success"
        }
        
    }
    struct data: Codable {
        var hubs: [reviewHubsDataModel]?
        
        private enum CodingKeys: String, CodingKey {
            case hubs = "hubs"
        }
    }
    
    struct reviewHubsDataModel: Codable {
        var countryId: Int?
        var countryName: String?
        
        var selectedHubs: [hubArray]?
        var selectedCity: [cityArray]?
        
        private enum CodingKeys: String, CodingKey{
            
            case countryId = "country_id"
            case countryName = "country_name"
            
            case selectedHubs = "selected_hubs"
            case selectedCity = "selected_city"
        }
        
    }
    
    typealias hubArray = reviewHubCityArray
    typealias cityArray = reviewHubCityArray
    
    struct  reviewHubCityArray: Codable {
        var id: Int?
        var countryId: Int?
        var stateId: Int?
        var title: String?
        var city: reviewCityData?
        
        private enum CodingKeys: String, CodingKey{
            
            case id = "id"
            case countryId = "country_id"
            case stateId = "state_id"
            case city = "city"
            case title = "title"
        }
    }
    
    struct reviewCityData : Codable {
        var id: Int?
        var name: String?
        
        private enum CodingKeys: String, CodingKey{
            case id = "id"
            case name = "name"
        }
    }
}
