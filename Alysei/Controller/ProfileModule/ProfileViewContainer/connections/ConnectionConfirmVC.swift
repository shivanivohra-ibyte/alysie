//
//  ConnectionConfirmVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/16/21.
//

import UIKit

class ConnectionConfirmVC: AlysieBaseViewC {

    var userID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnClose(_ sender: UIButton){
            let controller = pushViewController(withName: ProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? ProfileViewC
            controller?.userLevel = .other
            controller?.userID = self.userID
            
        }

}
