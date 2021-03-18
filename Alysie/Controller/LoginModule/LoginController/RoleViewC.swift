//
//  RoleViewC.swift
//  ScreenBuild
//
//  Created by Alendra Kumar on 13/01/21.
//

import UIKit

class RoleViewC: AlysieBaseViewC {

  //MARK:  - IBOutlet -
  
  @IBOutlet weak var collectionViewRole: UICollectionView!
  @IBOutlet weak var btnGetStarted: UIButtonExtended!
  
  //MARK:  - Properties -
  
  var getRoleViewModel: GetRoleViewModel!
    
  //MARK:  - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
  
    super.viewDidLoad()
    self.collectionViewRole.allowsSelection = true
  }
  
  //MARK:  - IBAction -
  
  @IBAction func tapGetStarted(_ sender: UIButton) {
    
    let model = self.getRoleViewModel.arrRoles.filter({$0.isSelected == true})
    let selectedRoleId = model.first?.roleId
    
    if selectedRoleId == nil{
      self.showAlert(withMessage: AlertMessage.kRoleSelection)
    }
    else{
      self.btnGetStarted.isUserInteractionEnabled = false
      self.postRequestToGetWalkthorughScreens(String.getString(selectedRoleId))
    }
  }
  
  @IBAction func tapBack(_ sender: UIButton) {
    
    self.navigationController?.popViewController(animated: true)
  }
  
  //MARK:  - Private Methods -
  
  private func getRoleCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let roleCollectionCell = self.collectionViewRole.dequeueReusableCell(withReuseIdentifier: RoleCollectionCell.identifier(), for: indexPath) as! RoleCollectionCell
    roleCollectionCell.configureData(withGetRoleDataModel: self.getRoleViewModel.arrRoles[indexPath.item])
    return roleCollectionCell
  }
  
  //MARK: - WebService Methods -
  
  private func postRequestToGetWalkthorughScreens(_ selectedRoleId: String) -> Void{
    
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetWalkthroughScreens + selectedRoleId, method: .GET, controller: self, type: 0, param: [:],btnTapped: self.btnGetStarted)
  }
}

//MARK:  - UICollectionViewMethods -

extension RoleViewC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.getRoleViewModel?.arrRoles.count ?? 0
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    self.getRoleCollectionCell(indexPath)
  }
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let width = (kScreenWidth - 100.0) / 3
    return CGSize(width: width,height: width+40.0)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    for i in 0...self.getRoleViewModel.arrRoles.count - 1{
      
      self.getRoleViewModel.arrRoles[i].isSelected = false
    }
    
    let model = self.getRoleViewModel.arrRoles[indexPath.item]
    model.isSelected = true
    self.collectionViewRole.reloadData()
    
//    switch indexPath.item {
//    case 0,1:
//      for i in 0...self.getRoleViewModel.arrRoles.count - 1{
//
//        self.getRoleViewModel.arrRoles[i].isSelected = false
//      }
//
//      let model = self.getRoleViewModel.arrRoles[indexPath.item]
//      model.isSelected = true
//      self.collectionViewRole.reloadData()
//    default:
//      showAlert(withMessage: "Under Development")
//    }
  }
}

extension RoleViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    let dicResponse = kSharedInstance.getDictionary(result)
    switch type {
    case 0:
      let model = self.getRoleViewModel.arrRoles.filter({$0.isSelected == true})
      let controller = pushViewController(withName: MembersWalkthroughViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? MembersWalkthroughViewC
      controller?.getRoleDataModel = model
      controller?.getWalkThroughViewModel = GetWalkThroughViewModel(dicResponse)
    default:
      break
    }
  }
}

