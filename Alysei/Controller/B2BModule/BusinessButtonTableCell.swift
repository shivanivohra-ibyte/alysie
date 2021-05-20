//
//  BusinessButtonTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit
import DropDown

var selectStateId:Int?
var selectImpHubId: Int?
var selectImpProductId: String?
var selectImpRegionTypeId:String?
var resHubId: String?
var resTypeId: String?
var expertHubId: String?
var expertExpertiseId: String?
var expertTitleId:String?
var expertCountryId:String?
var expertRegionId:String?
var travelHubId: String?
var travelSpecialityId: String?
var travelCountryId:String?
var travelRegionId:String?
var producerHubId:String?
var producerRegionId:String?


class BusinessButtonTableCell: UITableViewCell {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var btnBusiness: UIButtonExtended!
    let dataDropDown = DropDown()
    var passIdCallBack:((_ stateId: Int,_ ImphubId: Int,_ ImpproductId:String,_ ImpRegionId:String, _ ResHubId: String,_ ResTypeId: String,_ ExpertHubId: String, _ ExpertExpertiseId: String,_ ExpertTitleId: String,_ ExpertCountryId: String, _ ExpertRegionId: String, _ travelHubId: String, _ travelSpecialityId: String, _ travelCountryId: String, _ travelRegionId: String, _ producerHubId: String, _ producerRegionId: String) -> Void)? = nil
    var stateModel: [StateModel]?
    //var stateName = [String]()
    var userhubs : [HubCityArray]?
    var arrStateName = [String]()
    var arrHubName = [String]()
    var arrProductType = [String]()
    var productType: ProductType?
    var currentIndex: Int?
    var businessModel: BusinessDataModel?
    var fieldValueId:Int?
    
