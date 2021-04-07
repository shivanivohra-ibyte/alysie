//
//  ContactViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit

protocol ContactViewEditProtocol {
    func editContactDetail()
}

class ContactViewC: AlysieBaseViewC {

    var delegate: ContactViewEditProtocol!
    var tableData = [ContactDetail.view.tableCellModel]()
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var tblViewContactUs: UITableView!
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
     
    super.viewDidLoad()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapEdit(_ sender: UIButton) {

    self.delegate?.editContactDetail()
    
  }
  
  //MARK: - Private Methods -
    
  private func getContactTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    guard let contactTableCell = tblViewContactUs.dequeueReusableCell(withIdentifier: ContactTableCell.identifier(), for: indexPath) as? ContactTableCell else {
        return UITableViewCell()
    }
    contactTableCell.updateDisplay(tableData[indexPath.row])
    return contactTableCell
  }
}

//MARK: - TableView Methods -

extension ContactViewC: UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tableData.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     return self.getContactTableCell(indexPath)
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
}
