//
//  UserModel.swift
//  Alysie
//
//  Created by CodeAegis on 12/01/21.
//

import Foundation

class UserModel: NSObject{
  
  var accessToken :String?
  var userId : String?
  var memberName : String?
  var memberRoleId : String?
  var email : String?
  var locale : String?
  var website: String?
  var userName: String?
  var firstName : String?
  var displayName : String?
  var address : String?
  //var avatarId : String?
  var accountEnabled : String?
  var logout : Bool = false
  
  var latitude : Double = 0.0
  var longitude : Double = 0.0
  var avatarId: String?
 // var cover_id: AllProductsDataModel?
    
  init(withDictionary dicResult: [String:Any]){
    
    super.init()
    
    self.logout = Bool.getBool(dicResult["logout"])
    
    self.latitude = Double.getDouble(dicResult[APIConstants.kLatitude])
    self.longitude = Double.getDouble(dicResult[APIConstants.kLongitude])
    
    
    let dictData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
    let dictRoles = kSharedInstance.getDictionary(dictData[APIConstants.kRoles])
    
    self.accessToken = String.getString(dicResult[APIConstants.kToken])
    self.userId = String.getString(dictData[APIConstants.kUserId])
    self.displayName = String.getString(dictData[APIConstants.kDisplayName])
    self.email = String.getString(dictData[APIConstants.kEmail])
    self.locale = String.getString(dictData[APIConstants.kLocale])
    self.website = String.getString(dictData[APIConstants.kWebsite])
    self.userName = String.getString(dictData[APIConstants.kUsername])
    self.firstName = String.getString(dictData[APIConstants.kFirstName])
    self.accountEnabled = String.getString(dictData[APIConstants.kAccountEnabled])
    self.memberName = String.getString(dictRoles[APIConstants.kName])
    self.memberRoleId = String.getString(dictRoles[APIConstants.kRoleId])
    self.avatarId = String.getString(dictRoles[APIConstants.kAvatarId])

  }
}

//class UserImage: {
//
//}
