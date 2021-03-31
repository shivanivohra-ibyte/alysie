//
//  SettingsScreenVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 3/31/21.
//

import UIKit


class SettingsScreenVC: AlysieBaseViewC {

    @IBOutlet weak var settingCollectionView: UICollectionView!
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var settingCollectionViewHght: NSLayoutConstraint!
    @IBOutlet weak var settingtableViewHght: NSLayoutConstraint!
    @IBOutlet weak var viewShadow: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewShadow.drawBottomShadow()
        self.settingTableView.tableFooterView = UIView()
    }
  
    private func getSettingCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let settingsTableCell = settingCollectionView.dequeueReusableCell(withReuseIdentifier: SettingsScreenCollectionVC.identifier(), for: indexPath) as? SettingsScreenCollectionVC else{return UICollectionViewCell()}
        settingsTableCell.configure(indexPath)
      return settingsTableCell
    }
    private func getSettingTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
      let settingsTableCell = settingTableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier(), for: indexPath) as! SettingsTableCell
          settingsTableCell.configure(indexPath)
      return settingsTableCell
    }
    @IBAction func tapBack(_ sender: UIButton) {
      
      self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tapLogout(_ sender: UIButton) {

      kSharedUserDefaults.clearAllData()
    }
}

extension SettingsScreenVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
        settingCollectionViewHght.constant = CGFloat(85 * (StaticArrayData.kSettingPrducrColScreenDict.count))
        return StaticArrayData.kSettingPrducrColScreenDict.count
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "10"{
            settingCollectionViewHght.constant = CGFloat(85 * (StaticArrayData.kSettingVoyaColScreenDict.count))
            return StaticArrayData.kSettingVoyaColScreenDict.count
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "9"{
            settingCollectionViewHght.constant = CGFloat(85 * (StaticArrayData.kSettingRestColScreenDict.count))
            return StaticArrayData.kSettingRestColScreenDict.count
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "7"{
            settingCollectionViewHght.constant = CGFloat(85 * (StaticArrayData.kSettingExpertColScreenDict.count))
            return StaticArrayData.kSettingExpertColScreenDict.count
        }else if kSharedUserDefaults.loggedInUserModal.memberRoleId == "8"{
            settingCollectionViewHght.constant = CGFloat(85 * (StaticArrayData.kSettingTravlColScreenDict.count))
            return StaticArrayData.kSettingTravlColScreenDict.count
        }else {
            settingCollectionViewHght.constant = CGFloat(85 * (StaticArrayData.kSettingImprtrColScreenDict.count))
            return StaticArrayData.kSettingImprtrColScreenDict.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.getSettingCollectionCell(indexPath)
    }
 
}

extension SettingsScreenVC: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 100)
        }else{
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 85)
        }
        
    }
}

//MARK: - TableView Methods -

extension SettingsScreenVC: UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    StaticArrayData.kSettingPrdrTblScreenDict.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     return self.getSettingTableCell(indexPath)
   }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    settingtableViewHght.constant = CGFloat(60 * (StaticArrayData.kSettingPrducrColScreenDict.count))
    return 60.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
//    switch indexPath.row {
//    case 0:
//      _ = pushViewController(withName: EditUserSettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as! EditUserSettingsViewC
//    case 1:
//      _ = pushViewController(withName: CompanyViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
//    case 3:
//      _ = pushViewController(withName: UpdatePasswordViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
//    case 4:
//      _ = pushViewController(withName: BlockingViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
//    case 5:
//      _ = pushViewController(withName: MembershipViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
//    case 7:
//      _ = pushViewController(withName: YourDataViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
//    default:
//      break
//    }
  }
}
