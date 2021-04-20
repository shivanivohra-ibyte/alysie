//
//  ProfileViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 18/01/21.
//

import UIKit
import SVProgressHUD


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
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
//  @IBOutlet weak var lblEmail: UILabel!
  @IBOutlet weak var btnEditProfile: UIButtonExtended!
    @IBOutlet weak var viewProfileCompletion: UIView!
    @IBOutlet weak var viewProfileHeight: NSLayoutConstraint!
    @IBOutlet weak var profilePercentage: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblHintText: UILabel!
    var percentage: String?
    
  //MARK: - Properties -

    var contactDetail = [ContactDetail.view.tableCellModel]()
    var contactDetilViewModel: ContactDetail.Contact.Response!
    var signUpViewModel: SignUpViewModel!
    var userType: UserRoles!
    var aboutViewModel: AboutView.viewModel!
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
    self.tblViewPosts.tableHeaderView?.setHeight(600.0 + 261.0)
    //self.tblViewPosts.tableFooterView = UIView()
    self.btnPosts.isSelected = true
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    self.viewProfileCompletion.addGestureRecognizer(tap)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    self.viewProfileCompletion.isHidden = true
    self.viewProfileHeight.constant = 0
    self.postRequestToGetFields()
    self.fetchProfileDetails()
    self.fetchContactDetail()

  }
  
  override func viewDidLayoutSubviews(){
    
    super.viewDidLayoutSubviews()
    self.viewSeparator.translatesAutoresizingMaskIntoConstraints = false
  }
  
  //MARK: - IBAction -

  @IBAction func tapSideMenu(_ sender: UIButton) {
        
   // _ = pushViewController(withName: SettingsViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
    _ = pushViewController(withName: SettingsScreenVC.id(), fromStoryboard: StoryBoardConstants.kHome)
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

    self.tblViewPosts.tableHeaderView?.setHeight(self.view.frame.height * 1.5)

    self.viewSeparator.center.x = self.btnAbout.center.x
    self.btnPosts.isSelected = false
    self.btnAbout.isSelected = true
    self.btnContact.isSelected = false
    self.btnPosts.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.btnAbout.setTitleColor(UIColor.black, for: .normal)
    self.btnContact.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.moveToNew(childViewController: aboutViewC, fromController: self.currentChild)

    self.aboutViewC.viewModel = self.aboutViewModel
  }
  
  @IBAction func tapContact(_ sender: UIButton) {

    self.tblViewPosts.tableHeaderView?.setHeight(self.view.frame.height * 1.5)

    self.viewSeparator.center.x = self.btnContact.center.x
    self.btnPosts.isSelected = false
    self.btnAbout.isSelected = false
    self.btnContact.isSelected = true
    self.btnPosts.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.btnAbout.setTitleColor(AppColors.liteGray.color, for: .normal)
    self.btnContact.setTitleColor(UIColor.black, for: .normal)
    self.moveToNew(childViewController: contactViewC, fromController: self.currentChild)
    self.contactViewC.delegate = self
    self.contactViewC.tableData = self.contactDetail
    self.tblViewPosts.tableHeaderView?.setHeight(kScreenWidth + 200.0)
  }
  
  @IBAction func tapEditProfile(_ sender: UIButton) {
    
    let controller = pushViewController(withName: EditProfileViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? EditProfileViewC
    controller?.signUpViewModel = self.signUpViewModel
    controller?.userType = self.userType ?? .voyagers
    self.editProfileViewCon = controller
//    updateProductsInEditProfile()
  }

    @IBAction func addFeaturedProductButtonTapped(_ sender: UIButton) {

        let productCategoriesDataModel = self.signUpViewModel?.arrProductCategories.first

        let controller = pushViewController(withName: AddFeatureViewC.id(), fromStoryboard: StoryBoardConstants.kHome) as? AddFeatureViewC
        controller?.productCategoriesDataModel = productCategoriesDataModel
        controller?.delegate = self

    }
  
  //MARK: - Private Methods -

//    func updateProductsInEditProfile() {
//        editProfileViewCon?.tableViewEditProfile?.reloadData()
//    }
  
  private func initialSetUp() -> Void{
    
//    self.lblEmail.text = kSharedUserDefaults.loggedInUserModal.email
//    self.lblEmailNavigation.text = kSharedUserDefaults.loggedInUserModal.email

//    self.lblDisplayName.text = kSharedUserDefaults.loggedInUserModal.displayName?.capitalized
//    self.lblDisplayNameNavigation.text = kSharedUserDefaults.loggedInUserModal.displayName

    self.imgViewCover.image = UIImage(named: "coverPhoto")
    self.imgViewProfile.image = UIImage(named: "profile_icon")

    if let coverPhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().coverPhoto) {
        self.imgViewCover.image = coverPhoto
    }

    if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
        self.imgViewProfile.image = profilePhoto
        self.imgViewProfileNavigation.image = profilePhoto
        self.imgViewProfile.layer.cornerRadius = (self.imgViewProfile.frame.width / 2.0)
        self.imgViewProfile.layer.borderWidth = 5.0
        
        switch self.userType {
        case .distributer1, .distributer2, .distributer3:
            self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.distributer1.rawValue).cgColor
        case .producer:
            self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.producer.rawValue).cgColor
        case .travelAgencies:
            self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.travelAgencies.rawValue).cgColor
        case .voiceExperts:
            self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voiceExperts.rawValue).cgColor
        case .voyagers:
            self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voyagers.rawValue).cgColor
        case .restaurant :
            self.imgViewProfile.layer.borderColor = UIColor.init(hexString: RolesBorderColor.restaurant.rawValue).cgColor
        default:
            self.imgViewProfile.layer.borderColor = UIColor.white.cgColor
        }
       
        self.imgViewProfile.layer.masksToBounds = true
    }else{
        self.imgViewProfile.layer.cornerRadius = (self.imgViewProfile.frame.width / 2.0)
        self.imgViewProfile.layer.borderWidth = 5.0
        self.imgViewProfile.layer.borderColor = UIColor.white.cgColor
    }
    
  }
    
  private func getFeaturedProductCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{

//    guard let some = self.signUpViewModel.arrProductCategories.first else {
//        return UICollectionViewCell()
//    }

    let productCategoryDataModel = self.signUpViewModel?.arrProductCategories.first
    let product = productCategoryDataModel?.arrAllProducts[indexPath.row]

//    self.productCategoriesDataModel.arrAllProducts[indexPath.row]

    let featuredProductCollectionCell = collectionViewAddProduct.dequeueReusableCell(withReuseIdentifier: FeaturedProductCollectionCell.identifier(), for: indexPath) as! FeaturedProductCollectionCell
    featuredProductCollectionCell.configure(withAllProductsDataModel: product,pushedFrom: 1)
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

    private func fetchProfileDetails() {
        SVProgressHUD.show()
        guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.Profile.memberProfile)", method: .GET) else { return }
        WebServices.shared.request(urlRequest) { (data, response, statusCode, error)  in
            SVProgressHUD.dismiss()
            guard let data = data else { return }
            do {
                let responseModel = try JSONDecoder().decode(UserProfile.profileTopSectionModel.self, from: data)
                print(responseModel)

                self.fetchAboutDetail()


                if let username = responseModel.data?.userData?.username {
                    self.usernameLabel.text = "@\(username)".lowercased()
                }
                self.aboutLabel.text = "\(responseModel.data?.about ?? "")"

                let roleID = UserRoles(rawValue: responseModel.data?.userData?.roleID ?? 0) ?? .voyagers
                self.userType = roleID
                self.editProfileViewCon?.userType = self.userType
                var name = ""
                switch roleID {
                case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
                    name = "\(responseModel.data?.userData?.companyName ?? "")"
//                case .voiceExperts, .voyagers:
                case .restaurant :
                    name = "\(responseModel.data?.userData?.restaurantName ?? "")"
                default:
                    name = "\(responseModel.data?.userData?.firstName ?? "") \(responseModel.data?.userData?.lastName ?? "")"
                }
                
                self.lblDisplayName.text = "\(name)".capitalized
                self.lblUserName.text = "\(name)".capitalized
                self.lblDisplayNameNavigation.text = "\(name)".capitalized
                if responseModel.data?.userData?.profilePercentage == ProfilePercentage.percent100.rawValue {
                    self.viewProfileCompletion.isHidden = true
                    self.viewProfileHeight.constant = 0
                }else{
                    self.viewProfileCompletion.isHidden = false
                    self.viewProfileHeight.constant = 75
                    self.profilePercentage.text = "It's at \(responseModel.data?.userData?.profilePercentage ?? 0)%"
                    self.percentage = "\(responseModel.data?.userData?.profilePercentage ?? 0)"
                }
                kSharedUserDefaults.loggedInUserModal.firstName = responseModel.data?.userData?.firstName
                kSharedUserDefaults.loggedInUserModal.lastName = responseModel.data?.userData?.lastName
                kSharedUserDefaults.synchronize()
                self.initialSetUp()
                

            } catch {
                print(error.localizedDescription)
            }
            if (error != nil) { print(error.debugDescription) }
        }
    }


    func fetchContactDetail() {
        SVProgressHUD.show()
        guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.Profile.fetchContactDetails)", method: .GET) else { return }
        WebServices.shared.request(urlRequest) { (data, response, statusCode, error)  in
            SVProgressHUD.dismiss()
            guard let data = data else { return }
            do {
                let responseModel = try JSONDecoder().decode(ContactDetail.Contact.Response.self, from: data)
                print(responseModel)
                self.contactDetilViewModel = responseModel
                self.contactDetail.removeAll()
                self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_email",
                                                                       title: "Email", value: responseModel.data.email))
                if let phone = responseModel.data.phone {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_call",
                                                                           title: "Phone", value: phone))
                }
                if let address = responseModel.data.address {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_pin",
                                                                           title: "Address", value: address))
                }
                if let website = responseModel.data.website {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_world-wide-web",
                                                                           title: "Website", value: website))
                }
                if let facebook = responseModel.data.fb_link {
                    self.contactDetail.append(ContactDetail.view.tableCellModel(imageName: "contact_facebook",
                                                                           title: "Facebook", value: facebook))
                }
                print(self.contactDetail.count)
            } catch {
                print(error.localizedDescription)
            }
            if (error != nil) { print(error.debugDescription) }
        }
    }


    private func convertDataToAboutModel(_ data: Data) {
        self.editProfileViewCon?.userType = self.userType

        do {
            switch self.userType {
            case .producer, .distributer1, .distributer2, .distributer3:
                let modelType = AboutView.Response<AboutView.producerDataModel>.self
                let responseModel = try JSONDecoder().decode(modelType, from: data)
                let intermediatorModel = AboutView.intermediatorModel(responseModel, userRole: self.userType)
                print(intermediatorModel)
                self.aboutViewModel = AboutView.viewModel(userRole: self.userType,
                                                          detail: intermediatorModel.detail,
                                                          staticDetail: intermediatorModel.staticDetail,
                                                          subDetail: intermediatorModel.subDetail,
                                                          staticSubdetail: intermediatorModel.staticSubdetail,
                                                          rows: intermediatorModel.rows,
                                                          listTitle: intermediatorModel.listTitle)
            case .voiceExperts:
                let modelType = AboutView.Response<AboutView.voiceExpertDataModel>.self
                let responseModel = try JSONDecoder().decode(modelType, from: data)
                let intermediatorModel = AboutView.intermediatorModel(responseModel, userRole: self.userType)
                print(intermediatorModel)
                self.aboutViewModel = AboutView.viewModel(userRole: self.userType,
                                                          detail: intermediatorModel.detail,
                                                          staticDetail: intermediatorModel.staticDetail,
                                                          subDetail: intermediatorModel.subDetail,
                                                          staticSubdetail: intermediatorModel.staticSubdetail,
                                                          rows: intermediatorModel.rows,
                                                          listTitle: intermediatorModel.listTitle)
            case .travelAgencies:
                let modelType = AboutView.Response<AboutView.travelAgencyDataModel>.self
                let responseModel = try JSONDecoder().decode(modelType, from: data)
                let intermediatorModel = AboutView.intermediatorModel(responseModel, userRole: self.userType)
                print(intermediatorModel)
                self.aboutViewModel = AboutView.viewModel(userRole: self.userType,
                                                          detail: intermediatorModel.detail,
                                                          staticDetail: intermediatorModel.staticDetail,
                                                          subDetail: intermediatorModel.subDetail,
                                                          staticSubdetail: intermediatorModel.staticSubdetail,
                                                          rows: intermediatorModel.rows,
                                                          listTitle: intermediatorModel.listTitle)
            case .restaurant:
                let modelType = AboutView.Response<AboutView.restaurantDataModel>.self
                let responseModel = try JSONDecoder().decode(modelType, from: data)
                let intermediatorModel = AboutView.intermediatorModel(responseModel, userRole: self.userType)
                print(intermediatorModel)
                self.aboutViewModel = AboutView.viewModel(userRole: self.userType,
                                                          detail: intermediatorModel.detail,
                                                          staticDetail: intermediatorModel.staticDetail,
                                                          subDetail: intermediatorModel.subDetail,
                                                          staticSubdetail: intermediatorModel.staticSubdetail,
                                                          rows: intermediatorModel.rows)
            default:
                print("some")
            }



        } catch {
            print(error.localizedDescription)
        }

    }

    func fetchAboutDetail() {
        SVProgressHUD.show()
        guard let urlRequest = WebServices.shared.buildURLRequest("\(APIUrl.Profile.fetchAboutDetails)", method: .GET) else { return }
        WebServices.shared.request(urlRequest) { (data, response, statusCode, error)  in
            SVProgressHUD.dismiss()
            guard let data = data else { return }
            self.convertDataToAboutModel(data)
            if (error != nil) {
                print(error.debugDescription)
            }
        }
    }
    

  private func postRequestToGetFields() -> Void{
    
    disableWindowInteraction()
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kUserSubmittedFields, method: .GET, controller: self, type: 0, param: [:], btnTapped: UIButton())
  }
    //MARK:- HandleViewTap
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
           // let controller  =  pushViewController(withName: ProfileCompletionViewController.id(), fromStoryboard: StoryBoardConstants.kHome)
        guard let controller = self.storyboard?.instantiateViewController(identifier: "ProfileCompletionViewController") as? ProfileCompletionViewController else {return}
        controller.percentage = percentage
        controller.signUpViewModel = self.signUpViewModel
        controller.userType = self.userType ?? .voyagers
        //self.editProfileViewCon = controller
        self.navigationController?.pushViewController(controller, animated: true)
        
        

    }
}

