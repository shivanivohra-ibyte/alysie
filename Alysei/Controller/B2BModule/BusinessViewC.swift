//
//  BusinessViewC.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit
import DropDown

var cellCount: Int?

class BusinessViewC: AlysieBaseViewC {
    
    //MARK: - Properties -
    
    var currentIndex: Int = 0
    var businessViewModel = BusinessViewModel(currentIndex: 0)
    var txtkeywordSearch : String?
    var searchType:Int?
    
    var newSearchModel: NewFeedSearchModel?
    var arrSearchDataModel = [NewFeedSearchDataModel]()
    var arrSearchimpotrDataModel = [SubjectData]()
    //var arrImpSearchList:  NewFeedSearchModel?
    var indexOfPageToRequest = 1
    var signUpViewModel: SignUpViewModel!
    var signUpStepOneDataModel: SignUpStepOneDataModel!
    
    var selectStateId:Int?
    var selectImpHubId: Int?
    var selectImpProductId: String?
    var selectImpRegionTypeId:String?
    var resHubId: String?
    var resTypeId: String?
    var selectExpertHubId: String?
    var selectExpertExpertiseId: String?
    var selectExpertTitleId: String?
    var selectExpertCountryId: String?
    var selectExpertRegionId: String?
    var selectTravelHubId: String?
    var selectTravelSpecialityId: String?
    var selectTravelCountryId: String?
    var selectTravelRegionId: String?
    var selectProducerHubId: String?
    var selectProducerRegionId: String?
    
    var selectedImpOptionId = [Int]()
    var horecaValue: String?
    var privateValue: String?
    var alyseiBrandValue: String?
    var extraCell: Int?
    
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
        self.searchType = 3
        callSearchHubApi()
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
        //    businessButtonTableCell.pushVCCallback = {
        //        let model = self.signUpViewModel.arrSignUpStepOne[indexPath.row]
        //        let controller = self.pushViewController(withName: SelectProductViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectProductViewC
        //        controller?.signUpStepOneDataModel = model
        //        controller?.stepOneDelegate = self
        //    }
        businessButtonTableCell.passIdCallBack = { stateId,imphubId,impproductId, impregionId, restHubId, restTypeId, exprtHubId, exprtExprtseId, exprtTitleId, exprtCuntryId, exprtRgnId, travlHubId, trvlSpeclityid, trvlCuntryId, trvlRegionId, producerHubId, producerRegionId in
            self.selectStateId = stateId
            self.selectImpHubId = imphubId
            self.selectImpProductId = impproductId
            self.selectImpRegionTypeId = impregionId
            self.resHubId = restHubId
            self.resTypeId = restTypeId
            self.selectExpertHubId = exprtHubId
            self.selectExpertTitleId = exprtTitleId
            self.selectExpertExpertiseId = exprtExprtseId
            self.selectExpertCountryId = exprtCuntryId
            self.selectExpertRegionId = exprtRgnId
            self.selectTravelHubId = travlHubId
            self.selectTravelSpecialityId = trvlSpeclityid
            self.selectTravelCountryId = trvlCuntryId
            self.selectTravelRegionId = trvlRegionId
            self.selectProducerHubId = producerHubId
            self.selectProducerRegionId = producerRegionId
            
        }
        
        return businessButtonTableCell
    }
    
    private func getBusinessFiltersTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessFiltersTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessFiltersTableCell.identifier()) as! BusinessFiltersTableCell
        businessFiltersTableCell.configureData(withBusinessDataModel: self.businessViewModel.arrBusinessData[indexPath.row])
        businessFiltersTableCell.passIdCallback = { arrSelectedIndex in
            self.selectedImpOptionId = arrSelectedIndex
            if self.selectedImpOptionId.contains(0){
                self.horecaValue = AppConstants.HorecaValue
            }
            if self.selectedImpOptionId.contains(1){
                self.privateValue = AppConstants.PrivateLabelValue
            }
            if self.selectedImpOptionId.contains(2){
                self.alyseiBrandValue = AppConstants.AlyseiBrandValue
            }
            
        }
        return businessFiltersTableCell
    }
    
    private func getBusinessSearchTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessSearchTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessSearchTableCell.identifier()) as! BusinessSearchTableCell
        businessSearchTableCell.searchTappedCallback = {
            if self.currentIndex == B2BSearch.Hub.rawValue{
                self.callSearchHubApi()
            }else if self.currentIndex == B2BSearch.Importer.rawValue{
                self.callSearchImporterApi()
            }else if self.currentIndex == B2BSearch.Restaurant.rawValue {
                self.callSearchResturntApi()
            }else if self.currentIndex == B2BSearch.Expert.rawValue {
                self.callSearchExpertApi()
            }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                self.callSearchTravelApi()
            }else if self.currentIndex == B2BSearch.Producer.rawValue {
                self.callSearchProducerApi()
            }
        }
        return businessSearchTableCell
    }
    
    private func getSelectedHubsTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let selectedHubsTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: SelectedHubsTableCell.identifier()) as! SelectedHubsTableCell
        selectedHubsTableCell.delegate = self
        selectedHubsTableCell.configData(arrSearchDataModel)
        selectedHubsTableCell.collectionViewSelectedHubs.reloadData()
        return selectedHubsTableCell
    }
    
    private func getBusinessListTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessListTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessListTableCell.identifier()) as! BusinessListTableCell
        businessListTableCell.configData(arrSearchimpotrDataModel[(indexPath.row - (self.extraCell ?? 0))])
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
            self.searchType = 2
        }
        return self.getBusinessCategoryCollectionCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
        self.currentIndex = indexPath.item
        switch indexPath.item {
        case 0:
            self.searchType = 3
            callSearchHubApi()
        case 1:
            self.searchType = 2
            callSearchImporterApi()
        case 2:
            self.searchType = 2
            callSearchResturntApi()
        case 3:
            self.searchType = 2
            callSearchExpertApi()
        case 4:
            self.searchType = 2
            callSearchTravelApi()
        case 5:
            self.searchType = 2
            callSearchProducerApi()
        default:
            break
        }
        
        //self.businessViewModel = BusinessViewModel(currentIndex: indexPath.item)
        collectionViewBusinessCategory.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //self.tblViewHeightConstraint.constant = (CGFloat(self.businessViewModel.arrBusinessData.count) * 70.0) + 90.0
        self.collectionViewBusinessCategory.reloadData()
        //self.tblViewSearchOptions.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 145.0, height: 45.0)
    }
    
}


