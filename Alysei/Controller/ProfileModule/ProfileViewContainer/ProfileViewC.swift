//
//  ProfileViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit

class ProfileViewC: AlysieBaseViewC{
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewAddProduct: UICollectionView!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var btnPosts: UIButton!
  @IBOutlet weak var btnAbout: UIButton!
  @IBOutlet weak var btnContact: UIButton!
  @IBOutlet weak var viewSeparator: UIView!
  @IBOutlet weak var tblViewPosts: UITableView!
  @IBOutlet weak var imgViewCover: UIImageView!
  @IBOutlet weak var lblDisplayNameNavigation: UILabel!
//  @IBOutlet weak var lblEmailNavigation: UILabel!
  @IBOutlet weak var imgViewProfileNavigation: UIImageViewExtended!
  @IBOutlet weak var imgViewProfile: UIImageViewExtended!
  @IBOutlet weak var lblDisplayName: UILabel!
//  @IBOutlet weak var lblEmail: UILabel!
  @IBOutlet weak var btnEditProfile: UIButtonExtended!
  
  //MARK: - Properties -
  
    var signUpViewModel: SignUpViewModel!
//    {
//        didSet {
//            print(oldValue)
//            self.updateProductsInEditProfile()
//        }
//    }
  
  //MARK: - Properties -

    private var editProfileViewCon: EditProfileViewC!
  
  private var currentChild: UIViewController {
      return self.children.last!
  }
  
  private lazy var postsViewC: PostsViewC = {

    let postsViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: PostsViewC.id()) as! PostsViewC
    return postsViewC
  }()

  private lazy var aboutViewC: AboutViewC = {

    let aboutViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: AboutViewC.id()) as! AboutViewC
    return aboutViewC
  }()
  
  private lazy var contactViewC: ContactViewC = {

    let contactViewC = UIStoryboard.init(name: StoryBoardConstants.kHome, bundle: nil).instantiateViewController(withIdentifier: ContactViewC.id()) as! ContactViewC
    return contactViewC
  }()
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _ = postsViewC
    self.tblViewPosts.tableHeaderView?.setHeight(600.0 + 861.0)
    //self.tblViewPosts.tableFooterView = UIView()
    self.btnPosts.isSelected = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    self.initialSetUp()
    self.postRequestToGetFields()
  }
  
  override func viewDidLayoutSubviews(){
    
    super.viewDidLayoutSubviews()
    self.viewSeparator.translatesAutoresizingMaskIntoConstraints = false
  }
  
  //MARK: - IBAction -

  @IBAction func tapSideMenu(_ sender: UIButton) {
        
    _ = pushViewController(withName: SettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
  
  @IBAction func tapPosts(_ sender: UIButton) {
    
    self.tblViewPosts.tableHeaderView?.setHeight(600.0 + 861.0)
    self.viewSeparator.center.x = self.btnPosts.center.x
    self.btnPosts.isSelected = true
    self.btnAbout.isSelected = false
    self.btnContact.isSelected = false
    self.btnPosts.setTitleColor(UIColor.black, for: .normal)
    self.btnAbout.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.btnContact.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.moveToNew(childViewController: postsViewC, fromController: self.currentChild)
  }
  
  @IBAction func tapAbout(_ sender: UIButton) {
    
    self.viewSeparator.center.x = self.btnAbout.center.x
    self.btnPosts.isSelected = false
    self.btnAbout.isSelected = true
    self.btnContact.isSelected = false
    self.btnPosts.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.btnAbout.setTitleColor(UIColor.black, for: .normal)
    self.btnContact.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.moveToNew(childViewController: aboutViewC, fromController: self.currentChild)
  }
  
  @IBAction func tapContact(_ sender: UIButton) {
    
    self.viewSeparator.center.x = self.btnContact.center.x
    self.btnPosts.isSelected = false
    self.btnAbout.isSelected = false
    self.btnContact.isSelected = true
    self.btnPosts.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.btnAbout.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.btnContact.setTitleColor(UIColor.black, for: .normal)
    self.moveToNew(childViewController: contactViewC, fromController: self.currentChild)
    self.tblViewPosts.tableHeaderView?.setHeight(kScreenWidth + 200.0)
  }
  
  @IBAction func tapEditProfile(_ sender: UIButton) {
    
    let controller = pushViewController(withName: EditProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? EditProfileViewC
    controller?.signUpViewModel = self.signUpViewModel
    self.editProfileViewCon = controller
//    updateProductsInEditProfile()
  }
  
  //MARK: - Private Methods -

//    func updateProductsInEditProfile() {
//        editProfileViewCon?.tableViewEditProfile?.reloadData()
//    }
  
  private func initialSetUp() -> Void{
    
//    self.lblEmail.text = kSharedUserDefaults.loggedInUserModal.email
//    self.lblEmailNavigation.text = kSharedUserDefaults.loggedInUserModal.email 
    self.lblDisplayName.text = kSharedUserDefaults.loggedInUserModal.displayName?.capitalized
    self.lblDisplayNameNavigation.text = kSharedUserDefaults.loggedInUserModal.displayName

    self.imgViewCover.image = UIImage(named: "coverPhoto")
    self.imgViewProfile.image = UIImage(named: "profile_icon")

    if let coverPhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().coverPhoto) {
        self.imgViewCover.image = coverPhoto
    }

    if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
        self.imgViewProfile.image = profilePhoto
        self.imgViewProfile.layer.cornerRadius = (self.imgViewProfile.frame.width / 2.0)
        self.imgViewProfile.layer.borderWidth = 3.0
        self.imgViewProfile.layer.borderColor = UIColor.white.cgColor
        self.imgViewProfile.layer.masksToBounds = true
    }
    
  }
    
  private func getFeaturedProductCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let featuredProductCollectionCell = collectionViewAddProduct.dequeueReusableCell(withReuseIdentifier: FeaturedProductCollectionCell.identifier(), for: indexPath) as! FeaturedProductCollectionCell
    featuredProductCollectionCell.configure(withAllProductsDataModel: nil,pushedFrom: 1)
    return featuredProductCollectionCell
  }
  
  private func moveToNew(childViewController newVC: UIViewController,fromController oldVC: UIViewController, completion:((() ->Void)? ) = nil){
    
      if  oldVC == newVC {
        completion?()
        return
      }
      DispatchQueue.main.async {
          
          self.view.isUserInteractionEnabled = false
          self.addChild(newVC)
          newVC.view.frame = self.containerView.bounds
          
        oldVC.willMove(toParent: nil)
          
        self.transition(from: oldVC, to: newVC, duration: 0.25, options: UIView.AnimationOptions(rawValue: 0), animations:{
              
          })
          { (_) in
              
              oldVC.removeFromParent()
              newVC.didMove(toParent: self)
              self.view.isUserInteractionEnabled = true
              completion?()
          }
      }
  }
  
  //MARK:  - WebService Methods -

    func reloadFields() {
        self.postRequestToGetFields()
    }

  private func postRequestToGetFields() -> Void{
    
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUserSubmittedFields, method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())
  }
}

//MARK: - CollectionView Methods -

extension ProfileViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 2
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      return self.getFeaturedProductCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 64.0, height: 100.0)
  }
    
}

extension ProfileViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    let dicResult = kSharedInstance.getDictionary(result)
    let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
    self.signUpViewModel = SignUpViewModel(dicData, roleId: nil)
    editProfileViewCon?.signUpViewModel = self.signUpViewModel
    editProfileViewCon?.tableViewEditProfile?.reloadData()
    print("Some")
  }
  
}
