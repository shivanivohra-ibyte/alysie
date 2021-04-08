//
//  AboutViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit

enum AboutView {
    struct Response<Element: Codable>: Codable {
        var data:  Element?

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

}

class AboutViewC: UIViewController {


//    @IBOutlet var productTypeCollectionView: UICollectionView!
    @IBOutlet var aboutCollectionView: UICollectionView!
//    @IBOutlet var ourProductsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
