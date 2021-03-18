//
//  HomeViewC.swift
//  Alysie
//
//  Created by CodeAegis on 23/01/21.
//

import UIKit

class HomeViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var containerView: UIView!
  
  //MARK: - Properties -
  
  private lazy var membershipViewC: MembershipViewC = {

    let membershipViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: MembershipViewC.id()) as! MembershipViewC
    return membershipViewC
  }()
  
  //MARK: -  ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()   
    _ = membershipViewC
  }
  
  //MARK:  - IBAction -
  
  @IBAction func tapNotification(_ sender: UIButton) {
    
    _ = pushViewController(withName: NotificationViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
}

extension HomeViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    
    
    
  }
}
