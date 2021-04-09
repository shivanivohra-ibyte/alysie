//
//  StateListVC.swift
//  Alysie
//
//

import UIKit
var userType: String?
var hideEyeIcon: Bool?

class StateListVC: AlysieBaseViewC , SelectList {
    
    // MARK:- objects
    @IBOutlet weak var tableVIew: StateListTable!
    @IBOutlet weak var lblHeaderText: UILabel!
    var selectedHubs = [SelectdHubs]()
    var country:CountryModel?
    var states:[CountryHubs]?
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var labelHeading: UILabel!
    var isEditHub: Bool?
    var roleId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHeader.addShadow()
        self.tableVIew.selectDelegate = self
        self.tableVIew.roleId = self.roleId
        hideEyeIcon = true
        self.setText()
        self.isEditHub == true ? self.requestToGetSelectedState(country?.id ?? "") : self.postRequestToGetState(country?.id ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableVIew.reloadData()
    }
    func setText(){
      
      if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
            userType = "export"
        }else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "4" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "5" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "6") {
            userType = "import"
        }else{
            userType = "loreum"
        }
        if let attributedString = self.createAttributedString(stringArray: ["Select the states from ","\(country?.name ?? "")", " where you \(userType ?? "")"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue]) {
            self.lblHeaderText.attributedText = attributedString
        }
        if kSharedUserDefaults.loggedInUserModal.memberRoleId == "3"{
            labelHeading.text = "Where you want to export?"
        }else if (kSharedUserDefaults.loggedInUserModal.memberRoleId == "4" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "5" || kSharedUserDefaults.loggedInUserModal.memberRoleId == "6"){
            labelHeading.text = "Where you import?"
        }else {
            labelHeading.text = "Loreum lore lreum reum um ruse"
        }

    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
        selectedHub?.state = self.states?.filter{$0.isSelected} ?? []
        if selectedHub?.state.isEmpty ?? false {
            showAlert(withMessage: "Please select atleast one state")
        }else{
        let nextvc = HubsListVC()
        nextvc.country = selectedHub?.country
          nextvc.roleId = self.roleId
        nextvc.city =  (self.states?.filter{$0.isSelected} ?? [])
        nextvc.selectedHubs = self.selectedHubs
        self.navigationController?.pushViewController(nextvc, animated: true)
        print(selectedHub)
        }
    }
    //let oldHubs = selectedHub?.hubs.filter{$0.type != self.hasCome} ?? []
    //selectedHub?.hubs = oldHubs +  selectedHubs
    
    private func postRequestToGetState(_ countryId: String) -> Void{
        disableWindowInteraction()
        let param: [String:Any] = [APIConstants.kCountryId: countryId]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetHubState, requestMethod: .GET, requestParameters: param, withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard let data = response["data"] as? [[String:Any]] else {return}
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            let hubs = kSharedInstance.getStringArray(selectedHub?.state.map{$0.id})
            self.states = data.map{CountryHubs(data: $0)}
            _ = self.states?.map{$0.isSelected = hubs.contains($0.id ?? "")}
            self.tableVIew.states = self.states
        }
    }
    
    private func requestToGetSelectedState(_ countryId: String) -> Void{
        disableWindowInteraction()
        let param: [String:Any] = [APIConstants.kCountryId: countryId]
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetSelectedHubStates, requestMethod: .GET, requestParameters: param, withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            guard let data = response["data"] as? [[String:Any]] else {return}
            let selectedHub = self.selectedHubs.first{$0.country.id == self.country?.id}
            let hubs = kSharedInstance.getStringArray(selectedHub?.state.map{$0.id})
            self.states = data.map{CountryHubs(data: $0)}
            if self.isEditHub == false{
            _ = self.states?.map{$0.isSelected = hubs.contains($0.id ?? "")}
            }else{
                print("Check Remaning")
            }
            self.tableVIew.states = self.states
        }
    }
    func didSelectList(data: Any?, index: IndexPath) {
        print(data,index)
    }
}

