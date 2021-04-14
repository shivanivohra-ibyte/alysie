//
//  AboutViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit



class AboutViewC: UIViewController {


    @IBOutlet var aboutCollectionView: UICollectionView!
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var subDetailLabel: UILabel!

    @IBOutlet var listTitleLabel: UILabel!
    @IBOutlet var aboutStaticLabel: UILabel!
    @IBOutlet var subDetailStaticLabel: UILabel!

    var viewModel: AboutView.viewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


        self.aboutCollectionView.delegate = self
        self.aboutCollectionView.dataSource = self

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.resetAllAlpha()
        
        if (self.viewModel?.rows?.count ?? 0) > 0 {
            self.aboutCollectionView.reloadData()
        } else {
            self.aboutCollectionView.alpha = 0.0
            self.listTitleLabel.alpha = 0.0
        }

        if let detail = self.viewModel?.detail {
            self.aboutStaticLabel.text = "\(viewModel?.staticDetail ?? "")"
            self.aboutLabel.text = "\(detail)"
        } else {
            self.aboutStaticLabel.alpha = 0.0
            self.aboutLabel.alpha = 0.0
        }

        if let subDetail = self.viewModel?.subDetail {
            self.subDetailStaticLabel.text = "\(viewModel?.staticSubdetail ?? "")"
            self.subDetailLabel.text = "\(subDetail)"
        } else {
            self.subDetailStaticLabel.alpha = 0.0
            self.subDetailLabel.alpha = 0.0
        }
    }

    func resetAllAlpha() {
        self.aboutCollectionView.alpha = 1.0
        self.listTitleLabel.alpha = 1.0

        self.aboutStaticLabel.alpha = 1.0
        self.aboutLabel.alpha = 1.0

        self.subDetailStaticLabel.alpha = 1.0
        self.subDetailLabel.alpha = 1.0


    }

}


extension AboutViewC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.rows?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutSubviewCollectionViewCell", for: indexPath) as? AboutViewCollectionViewCell else {
            return UICollectionViewCell()
        }

        let title = self.viewModel?.rows?[indexPath.row] ?? ""
        cell.titleLabel.text = "\(title)"
        cell.contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 5.0
        cell.titleLabel.sizeToFit()
        cell.contentView.sizeToFit()
        cell.sizeToFit()
        return cell
    }


}


class AboutViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
}
