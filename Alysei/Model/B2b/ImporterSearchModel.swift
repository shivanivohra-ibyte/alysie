//
//  ImporterSearchModel.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/20/21.
//

import Foundation

class ImporterSearchModel {
    var currentPage: Int?
    var data: [SubjectData]?
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?
    
    init(with dictResponse: [String:Any]){
        self.currentPage = Int.getInt(dictResponse["current_page"])
        if let data = dictResponse["data"] as? [[String:Any]]{
            self.data = data.map({SubjectData.init(with: $0)})
        }
        self.firstPageUrl = String.getString(dictResponse["first_page_url"])
        self.lastPageUrl = String.getString(dictResponse["last_page_url"])
        self.lastPage = Int.getInt(dictResponse["last_page"])
    }
}