//MARK: - CollectionView Methods -

extension ProfileViewC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    let productCategoryDataModel = self.signUpViewModel?.arrProductCategories.first
//    let product = productCategoryDataModel?.arrAllProducts.count
    return productCategoryDataModel?.arrAllProducts.count ?? 0
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueProfileTabToContactDetail" {
            if let viewCon = segue.destination as? ContactDetailViewController {
                viewCon.userType = self.userType
                viewCon.viewModel = ContactDetail.Contact.ViewModel(response: self.contactDetilViewModel)
            }
        }
    }
  
  override func didUserGetData(from result: Any, type: Int) {
    
    let dicResult = kSharedInstance.getDictionary(result)
    let dicData = kSharedInstance.getDictionary(dicResult[APIConstants.kData])
    self.signUpViewModel = SignUpViewModel(dicData, roleId: nil)
    editProfileViewCon?.signUpViewModel = self.signUpViewModel
//    let indexPath = IndexPath(row: 0, section: self.signUpViewModel.arrProductCategories.count - 1)
    editProfileViewCon?.userType = self.userType ?? .voyagers
    editProfileViewCon?.tableViewEditProfile?.reloadData()

    self.collectionViewAddProduct.reloadData()
    print("Some")
  }
  
}

extension ProfileViewC: ContactViewEditProtocol {
    func editContactDetail() {
        self.performSegue(withIdentifier: "segueProfileTabToContactDetail", sender: self)
    }
}

extension ProfileViewC: AddFeaturedProductCallBack {
    func productAdded() {

    }


}
