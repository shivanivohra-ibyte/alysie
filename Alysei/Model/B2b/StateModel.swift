//
//  StateModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/18/21.
//

import Foundation

class StateModel{
    var id: Int?
    var name: String?
    init(with data: [String:Any]?) {
        self.id = Int.getInt(data?["id"])
        self.name = String.getString(data?["name"])
    }
    
}
