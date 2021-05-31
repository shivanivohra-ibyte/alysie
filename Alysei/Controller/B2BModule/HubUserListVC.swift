//
//  HubUserListVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/27/21.
//

import UIKit

class HubUserListVC: AlysieBaseViewC {
    
    var currentIndex:Int?
    var businessViewModel: BusinessSingleHubViewModel?
    var searchType:Int?
    var newSearchModel: NewFeedSearchModel?
    var arrSearchDataModel = [NewFeedSearchDataModel]()
    var arrSearchimpotrDataModel = [SubjectData]()
    var txtkeywordSearch: String?
    
    //var arrImpSearchList:  NewFeedSearchModel?
    var indexOfPageToRequest = 1
    
    var selectStateId:String?
    var selectImpHubId: String?
    var selectImpProductId: String?
    var selectImpRegionTypeId:String?
    var selectImpRoleId: String?
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
    var selectProducerProductType: String?
    var selectedImpOptionId = [Int]()
    var horecaValue: String?
    var privateValue: String?
    var alyseiBrandValue: String?
    var extraCell: Int?
    var restPickUp: String?
    var restDelivery:String?
    var passHubId:String?
    var passRoleId:String?
    var passUserTitle: String?
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
    private lazy var hubsViewC: HubsViewC = {
        
        let hubsViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: HubsViewC.id()) as! HubsViewC
        return hubsViewC
    }()
    
    //MARK: - IBOutlet -

    @IBOutlet weak var tblViewSearchOptions: UITableView!
    @IBOutlet weak var lblTiltle: UILabel!
    //@IBOutlet weak var containerView: UIView!
    
    //MARK: - ViewLifeCycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchType = 2
        lblTiltle.text = passUserTitle
        self.getUserListFromHubSelctionApi()
        self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
        //self.tblViewHeightConstraint.constant = 300.0
    }
    
    //MARK: IBAction
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
//MARK: Private Method
//    private func getBusinessCategoryCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
//
//        let businessCategoryCollectionCell = collectionViewBusinessCategory.dequeueReusableCell(withReuseIdentifier: BusinessCategoryCollectionCell.identifier(), for: indexPath) as! BusinessCategoryCollectionCell
//        //_ = (self.currentIndex == 0) ? self.moveToNew(childViewController: selectedHubsViewC, fromController: self.currentChild) :   self.moveToNew(childViewController: businessListViewC, fromController: self.currentChild)
//        businessCategoryCollectionCell.configureData(indexPath: indexPath, currentIndex: self.currentIndex ?? 0)
//        return businessCategoryCollectionCell
//    }
    
    private func getBusinessTextFieldTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessTextFieldTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessTextFieldTableCell.identifier()) as! BusinessTextFieldTableCell
        businessTextFieldTableCell.passTextCallBack = { text in
            self.txtkeywordSearch = text
        }
        return businessTextFieldTableCell
    }
    
    private func getBusinessButtonTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessButtonTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessButtonTableCell.identifier()) as! BusinessButtonTableCell
        businessButtonTableCell.configureData(withBusinessDataModel: self.businessViewModel?.arrBusinessData[indexPath.row] ?? BusinessDataModel(), currentIndex: self.currentIndex ?? 0)
        //    businessButtonTableCell.pushVCCallback = {
        //        let model = self.signUpViewModel.arrSignUpStepOne[indexPath.row]
        //        let controller = self.pushViewController(withName: SelectProductViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectProductViewC
        //        controller?.signUpStepOneDataModel = model
        //        controller?.stepOneDelegate = self
        //    }
        businessButtonTableCell.passIdCallBack = {  exprtCuntryId, trvlCuntryId in
            
            self.selectExpertCountryId = exprtCuntryId
           
            self.selectTravelCountryId = trvlCuntryId
            
            
        }
        
        return businessButtonTableCell
    }
    
    private func getBusinessFiltersTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessFiltersTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessFiltersTableCell.identifier()) as! BusinessFiltersTableCell
        businessFiltersTableCell.configureData(withBusinessDataModel: self.businessViewModel?.arrBusinessData[indexPath.row] ??  BusinessDataModel())
        businessFiltersTableCell.passIdCallback = { arrSelectedIndex in
            if self.currentIndex == B2BSearch.Importer.rawValue || self.currentIndex == B2BSearch.Producer.rawValue{
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
            }else{
                self.selectedImpOptionId = arrSelectedIndex
                if self.selectedImpOptionId.contains(0){
                    self.restPickUp = "\(RestValue.pickUp.rawValue)"
                }
                if self.selectedImpOptionId.contains(1){
                    self.restDelivery = "\(RestValue.delivery.rawValue)"
                }
            }
            
        }
        return businessFiltersTableCell
    }
    
    private func getBusinessSearchTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let businessSearchTableCell = tblViewSearchOptions.dequeueReusableCell(withIdentifier: BusinessSearchTableCell.identifier()) as! BusinessSearchTableCell
        businessSearchTableCell.searchTappedCallback = {
//            if self.currentIndex == B2BSearch.Hub.rawValue{
//                self.callSearchHubApi()
//            }else
            if self.currentIndex == B2BSearch.Importer.rawValue{
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
//MARK:  - UITableViewMethods -

extension HubUserListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let model = self.businessViewModel?.arrBusinessData[section]
        //let model = self.businessViewModel.arrBusinessData[currentIndex]
        switch model?.businessCellType {
        case .tableListCell:
            //return model.cellCount
            return model?.cellCount ?? 0
        default:
            return self.businessViewModel?.arrBusinessData.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.businessViewModel?.arrBusinessData[indexPath.row].businessCellType
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
        
        let model = self.businessViewModel?.arrBusinessData[indexPath.row]
        switch model?.businessCellType {
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
extension HubUserListVC: TappedHubs{
    
    func tapOnHub(_ hubId: String?, _ hubName: String?, _ hubLocation: String?){
        let controller = pushViewController(withName: HubsViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? HubsViewC
        controller?.passHubId = hubId
        controller?.passHubName = hubName
        controller?.passHubLocation = hubLocation
    }
}

extension HubUserListVC {
    func callSearchImporterApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(passRoleId ?? "")" + "&hubs=" + "\(self.passHubId ?? "")" + "&user_type=" + "\(selectImpRoleId ?? "")" + "&product_type=" + "\(self.selectImpProductId ?? "")" + "&region=" + "\(self.selectImpRegionTypeId ?? "")" + "&horeca=" + "\(self.horecaValue ?? "")" + "&private_label=" + "\(self.privateValue ?? "")" + "&alysei_brand_label=" + "\(self.alyseiBrandValue ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 { self.arrSearchDataModel.removeAll() }
                //self.arrSearchDataModel.append(contentsOf: self.newSearchModel?.data ?? [NewFeedSearchDataModel(with: [:])])
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
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    func callSearchProducerApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.producer.rawValue)" + "&hubs=" + "\(self.passHubId ?? "")" + "&product_type=" + "\(selectProducerProductType ?? "")" + "&region=" + "\(self.selectProducerRegionId ?? "")" + "&horeca=" + "\(self.horecaValue ?? "")" + "&private_label=" + "\(self.privateValue ?? "")" + "&alysei_brand_label=" + "\(self.alyseiBrandValue ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
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
            self.selectProducerProductType = ""
            self.selectProducerRegionId = ""
            self.horecaValue = ""
            self.privateValue = ""
            self.alyseiBrandValue = ""
            //self.tblViewSearchOptions.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    func callSearchResturntApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.restaurant.rawValue)" + "&hubs=" + "\(self.passHubId  ?? "")" + "&restaurant_type=" + "\(self.resTypeId ?? "")" + "&pickup=" + "\(restPickUp ?? "")" + "&delivery=" + "\(restDelivery ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dicResponse, error, errorType, statusCode) in
            let dictResponse = dicResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrSearchDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 3
            self.resTypeId = ""
            self.restPickUp = ""
            self.restDelivery = ""
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    
    func callSearchExpertApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.voiceExperts.rawValue)" + "&hubs=" + "\(self.passHubId  ?? "")" + "&expertise=" + "\(self.selectExpertExpertiseId ?? "")" + "&title=" + "\(self.selectExpertTitleId ?? "")" + "&country=" + "\(self.selectExpertCountryId ?? "")" + "&region=" + "\(self.selectExpertRegionId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let dictResponse = dictResponse as? [String:Any]
            
            if let data = dictResponse?["data"] as? [String:Any]{
                self.newSearchModel = NewFeedSearchModel.init(with: data)
                if self.indexOfPageToRequest == 1 {self.arrSearchimpotrDataModel.removeAll() }
                self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
            }
            //self.collectionViewBusinessCategory.reloadData()
            print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
            cellCount = self.arrSearchimpotrDataModel.count
            self.extraCell = 5
            self.selectExpertExpertiseId = ""
            self.selectExpertTitleId = ""
            self.selectExpertCountryId = ""
            self.selectExpertRegionId = ""
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
    
    func callSearchTravelApi(){
        arrSearchimpotrDataModel.removeAll()
        cellCount = 0
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.B2BModule.kSearchApi + "\(searchType ?? 1)" + "&role_id=" + "\(UserRoles.travelAgencies.rawValue)" + "&hubs=" + "\(self.passHubId  ?? "")" + "&speciality=" + "\(self.selectTravelSpecialityId ?? "")" + "&country=" + "\(self.selectTravelCountryId ?? "")" + "&region=" + "\(self.selectTravelRegionId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
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
            self.selectTravelSpecialityId = ""
            self.selectTravelCountryId = ""
            self.selectTravelRegionId = ""
            self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
            self.tblViewSearchOptions.reloadData()
            
            
        }
    }
        func getUserListFromHubSelctionApi(){
            arrSearchimpotrDataModel.removeAll()
            cellCount = 0
            TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetRoleListFromHubSlctn + "\(passHubId ?? "")" + "&role_id=" + "\(passRoleId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errtype, statusCode) in
                let response = dictResponse as? [String:Any]
    
                if let data = response?["data"] as? [[String:Any]]{
                   // self.newSearchModel = NewFeedSearchModel.init(with: data)
                    if self.indexOfPageToRequest == 1 { self.arrSearchimpotrDataModel.removeAll() }
                   // self.arrSearchimpotrDataModel.append(contentsOf: self.newSearchModel?.importerSeacrhData ?? [SubjectData(with: [:])])
                    self.arrSearchimpotrDataModel = data.map({SubjectData.init(with: $0)})
                }
                //self.collectionViewBusinessCategory.reloadData()
                print("CountImpSearch------------------------\(self.arrSearchimpotrDataModel.count)")
                cellCount = self.arrSearchimpotrDataModel.count
                if self.currentIndex == B2BSearch.Producer.rawValue{
                    self.extraCell = 4
                }else if self.currentIndex == B2BSearch.Importer.rawValue{
                    self.extraCell = 5
                }else if self.currentIndex == B2BSearch.Restaurant.rawValue{
                    self.extraCell = 3
                }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                    self.extraCell = 4
                }else if self.currentIndex == B2BSearch.Expert.rawValue{
                    self.extraCell = 5
                }
                self.businessViewModel = BusinessSingleHubViewModel(currentIndex: self.currentIndex ?? 0)
                self.tblViewSearchOptions.reloadData()
    
    
            }
    
            }
        }

