//
//  AboutViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit

enum AboutView {
    struct Response: Codable {
        var data: data
    }

    struct data: Codable {
        var productType: [String]?
        var about: [String]?
        var products: [String]?

        private enum CodingKeys: String, CodingKey {
            case productType = "Product Type"
            case about = "About"
            case products = "Our Products"

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
