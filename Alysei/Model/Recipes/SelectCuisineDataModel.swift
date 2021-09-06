//
//  SelectCuisineDataModel.swift
//  Alysei
//
//  Created by namrata upadhyay on 18/08/21.
//

import Foundation

class SelectCuisineDataModel{
    
    var cuisineId: Int?
    var cuisineName: String?
    var imageId: ImageURL?
   
    init(with dictResponse: [String:Any]){
        self.cuisineId = Int.getInt(dictResponse["cousin_id"])
        
            self.cuisineName = String.getString(dictResponse["name"])
        if let image = dictResponse["image_id"] as? [String:Any]{
            self.imageId = ImageURL.init(with: image)
        }
        }
}
