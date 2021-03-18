//
//  UpdatePasswordViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class UpdatePasswordViewC: AlysieBaseViewC {
  
  //MARK: - IBOutlet -
  
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
  
}
