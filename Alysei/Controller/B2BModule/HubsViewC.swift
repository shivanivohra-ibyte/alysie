//
//  HubsViewC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 5/25/21.
//

import UIKit

class HubsViewC: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var hubName: UILabel!
    @IBOutlet weak var hubLocation: UILabel!
    
    var arruserCount : [UserRoleCount]?
    var passHubId: String?
    var passHubName: String?
    var passHubLocation: String?
    var getRoleViewModel: GetRoleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hubName.text = passHubName
        hubLocation.text = passHubLocation
        callUserCountApi()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension HubsViewC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "HubCollectionViewCell", for: indexPath) as? HubCollectionViewCell else {return UICollectionViewCell()}
        cell.configData(indexPath.row, arruserCount?[indexPath.row] ?? UserRoleCount(with: [:]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let width = (kScreenWidth - 70.0)/3
      return CGSize(width: width, height: width + 32.0)
    }
}

extension HubsViewC{
    func callUserCountApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetRolesUserCount + "\(passHubId ?? "")", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errtype, statusCode) in
            let response = dictResponse as? [String:Any]
            
            if let data =  response?["data"] as? [[String:Any]]{
                self.arruserCount = data.map({UserRoleCount.init(with: $0)})
            }
            self.detailCollectionView.reloadData()
        }
    }
}