  override func awakeFromNib() {
    self.callStateApi()
    self.callUserHubsApi()
   
    super.awakeFromNib()
    self.btnBusiness.makeCornerRadius(radius: 6.0)
    
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBusiness(_ sender: UIButton) {
    if (currentIndex ==  B2BSearch.Hub.rawValue && businessModel?.businessHeading == AppConstants.SelectState){
        self.dataDropDown.dataSource = self.arrStateName
        self.opendropDown()
    }else if (currentIndex ==  B2BSearch.Importer.rawValue && businessModel?.businessHeading == AppConstants.Hubs) || (currentIndex ==  B2BSearch.Restaurant.rawValue && businessModel?.businessHeading == AppConstants.Hubs) || (currentIndex ==  B2BSearch.Expert.rawValue && businessModel?.businessHeading == AppConstants.Hubs) || (currentIndex ==  B2BSearch.TravelAgencies.rawValue && businessModel?.businessHeading == AppConstants.Hubs) ||  (currentIndex ==  B2BSearch.Producer.rawValue && businessModel?.businessHeading == AppConstants.Hubs){
        self.dataDropDown.dataSource = self.arrHubName
        self.opendropDown()
    }else if (currentIndex ==  B2BSearch.Importer.rawValue && businessModel?.businessHeading == AppConstants.ProductTypeBusiness){
        fieldValueId = B2BFieldId.productType.rawValue
        self.callGetValueOfFieldApi()
        
    }else if (currentIndex ==  B2BSearch.Restaurant.rawValue && businessModel?.businessHeading == AppConstants.RestaurantType){
        fieldValueId = B2BFieldId.restaurantType.rawValue
        self.callGetValueOfFieldApi()
        
    }else if (currentIndex ==  B2BSearch.Expert.rawValue && businessModel?.businessHeading == AppConstants.Expertise){
        fieldValueId = B2BFieldId.expertise.rawValue
        self.callGetValueOfFieldApi()
        
    }else if (currentIndex ==  B2BSearch.Expert.rawValue && businessModel?.businessHeading == AppConstants.Title){
        fieldValueId = B2BFieldId.title.rawValue
        self.callGetValueOfFieldApi()
        
    }else if (currentIndex ==  B2BSearch.Expert.rawValue && businessModel?.businessHeading == AppConstants.SelectCountry) || (currentIndex ==  B2BSearch.TravelAgencies.rawValue && businessModel?.businessHeading == AppConstants.SelectCountry) || (currentIndex ==  B2BSearch.Importer.rawValue && businessModel?.businessHeading == AppConstants.SelectRegion) || (currentIndex ==  B2BSearch.Producer.rawValue && businessModel?.businessHeading == AppConstants.SelectRegion) {
        fieldValueId = B2BFieldId.country.rawValue
        self.callGetValueOfFieldApi()
        
    }else if (currentIndex ==  B2BSearch.Expert.rawValue && businessModel?.businessHeading == AppConstants.SelectRegion) || (currentIndex ==  B2BSearch.TravelAgencies.rawValue && businessModel?.businessHeading == AppConstants.SelectRegion){
        fieldValueId = B2BFieldId.region.rawValue
        self.callGetValueOfFieldApi()
        
    }else if (currentIndex ==  B2BSearch.TravelAgencies.rawValue && businessModel?.businessHeading == AppConstants.Speciality){
        fieldValueId = B2BFieldId.speciality.rawValue
        self.callGetValueOfFieldApi()
        
    }
        
       
  }
  
    func opendropDown(){
        dataDropDown.show()
        dataDropDown.anchorView = btnBusiness
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnBusiness.setTitle(item, for: .normal)
            if self.currentIndex == B2BSearch.Hub.rawValue{
                selectStateId = self.stateModel?[index].id
            }else if self.currentIndex == B2BSearch.Importer.rawValue{
                switch businessModel?.businessHeading {
                    case AppConstants.Hubs:
                        selectImpHubId = self.userhubs?[index].id
                case AppConstants.ProductTypeBusiness:
                    selectImpProductId = self.productType?.options?[index].userFieldOptionId
                case AppConstants.SelectRegion:
                   selectImpRegionTypeId = self.productType?.options?[index].userFieldOptionId
                    default:
                    print("Invalid")
                }
            }else if self.currentIndex == B2BSearch.Restaurant.rawValue {
                switch businessModel?.businessHeading {
                case AppConstants.Hubs:
                    resHubId = "\(self.userhubs?[index].id ?? 0)"
                case AppConstants.RestaurantType:
                    resTypeId = self.productType?.options?[index].userFieldOptionId
                default:
                   print("Invalid")
                }
            }else if self.currentIndex == B2BSearch.Expert.rawValue{
                switch businessModel?.businessHeading {
                case AppConstants.Hubs:
                    expertHubId = "\(self.userhubs?[index].id ?? 0)"
                case AppConstants.Expertise:
                    expertExpertiseId = self.productType?.options?[index].userFieldOptionId
                case AppConstants.Title:
                    expertTitleId = self.productType?.options?[index].userFieldOptionId
                case AppConstants.SelectCountry:
                    expertCountryId = self.productType?.options?[index].userFieldOptionId
                case AppConstants.SelectRegion:
                    expertRegionId = self.productType?.options?[index].userFieldOptionId
                default:
                    print("Invalid")
                }
            }else if self.currentIndex == B2BSearch.TravelAgencies.rawValue{
                switch businessModel?.businessHeading {
                case AppConstants.Hubs:
                 travelHubId = "\(self.userhubs?[index].id ?? 0)"
                case AppConstants.Speciality:
                    travelSpecialityId = self.productType?.options?[index].userFieldOptionId
                case AppConstants.SelectCountry:
                    travelCountryId = self.productType?.options?[index].userFieldOptionId
                case AppConstants.SelectRegion:
                    travelRegionId = self.productType?.options?[index].userFieldOptionId
                default:
                    print("Invalid")
                }
            }else if self.currentIndex == B2BSearch.Producer.rawValue{
                    switch businessModel?.businessHeading {
                    case AppConstants.Hubs:
                        producerHubId = "\(self.userhubs?[index].id ?? 0)"
                    case AppConstants.SelectRegion:
                        producerRegionId = self.productType?.options?[index].userFieldOptionId
                    default:
                        print("Invalid")
                    }
                }

        
            passIdCallBack?((selectStateId ?? 0),selectImpHubId ?? 0,selectImpProductId ?? "0",selectImpRegionTypeId ?? "0", resHubId ?? "0",resTypeId ?? "0",expertHubId ?? "0", expertExpertiseId ?? "0",expertTitleId ?? "0",expertCountryId ?? "0",expertRegionId ?? "0", travelHubId ?? "0", travelSpecialityId ?? "0", travelCountryId ?? "0", travelRegionId ?? "0", producerHubId ?? "0", producerRegionId ?? "0")
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
  //MARK: - Public Methods -
  
  public func configureData(withBusinessDataModel model: BusinessDataModel, currentIndex: Int) -> Void{
    
    self.btnBusiness.setTitle(model.businessHeading, for: .normal)
    self.businessModel = model
    self.currentIndex = currentIndex

    
  }
}
extension BusinessButtonTableCell{
func callStateApi() {
    TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetCountryStates, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
        
        let response = dictResponse as? [String:Any]
        if let data = response?["data"] as? [[String:Any]]{
            self.stateModel = data.map({StateModel.init(with: $0)})
            for state in 0..<(self.stateModel?.count ?? 0) {
                self.arrStateName.append(self.stateModel?[state].name ?? "")
            }
        }
    }
}
    
    func callUserHubsApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetAllHubs, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["hubs"] as? [[String:Any]]{
                self.userhubs = data.map({HubCityArray.init(with: $0)})
                for hub in 0..<(self.userhubs?.count ?? 0) {
                    self.arrHubName.append(self.userhubs?[hub].title ?? "")
                }
            }
        }
    }
    func callGetValueOfFieldApi(){
        self.arrProductType.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetFieldValue + "\(self.fieldValueId ?? 0)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.productType = ProductType.init(with: data)
                print("Count ------------------------------\(self.productType?.options?.count ?? 0)")
                for product in 0..<(self.productType?.options?.count ?? 0) {
                    self.arrProductType.append(self.productType?.options?[product].optionName ?? "")
                }
                self.dataDropDown.dataSource = self.arrProductType
                self.opendropDown()
            }
        }
    }
}
