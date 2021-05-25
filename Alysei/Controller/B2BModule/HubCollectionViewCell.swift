//
//  HubCollectionViewCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/25/21.
//

import UIKit

class HubCollectionViewCell: UICollectionViewCell {
    
    //var titleArray = ["Italian Restaurants in US","Importers & Distributors","Travel Agencies","Voice of Experts","Italian F&B Producers"]
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lblUserCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configData(_ index: Int, _ data: UserRoleCount){
        title.text = data.name
        lblUserCount.text = "\(data.userCount ?? 0)"
    }
}