//MARK:  - UITableViewMethods -

extension BusinessViewC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let model = self.businessViewModel.arrBusinessData[section]
        //let model = self.businessViewModel.arrBusinessData[currentIndex]
        switch model.businessCellType {
        case .tableListCell:
            //return model.cellCount
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
            // let cellSize = CGFloat(model.cellCount) / 3.0
            return 180.0  //* cellSize
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
    func callSearchHubApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&keyword=" + "\(txtkeywordSearch ?? "")" + "&state=" + "\(self.selectStateId ?? 0)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchDataModel.removeAll() }
                self.arrSearchDataModel.append(contentsOf: self.newSearchModel?.data ?? [NewFeedSearchDataModel(with: [:])])
            }
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.collectionViewBusinessCategory.reloadData()
            self.tblViewSearchOptions.reloadData()
            
        }
    }
    func callSearchImporterApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.distributer3.rawValue)" + "&hubs=" + "\(self.selectImpHubId ?? 0)" + "&product_type=" + "\(self.selectImpProductId ?? "0")" + "&region=" + "\(self.selectImpRegionTypeId ?? "0")" + "&horeca=" + "\(self.horecaValue ?? "")" + "&private_label=" + "\(self.privateValue ?? "")" + "&alysei_brand_label=" + "\(self.alyseiBrandValue ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchDataModel.removeAll() }
                //self.arrSearchDataModel.append(contentsOf: self.newSearchModel?.data ?? [NewFeedSearchDataModel(with: [:])])
                self.selectImpHubId = 0
                self.selectImpProductId = ""
                self.selectImpRegionTypeId = ""
                self.horecaValue = ""
                self.privateValue = ""
                self.alyseiBrandValue = ""
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 5
            //self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
            print("CellCount--------------------------------------------\(cellCount ?? 0)")
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    func callSearchProducerApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.producer.rawValue)" + "&hubs=" + "\(self.selectProducerHubId ?? "0")" + "&region=" + "\(self.selectProducerRegionId ?? "0")" + "&horeca=" + "\(self.horecaValue ?? "")" + "&private_label=" + "\(self.privateValue ?? "")" + "&alysei_brand_label=" + "\(self.alyseiBrandValue ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 4
            self.selectProducerHubId = "0"
            self.selectProducerRegionId = ""
            self.horecaValue = ""
            self.privateValue = ""
            self.alyseiBrandValue = ""
            //self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    func callSearchResturntApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.restaurant.rawValue)" + "&hubs=" + "\(self.resHubId  ?? "0")" + "&restaurant_type=" + "\(self.resTypeId ?? "0")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrSearchDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 4
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    
    func callSearchExpertApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.voiceExperts.rawValue)" + "&hubs=" + "\(self.selectExpertHubId  ?? "0")" + "&expertise=" + "\(self.selectExpertExpertiseId ?? "0")" + "&title=" + "\(self.selectExpertTitleId ?? "0")" + "&country=" + "\(self.selectExpertCountryId ?? "0")" + "&region=" + "\(self.selectExpertRegionId ?? "0")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 6
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    
    func callSearchTravelApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.travelAgencies.rawValue)" + "&hubs=" + "\(self.selectTravelHubId  ?? "0")" + "&speciality=" + "\(self.selectTravelSpecialityId ?? "0")" + "&country=" + "\(self.selectTravelCountryId ?? "0")" + "&region=" + "\(self.selectTravelRegionId ?? "0")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 5
            self.businessViewModel = BusinessViewModel(currentIndex: self.currentIndex)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
}
