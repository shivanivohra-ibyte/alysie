//
//  ConfirmSelectionVC.swift
//  Alysie
//
//

import UIKit
import SVProgressHUD

class ConfirmSelectionVC: UIViewController , SelectList{
    
    var selectedHubs = [SelectdHubs]()
    var reviewSelectedHubs : ReviewHubModel.reviewHubModel?
    
    @IBOutlet weak var tableView: ConfirmSelectionTable!
    @IBOutlet weak var viewHeader: UIView!
    var updatedHubs:(([SelectdHubs])->())?
     var roleId: String?
    var isEditHub:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHeader.addShadow()
        self.tableView.dataDelegate = self
        self.tableView.selectedHubs = selectedHubs
      self.tableView.roleId = self.roleId
        self.tableView.isEditHub = self.isEditHub
        if isEditHub == true{
            self.callReviewHubApi()
        }
    }
    
    func didSelectList(data: Any?, index: IndexPath) {
        guard let data = data as? SelectdHubs else {return}
        let nextVC = StateListVC()
        nextVC.country = data.country
        nextVC.selectedHubs = self.selectedHubs
        nextVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func nextVC(_ sender: UIButton) {
        if self.selectedHubs.isEmpty {
            showAlert(withMessage: "Please select at least 1 hub to continue"){
                self.updatedHubs?(self.selectedHubs)
                self.navigationController?.popViewController(animated: true)
            }
            return
        }
        self.updatedHubs?(self.selectedHubs)
        self.navigationController?.popViewController(animated: true)
    }
    
    func createCityJson(hubs:[CountryHubs]?)->[[String:Any]] {
        var params = [[String:Any]]()
        for hub in hubs ?? [] {
            var pm = [String:Any]()
            pm["country_id"] = hub.country_id
            pm["state_id"] = hub.state_id
            pm["city_id"] = hub.id
            params.append(pm)
        }
        return params
    }
    
}

extension Array {
    func uniqueArray<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}

extension ConfirmSelectionVC {
    func callReviewHubApi(){

        guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.ReviewHub.kReviewHub)", method: .GET) else { return }
        print(urlRequest)
        WebServices.shared.request(urlRequest) {(data, response, statuscode, error) in
            SVProgressHUD.dismiss()
            guard let data = data else {return}
            do{
                //let responsemodel = try JSONDecoder().decode(ReviewHubModel.reviewHubModel, from: data)
                let responseModel = try JSONDecoder().decode(ReviewHubModel.reviewHubModel.self, from: data)
                print(responseModel)
                self.reviewSelectedHubs = responseModel
                self.tableView.reviewSelectedHubs = self.reviewSelectedHubs
                self.tableView.reloadData()
            }catch {
                print(error.localizedDescription)
            }
            if (error != nil) { print(error.debugDescription) }

            
        }
       }
    }

