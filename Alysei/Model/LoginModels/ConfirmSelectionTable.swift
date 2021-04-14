//
//  ConfirmSelectionTable.swift
//  Alysie
//
//

import Foundation
import UIKit

class ConfirmSelectionTable: UITableView {
  
    var selectedHubs = [SelectdHubs](){didSet{self.awakeFromNib()}}
    var reviewSelectedHubs : ReviewHubModel.reviewHubModel?
    var dataDelegate:SelectList?
    var isEditHub: Bool?
    
     var roleId: String?
    //var hub:SelectdHubs?
    // MARK:- life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegate()
    }
    func setDelegate() {
        self.register(UINib(nibName: "ShowHubSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "ShowHubSelectionTableViewCell")
       // cell.isEdithub = self.isEditHub
        self.delegate = self
        self.dataSource = self
        
    }
    
}
// MARK:- cextension of main class for CollectionView
extension ConfirmSelectionTable : UITableViewDelegate   , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEditHub == true{
            return reviewSelectedHubs?.data?.hubs?.count ?? 0
        }else{
        return selectedHubs.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowHubSelectionTableViewCell", for: indexPath) as! ShowHubSelectionTableViewCell
        cell.selectionStyle = .none
        cell.isEditHub = isEditHub
       cell.roleId = self.roleId
        var hub: SelectdHubs?
        if isEditHub == true {
            cell.reviewSelectedHub = self.reviewSelectedHubs
            //hub = self.reviewSelectedHubs?.data?.hubs?[0]
        }else{
         hub = selectedHubs[indexPath.row]
            hub?.hubs = hub?.hubs.uniqueArray(map: {$0.id}) ?? []
        cell.selectedHub = hub
        }
        cell.addRemoveCallback = { tag in
            if tag == 0 {
                
                //MARK:show Alert Message
                let refreshAlert = UIAlertController(title: "", message: "All hub data will be lost.", preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                      // Handle Ok logic here
                    let parent = self.parentViewController as? ConfirmSelectionVC
                    parent?.selectedHubs.remove(at: indexPath.row)
                    self.selectedHubs.remove(at: indexPath.row)
                    self.reloadData()
                }))
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                      print("Handle Cancel Logic here")
                    self.parentViewController?.parent?.dismiss(animated: true, completion: nil)
                }))
                //let parent = self.parentViewController?.presentedViewController as? HubsListVC
                self.parentViewController?.parent?.present(refreshAlert, animated: true, completion: nil)

//                self.selectedHubs.remove(at: indexPath.row)
//                self.reloadData()
            }
            if tag == 1 {
                self.dataDelegate?.didSelectList(data: hub, index: indexPath)
        }
            
        }
        //tableView.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

