//
//  BusinessButtonTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit
import DropDown

class BusinessButtonTableCell: UITableViewCell {

  //MARK: - IBOutlet -
  
  @IBOutlet weak var btnBusiness: UIButtonExtended!
    let dataDropDown = DropDown()
    var passIdCallBack:((Int) -> Void)? = nil
    var stateModel: [StateModel]?
    var stateName = [String]()
  override func awakeFromNib() {
    super.awakeFromNib()
    self.btnBusiness.makeCornerRadius(radius: 6.0)
    
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapBusiness(_ sender: UIButton) {
        
        dataDropDown.show()
        dataDropDown.anchorView = btnBusiness
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnBusiness.setTitle(item, for: .normal)
            passIdCallBack?(self.stateModel?[index].id ?? 0)
        }
        dataDropDown.cellHeight = 50
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
  }
  
  //MARK: - Public Methods -
  
  public func configureData(withBusinessDataModel model: BusinessDataModel, currentIndex: Int) -> Void{
    
    self.btnBusiness.setTitle(model.businessHeading, for: .normal)
    if (currentIndex ==  B2BSearch.Hub.rawValue && model.businessHeading == AppConstants.SelectState){
        self.callStateApi()
    }
    
  }
}
extension BusinessButtonTableCell{
func callStateApi() {
    
    TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetCountryStates, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, erroe, errorType, statusCode) in
        
        let response = dictResponse as? [String:Any]
        if let data = response?["data"] as? [[String:Any]]{
            self.stateModel = data.map({StateModel.init(with: $0)})
            for state in 0..<(self.stateModel?.count ?? 0) {
                self.stateName.append(self.stateModel?[state].name ?? "")
            }
            self.dataDropDown.dataSource = self.stateName
        }
    }
}
}
