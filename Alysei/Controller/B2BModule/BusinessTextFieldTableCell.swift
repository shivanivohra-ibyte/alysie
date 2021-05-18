//
//  BusinessTextFieldTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 24/01/21.
//

import UIKit

class BusinessTextFieldTableCell: UITableViewCell, UITextFieldDelegate {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var txtFieldBusiness: UITextFieldExtended!
  
  override func awakeFromNib() {
      
    super.awakeFromNib()
    txtFieldBusiness.delegate = self
    self.txtFieldBusiness.makeCornerRadius(radius: 6.0)
    self.txtFieldBusiness.attributedPlaceholder = NSAttributedString(string: "Keyword Search",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: AppColors.liteGray.color])
  }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //if let text = textField.text as NSString? {
         //   let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
        self.callKeyWordSearchApi()
        return true
    }

}

extension BusinessTextFieldTableCell {
    func callKeyWordSearchApi(){
        
        guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.B2BModule.kKeywordSearch)" + "\(txtFieldBusiness.text ?? "")" , method: .POST) else { return }
        print("URl Request -------\(urlRequest)")
        WebServices.shared.request(urlRequest) { (data, response, statusCode, errorType) in
            if statusCode == 200 {
                guard let data = data else { return }
                do {
                    let responseModel = try JSONDecoder().decode(UserProfile.profileTopSectionModel.self, from: data)
                    print("Searching Start....................")
                    print(responseModel)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
