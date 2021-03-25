//
//  WebServices.swift
//  Alysei
//
//  Created by Gitesh Dang on 25/03/21.
//

import Foundation

class WebServices {
    
    //Shared Instance of WebServices
    static let shared = WebServices()
    
    func request(_ urlRequest: URLRequest,completion: @escaping (Data? , URLResponse?, Error?) -> ()){
        var request = urlRequest
        request.setValue("custom-header-field", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            DispatchQueue.main.async {
                completion(data,response,error)
            }
        }.resume()
    }
}
