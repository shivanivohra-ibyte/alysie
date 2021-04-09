//
//  EditSetingTypeViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 07/04/21.
//

import UIKit

class EditSetingTypeViewController: AlysieBaseViewC {

    //MARK: @IBOutlet
    @IBOutlet weak var settingTypeCollectionView: UICollectionView!
    @IBOutlet weak var viewShadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("modelRoleID--------------------------------\(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? "")")
        self.viewShadow.drawBottomShadow()
    }
  
    private func getSettingCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let settingsTableCell = settingTypeCollectionView.dequeueReusableCell(withReuseIdentifier: EditSettingTypeCollectionViewCell.identifier(), for: indexPath) as? EditSettingTypeCollectionViewCell else {return UICollectionViewCell()}
        settingsTableCell.configure(indexPath)
      return settingsTableCell
    }

    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }


}
extension EditSetingTypeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //let roleID =  UserRoles(rawValue: "\(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? "0")") ?? .voyagers
        let roleID = UserRoles(rawValue: Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId ?? 0)) ?? .voyagers
        if roleID == .voyagers {
        return StaticArrayData.kEditSettingVoyColScreenDict.count
        }else {
            return StaticArrayData.kEditSettingUserColScreenDict.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.getSettingCollectionCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
                _ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
            default:
                print("HubSelection")
                let nextVC = CountryListVC()
                nextVC.hasCome = .showCountry
                nextVC.isEditHub = true
                nextVC.selectedHubs = []
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
       }
}

extension EditSetingTypeViewController: CHTCollectionViewDelegateWaterfallLayout {

    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 75)
        }else{
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 76)
        }

    }
}


