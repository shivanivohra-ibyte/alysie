//
//  AmountViewModel.swift
//  Alysei
//
//  Created by Janu Gandhi on 09/04/21.
//

import Foundation

enum AboutView {
    
    struct Response<T: Codable>: Codable {
        var data:  T?

        private enum CodingKeys: String, CodingKey {
            case data = "data"
        }
    }

    struct producerDataModel: Codable {
        var productType: [String]?
        var about: String?
        var products: String?
        private enum CodingKeys: String, CodingKey {
            case productType = "Product Type"
            case about = "About"
            case products = "Our Products"
        }
    }

    struct restaurantDataModel: Codable {
        var restaurantType: [String]?
        var about: String?
        var Menu: String?
        private enum CodingKeys: String, CodingKey {
            case restaurantType = "Restaurant Type"
            case about = "About"
            case Menu = "Menu"
        }
    }

    struct importorDataModel: Codable {
        var restaurantType: [String]?
        var about: String?
        var Menu: String?
        private enum CodingKeys: String, CodingKey {
            case restaurantType = "Restaurant Type"
            case about = "About"
            case Menu = "Menu"
        }
    }


    struct voiceExpertDataModel: Codable {
        var restaurantType: [String]?
        var about: String?
        var Menu: String?
        private enum CodingKeys: String, CodingKey {
            case restaurantType = "Restaurant Type"
            case about = "About"
            case Menu = "Menu"
        }
    }


    struct travelAgencyDataModel: Codable {
        var restaurantType: [String]?
        var about: String?
        var Menu: String?
        private enum CodingKeys: String, CodingKey {
            case restaurantType = "Restaurant Type"
            case about = "About"
            case Menu = "Menu"
        }
    }


    struct voyagersDataModel: Codable {
        var restaurantType: [String]?
        var about: String?
        var Menu: String?
        private enum CodingKeys: String, CodingKey {
            case restaurantType = "Restaurant Type"
            case about = "About"
            case Menu = "Menu"
        }
    }
}
