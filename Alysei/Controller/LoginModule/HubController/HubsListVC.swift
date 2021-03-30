//
//  HubsListVC.swift
//  Alysie
//
//

import UIKit

class HubsListVC: UIViewController {
    
    // MARK:- Objects
    @IBOutlet weak var tableView: HubsListTable!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var bottomStackHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewBottomStack: UIView!
    
    var city = [CountryHubs]()
    var country: CountryModel?
    var selectedHubs = [SelectdHubs]()
    var hubsViaCity:[HubsViaCity]?
    var hasCome:HasCome? = .hubs
    var roleId: String?
    
  
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHeader.addShadow()
        self.tableView.hasCome = self.hasCome
        self.tableView.country = self.country
        self.tableView.roleId = self.roleId
        self.lblHeading.text = self.hasCome == .hubs ? "Select Hubs" : "Find your City"
         hideEyeIcon = self.hasCome == .hubs ? false : true
        self.bottomStack.isHidden = self.hasCome == .hubs ? false : true
        self.viewBottomStack.isHidden = self.hasCome == .hubs ? false : true
        self.bottomStackHeight.constant = self.hasCome == .hubs ? 30 : 0
        self.bottomStack.backgroundColor = UIColor.init(hexString: "#1D4873")
        self.hasCome == .hubs ? self.callHubViewApi() : self.postRequestToGetCity()
    }
    
    
    private func callHubViewApi(){
        let countryID = String.getString(country?.id)
        let cityID = kSharedInstance.getStringArray(self.city.map{$0.id})
        let params: [String:Any] = [ "params": [ countryID: cityID]]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kgetHubs, requestMethod: .GET, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard  let data = response["data"] as? [String:Any] else {return}
            let hubs = kSharedInstance.getArray(withDictionary: data["hubs"])
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            let selectedCity = kSharedInstance.getStringArray(selectedHub?.hubs.map{$0.id})
            self.hubsViaCity = hubs.map{HubsViaCity(data: $0)}
            for hub in self.hubsViaCity ?? [] {
               _ = hub.hubs_array?.map{ $0.isSelected = selectedCity.contains($0.id ?? "")}
            }
            self.tableView.hubsViaCity = self.hubsViaCity
        }
    }
    
//    self.countries = data.map{CountryModel(data: $0)}
//    let selectedHubsC = kSharedInstance.getStringArray(self.selectedHubs.map{$0.country.id})
//    _ = self.countries?.map{$0.isSelected = selectedHubsC.contains($0.id ?? "")}
//    self.tableVIew.countries = self.countries
    
    private func postRequestToGetCity() -> Void{
        let countryID = String.getString(country?.id)
        let cityID = kSharedInstance.getStringArray(self.city.map{$0.id})
        let param: [String:Any] = ["params": cityID]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetHubCity, requestMethod: .POST, requestParameters: param, withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard  let data = response["data"] as? [String:Any] else {return}
            let hubs = kSharedInstance.getArray(withDictionary: data["cities"])
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            let selectedCity = kSharedInstance.getStringArray(selectedHub?.hubs.map{$0.id})
            self.hubsViaCity = hubs.map{HubsViaCity(city: $0)}
            for hub in self.hubsViaCity ?? [] {
                _ = hub.hubs_array?.map{ $0.isSelected = selectedCity.contains($0.id ?? "")}
            }
            self.tableView.hubsViaCity = self.hubsViaCity
        }
    }
    @IBAction func nextButtonAction(_ sender: UIButton) {
        var selectedHubs = [CountryHubs]()
        for hub in self.hubsViaCity ?? [] {
            for subHub in hub.hubs_array ?? [] { if subHub.isSelected {selectedHubs.append(subHub)}}
        }
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        selectedHub?.hubs = (selectedHub?.hubs.filter{$0.type == .hubs} ?? []) + selectedHubs
        //selectedHub?.hubs = (selectedHub?.hubs.filter{$0.type == .city} ?? []) + selectedHubs
        let oldHubs = selectedHub?.hubs.filter{$0.type != self.hasCome} ?? []
        selectedHub?.hubs = oldHubs +  selectedHubs
        if selectedHub?.hubs.isEmpty ?? false {
            showAlert(withMessage: "Please select atleast one hub")
        }else{
        let nextVC = CountryListVC()
        nextVC.hasCome = .showCountry
        nextVC.selectedHubs = self.selectedHubs
        self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
    @IBAction func clickHear(_ sender: UIButton) {
        var selectedHubs = [CountryHubs]()
        for hub in self.hubsViaCity ?? [] {
            for subHub in hub.hubs_array ?? [] { if subHub.isSelected {selectedHubs.append(subHub)}}
        }
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        selectedHub?.hubs = (selectedHub?.hubs.filter{$0.type == .city} ?? []) + selectedHubs
        let nextvc = HubsListVC()
        nextvc.country = self.country
        nextvc.city =  self.city
        nextvc.hasCome = .city
        nextvc.selectedHubs = self.selectedHubs
        self.navigationController?.pushViewController(nextvc, animated: true)
    }
}
extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
