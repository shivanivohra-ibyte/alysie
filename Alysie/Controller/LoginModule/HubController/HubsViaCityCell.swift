//
//  HubsViaCityCell.swift
//  Alysie
//

import UIKit

class HubsViaCityCell: UITableViewCell , SelectList{
    @IBOutlet weak var tableView: StateListTable!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewSearchHeight:NSLayoutConstraint!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblNoHub: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    var hasCome:HasCome? = .hubs
    var hubsViaCity = HubsViaCity()
    var checkList: String?
    var country: CountryModel?
    var filterHubs = HubsViaCity()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewSearchHeight.constant = hasCome == .hubs ? 0 : 45
        self.viewSearch.isHidden = hasCome == .hubs ? true : false
        self.txtSearch.isHidden = hasCome == .hubs ? true : false
        
        self.hasCome == .hubs ? (txtSearch.isHidden = true) : (txtSearch.isHidden = false)
        self.filterHubs.hubs_array = hubsViaCity.hubs_array
        self.lblNoHub.isHidden = filterHubs.hubs_array?.isEmpty == false
        self.tableView.states = filterHubs.hubs_array
        self.tableView.selectDelegate = self
        self.txtSearch.addTarget(self, action: #selector(self.didchange(_:)), for: .editingChanged)
        self.setText()
    }

    func setText(){
        self.checkList = hasCome == .hubs ? "hubs" : "city"
        if let attributedString = self.createAttributedString(stringArray: ["Select the \(self.checkList ?? "") from ","\(country?.name ?? "")" +  "/" + "\( hubsViaCity.state_name ?? "")", " where you \(userType ?? "")"], attributedPart: 1, attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue]) {
            self.lblHeading.attributedText = attributedString
        }
    }

    @objc func didchange(_ textFeild:UITextField) {
        self.filterHubs.hubs_array?.removeAll()
        self.txtSearch.text?.count != 0  ? self.searchData() : (self.filterHubs.hubs_array = self.hubsViaCity.hubs_array ?? [] )
        self.lblNoHub.isHidden = filterHubs.hubs_array?.isEmpty == false
        self.tableView.states = filterHubs.hubs_array
    }
    
    // MARK:- Function forb Search Data
    func searchData() {
        for tutorial in self.hubsViaCity.hubs_array ?? [] {
            let title = String.getString(tutorial.name).lowercased().range(of: self.txtSearch.text!.lowercased(), options: .anchored, range: nil,   locale: nil)
            title != nil ?  self.filterHubs.hubs_array?.append(tutorial) :  print("No Data found")
            self.lblNoHub.isHidden = filterHubs.hubs_array?.isEmpty == false
            self.tableView.states = filterHubs.hubs_array
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func didSelectList(data: Any?, index: IndexPath) {
        print(data,index)
    }
}
