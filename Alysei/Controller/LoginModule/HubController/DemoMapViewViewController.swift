//
//  DemoMapViewViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 23/03/21.
//

import UIKit

class DemoMapViewViewController: UIViewController {
   
    @IBOutlet weak var viewHeader: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHeader.drawBottomShadow()
        // Do any additional setup after loading the view.
    }
}
