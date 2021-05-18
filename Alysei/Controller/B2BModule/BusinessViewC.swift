//
//  BusinessViewC.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit
import DropDown

class BusinessViewC: AlysieBaseViewC {
  
  //MARK: - Properties -
  
  var currentIndex: Int = 0
  var businessViewModel = BusinessViewModel(currentIndex: 0)
    var txtkeywordSearch : String?
    var searchType:Int?
    var passId: Int?
    var newSearchModel: NewFeedSearchModel?
    var arrDataModel = [NewFeedSearchDataModel]()
    var indexOfPageToRequest = 1
     
  
  private var currentChild: UIViewController {
      return self.children.last!
  }
  
  private lazy var selectedHubsViewC: SelectedHubsViewC = {

    let selectedHubsViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: SelectedHubsViewC.id()) as! SelectedHubsViewC
    return selectedHubsViewC
  }()

  private lazy var businessListViewC: BusinessListViewC = {

    let businessListViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: BusinessListViewC.id()) as! BusinessListViewC
    return businessListViewC
  }()
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewBusinessCategory: UICollectionView!
  @IBOutlet weak var tblViewSearchOptions: UITableView!
  //@IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
  //@IBOutlet weak var containerView: UIView!
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
   super.viewDidLoad()
    //self.tblViewHeightConstraint.constant = 300.0
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapNotification(_ sender: UIButton) {
    
    _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
  
  
  //MARK: - Private Methods -
  
//  private func moveToNew(childViewController newVC: UIViewController,fromController oldVC: UIViewController, completion:((() ->Void)? ) = nil){
//
//      if  oldVC == newVC {
//        completion?()
//        return
//      }
//      DispatchQueue.main.async {
//
//          self.view.isUserInteractionEnabled = false
//          self.addChild(newVC)
//          newVC.view.frame = self.containerView.bounds
//
//        oldVC.willMove(toParent: nil)
//
//        self.transition(from: oldVC, to: newVC, duration: 0.25, options: UIView.AnimationOptions(rawValue: 0), animations:{
//
//          })
//          { (_) in
//
//              oldVC.removeFromParent()
//              newVC.didMove(toParent: self)
//              self.view.isUserInteractionEnabled = true
//              completion?()
//          }
//      }
//  }
  
  private func getBusinessCategoryCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let businessCategoryCollectionCell = collectionViewBusinessCategory.dequeueReusableCell(withReuseIdentifier: BusinessCategoryCollectionCell.identifier(), for: indexPath) as! BusinessCategoryCollectionCell
    //_ = (self.currentIndex == 0) ? self.moveToNew(childViewController: selectedHubsViewC, fromController: self.currentChild) :   self.moveToNew(childViewController: businessListViewC, fromController: self.currentChild)
    businessCategoryCollectionCell.configureData(indexPath: indexPath, currentIndex: self.currentIndex)
    return businessCategoryCollectionCell
  }
  
  private func getBusinessTextFieldTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let businessTextFieldTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessTextFieldTableCell.identifier()) as! BusinessTextFieldTableCell
    businessTextFieldTableCell.passTextCallBack = { text in
        self.txtkeywordSearch = text
    }
    return businessTextFieldTableCell
  }
  
  private func getBusinessButtonTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let businessButtonTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessButtonTableCell.identifier()) as! BusinessButtonTableCell
    businessButtonTableCell.configureData(withBusinessDataModel: self.businessViewModel.arrBusinessData[indexPath.row], currentIndex: self.currentIndex)
    businessButtonTableCell.passIdCallBack = { id in
        self.passId = id
    }
    return businessButtonTableCell
  }
  
  private func getBusinessFiltersTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let businessFiltersTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessFiltersTableCell.identifier()) as! BusinessFiltersTableCell
    businessFiltersTableCell.configureData(withBusinessDataModel: self.businessViewModel.arrBusinessData[indexPath.row])
    return businessFiltersTableCell
  }
  
  private func getBusinessSearchTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let businessSearchTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessSearchTableCell.identifier()) as! BusinessSearchTableCell
    businessSearchTableCell.searchTappedCallback = {
        self.callSearchApi()
    }
    return businessSearchTableCell
  }
  
  private func getSelectedHubsTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let selectedHubsTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: SelectedHubsTableCell.identifier()) as! SelectedHubsTableCell
    selectedHubsTableCell.delegate = self
    selectedHubsTableCell.configData(arrDataModel)
    selectedHubsTableCell.collectionViewSelectedHubs.reloadData()
    return selectedHubsTableCell
  }
  
  private func getBusinessListTableCell(_ indexPath: IndexPath) -> UITableViewCell{
    
    let businessListTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessListTableCell.identifier()) as! BusinessListTableCell
    return businessListTableCell
  }
    
  
}

//MARK: - CollectionView Methods -

extension BusinessViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return StaticArrayData.kBusinessCategoryDict.count
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if self.currentIndex == 0 {
        self.searchType = 3
    }else{
        self.searchType = 1
    }
    return self.getBusinessCategoryCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
    self.currentIndex = indexPath.item
    
    self.businessViewModel = BusinessViewModel(currentIndex: indexPath.item)
    collectionViewBusinessCategory.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    //self.tblViewHeightConstraint.constant = (CGFloat(self.businessViewModel.arrBusinessData.count) * 70.0) + 90.0
    self.collectionViewBusinessCategory.reloadData()
    self.tblViewSearchOptions.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 145.0, height: 45.0)
  }
    
}


//MARK:  - UITableViewMethods -

extension BusinessViewC: UITableViewDataSource, UITableViewDelegate{
        
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let model = self.businessViewModel.arrBusinessData[section]
    
    switch model.businessCellType {
    case .tableListCell:
      return model.cellCount
    default:
      return self.businessViewModel.arrBusinessData.count
    }
  }
        
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let model = self.businessViewModel.arrBusinessData[indexPath.row].businessCellType
    switch model {
    case .textFieldCell:
      return self.getBusinessTextFieldTableCell(indexPath)
    case .collectionFilters:
      return self.getBusinessFiltersTableCell(indexPath)
    case .searchCell:
      return self.getBusinessSearchTableCell(indexPath)
    case .collectionHubs:
      return self.getSelectedHubsTableCell(indexPath)
    case .tableListCell:
      return self.getBusinessListTableCell(indexPath)
    default:
      return self.getBusinessButtonTableCell(indexPath)
    }
  }
        
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let model = self.businessViewModel.arrBusinessData[indexPath.row]
    switch model.businessCellType {
    case .searchCell:
      return 100.0
    case .collectionHubs:
      let cellSize = CGFloat(model.cellCount) / 3.0
      return 180.0 * cellSize
    case .tableListCell:
      return 66.0
    default:
      return 70.0
    }
  }
        
}


extension BusinessViewC: TappedHubs{
  
  func tapOnHub(){
    
    
    
  }
}

extension BusinessViewC {
    func callSearchApi(){
        
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kKeywordSearch + "\(searchType ?? 1)" + "&keyword=" + "\(txtkeywordSearch ?? "")" + "&state=" + "\(self.passId ?? 0)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrDataModel.removeAll() }
                self.arrDataModel.append(contentsOf: self.newSearchModel?.data ?? [NewFeedSearchDataModel(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            self.tblViewSearchOptions.reloadData()
           
            
        }
    }
    
   
}
