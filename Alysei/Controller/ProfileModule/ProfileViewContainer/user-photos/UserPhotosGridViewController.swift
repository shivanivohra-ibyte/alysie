//
//  UserPhotosGridViewController.swift
//  Alysei
//
//  Created by Janu Gandhi on 04/06/21.
//

import UIKit

class UserPhotosGridViewController: AlysieBaseViewC {

    @IBOutlet weak var userPhotosCollectionView: UICollectionView!

    var photos = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()


        self.userPhotosCollectionView.delegate = self
        self.userPhotosCollectionView.dataSource = self
    }


}

extension UserPhotosGridViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserPhotosGridCollectionViewCell else {
            return UICollectionViewCell()
        }

        

        return cell
    }


}

