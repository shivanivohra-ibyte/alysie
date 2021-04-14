//
//  ProfileCompletionViewController.swift
//  Alysei
//
//  Created by SHALINI YADAV on 4/14/21.
//

import UIKit

class ProfileCompletionViewController: AlysieBaseViewC {

        
      //MARK: - IBOutlet -
        
      @IBOutlet weak var tblViewProfileCompletion: UITableView!
      //MARK: - Properties -
      
      var currentIndex: Int = 0

      //MARK:  - ViewLifeCycle Methods -
        
      override func viewDidLoad() {
        
        super.viewDidLoad()
        self.postRequestToGetProgress()
      }
      
      override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        
      }

      //MARK:  - IBAction -
      
      @IBAction func tapBack(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)
      }
      
      //MARK:  - Private Methods -
      
      private func getProfileCompletionTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let profileTableCell = tblViewProfileCompletion.dequeueReusableCell(withIdentifier: ProfileCompletionTableViewCell.identifier()) as! ProfileCompletionTableViewCell
        profileTableCell.delegate = self
        profileTableCell.configure(indexPath, currentIndex: self.currentIndex)
        return profileTableCell
      }
      
      //MARK:  - WebService Methods -
      
      private func postRequestToGetProgress() -> Void{
        
        disableWindowInteraction()
        CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetProgress, method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())
      }
    }

    //MARK:  - TableViewMethods -

    extension ProfileCompletionViewController: UITableViewDataSource, UITableViewDelegate{
        
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StaticArrayData.ArrayProducerProfileCompletionDict.count
      }
        
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.getProfileCompletionTableCell(indexPath)
      }
        
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
      }
    }

    extension ProfileCompletionViewController: AnimationProfileCallBack{
      
      func animateViews(_ indexPath: Int, cell: ProfileCompletionTableViewCell) {
      
    //    UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
    //      cell.imgViewCircle.layer.backgroundColor = UIColor.white.cgColor
    //      cell.imgViewCircle.layer.borderWidth = 1.0
    //      cell.imgViewCircle.makeCornerRadius(radius: 15.0)
    //      cell.imgViewCircle.layer.borderColor = AppColors.blue.color.cgColor
    //    })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
          cell.viewLine.layer.backgroundColor = AppColors.blue.color.cgColor
        }
        switch indexPath {
        case 0:
          self.currentIndex = 1
          UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
          cell.imgViewCircle.image = UIImage.init(named: "icon_bubble4")
          })
          self.tblViewProfileCompletion.reloadData()
        case 1:
          self.currentIndex = 2
          UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
          cell.imgViewCircle.image = UIImage.init(named: "icon_bubble4")
          })
          self.tblViewProfileCompletion.reloadData()
        case 2:
          self.currentIndex = 3
          UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
          cell.imgViewCircle.image = UIImage.init(named: "icon_bubble4")
          })
          self.tblViewProfileCompletion.reloadData()
        case 3:
          self.currentIndex = 4
          UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
          cell.imgViewCircle.image = UIImage.init(named: "icon_bubble4")
          })
          self.tblViewProfileCompletion.reloadData()
        case 4:
          self.currentIndex = 5
          UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
          cell.imgViewCircle.image = UIImage.init(named: "icon_bubble4")
          })
          self.tblViewProfileCompletion.reloadData()
        case 5:
            self.currentIndex = -1
          UIView.animate(withDuration: 1.0, delay: 0.0,options: .curveEaseInOut,animations:{
          cell.imgViewCircle.image = UIImage.init(named: "icon_bubble4")
          })
          self.tblViewProfileCompletion.reloadData()
        default:
          print("")
        }
      }
    }

    extension ProfileCompletionViewController{
      
      override func didUserGetData(from result: Any, type: Int) {
        
      }
      
    }


