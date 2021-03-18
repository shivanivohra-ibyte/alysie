//
//  HubsListTable.swift
//  Alysie
//

import Foundation
import UIKit

class HubsListTable: UITableView {
    
    var hubsViaCity:[HubsViaCity]?{didSet{self.reloadData()}}
    var hasCome:HasCome? = .hubs
    var country: CountryModel?
  var roleId: String?
    // MARK:- life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegate()
    }
    func setDelegate() {
        self.register(UINib(nibName: "HubsViaCityCell", bundle: nil), forCellReuseIdentifier: "HubsViaCityCell")
        self.delegate = self
        self.dataSource = self
    }
    
}
// MARK:- cextension of main class for CollectionView
extension HubsListTable : UITableViewDelegate   , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hubsViaCity?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "HubsViaCityCell", for: indexPath) as! HubsViaCityCell
        cell.hubsViaCity = self.hubsViaCity?[indexPath.row] ?? HubsViaCity()
        cell.selectionStyle = .none
        cell.hasCome = self.hasCome
        cell.country = self.country
        cell.awakeFromNib()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

