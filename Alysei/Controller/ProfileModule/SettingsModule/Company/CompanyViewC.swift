//
//  CompanyViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 19/01/21.
//

import UIKit

class CompanyViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var tblViewCompany: UITableView!
  @IBOutlet weak var viewNavigation: UIView!
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews(){
    super.viewDidLayoutSubviews()
    self.viewNavigation.drawBottomShadow()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapClose(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapSave(_ sender: UIButton) {
    
  }
  
  //MARK: - Private Methods -
  
  private func getCompanyFirstTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let companyFirstTableCell = tblViewCompany.dequeueReusableCell(withIdentifier: CompanyFirstTableCell.identifier(), for: indexPath) as! CompanyFirstTableCell
    return companyFirstTableCell
  }
  
  private func getCompanySecondTableCell(_ indexPath: IndexPath) -> UITableViewCell{
      
    let companySecondTableCell = tblViewCompany.dequeueReusableCell(withIdentifier: CompanySecondTableCell.identifier(), for: indexPath) as! CompanySecondTableCell
    return companySecondTableCell
  }
}

//MARK: - TableView Methods -

extension CompanyViewC: UITableViewDelegate, UITableViewDataSource{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 2
    default:
      return 6
    }
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    case 0:
      return self.getCompanyFirstTableCell(indexPath)
    default:
      return self.getCompanySecondTableCell(indexPath)
    }
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 90.0
   }
}
