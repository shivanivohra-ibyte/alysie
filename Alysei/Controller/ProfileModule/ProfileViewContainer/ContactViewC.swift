//
//  ContactViewC.swift
//  Alysie
//
//  Created by CodeAegis on 22/01/21.
//

import UIKit

class ContactViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var tblViewContactUs: UITableView!
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
     
    super.viewDidLoad()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapEdit(_ sender: UIButton) {
    
    
    
  }
  
  //MARK: - Private Methods -
    
  private func getContactTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let contactTableCell = tblViewContactUs.dequeueReusableCell(withIdentifier: ContactTableCell.identifier(), for: indexPath) as! ContactTableCell
    //contactTableCell.configure(indexPath)
    return contactTableCell
  }
}

//MARK: - TableView Methods -

extension ContactViewC: UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     return self.getContactTableCell(indexPath)
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
}
