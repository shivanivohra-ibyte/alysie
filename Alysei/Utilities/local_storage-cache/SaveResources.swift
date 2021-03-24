//
//  SaveResources.swift
//  Alysei
//
//  Created by Janu Gandhi on 24/03/21.
//

import Foundation
import UIKit

// class for downloading and saving image
class LocalStorage {
    static let shared = LocalStorage()

    func saveImage(_ imageData: Data?, fileName: String) {
        guard let data = imageData else { return }
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            try data.write(to: fileURL)
            print("file saved")
        } catch {
            print("error saving file:", error)
        }
    }


    func fetchImage(_ fileName: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if let data = try? Data(contentsOf: fileURL) {
            if let image = UIImage(data: data) {
                return image
            }
        }
//        if let image = UIImage(contentsOfFile: fileURL.absoluteString) {
//            return image
//        }

        return nil
    }

}

