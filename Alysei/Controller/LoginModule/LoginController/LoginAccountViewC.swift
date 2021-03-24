//
//  LoginAccountViewC.swift
//  Alysie
//
//  Created by CodeAegis on 13/01/21.
//

import UIKit
import AVFoundation

class LoginAccountViewC: AlysieBaseViewC{
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var btnLogin: UIButton!
  @IBOutlet weak var btnSignUp: UIButton!
  @IBOutlet weak var btnTermsOfUse: UIButton!
  @IBOutlet weak var viewVideo: UIView!
  @IBOutlet weak var viewBottom: UIView!
  
  //MARK: - Properties -
  
  var player: AVPlayer?
  
  //MARK: - ViewLifeCycle Methods -
  
  override func viewDidLoad() {
   super.viewDidLoad()
    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    //logoCenterConstraint.constant -= view.bounds.width
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
//      self.logoCenterConstraint.constant += self.view.bounds.width
//           
//            self.view.layoutIfNeeded()
//        }, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    
    super.viewDidLayoutSubviews()
    self.btnLogin.makeCornerRadius(radius: 5.0)
    self.btnSignUp.makeCornerRadius(radius: 5.0)
    self.btnTermsOfUse.underlined()
    self.playBackgroundVideo()
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapLogin(_ sender: UIButton) {
    
    //_ = pushViewController(withName: LoginViewC.id(), fromStoryboard: StoryBoardConstants.kLogin)
    showLoginView()
  }
  
  @IBAction func tapSignUp(_ sender: UIButton) {
  
    
    self.btnSignUp.isUserInteractionEnabled = false
    self.btnLogin.isUserInteractionEnabled = false
    self.btnTermsOfUse.isUserInteractionEnabled = false
    self.postRequestToGetRoles()
  }
  
  @IBAction func tapTermsOfUse(_ sender: UIButton) {
    
    guard let url = URL(string: "https://social.alysei.com/terms") else {return}
    UIApplication.shared.open(url)
  }
  
  //MARK:  - Private Methods -
  
  func playBackgroundVideo(){
    
    guard let path = Bundle.main.path(forResource: "AlyseiBVC", ofType: "mp4") else{return}
           player = AVPlayer(url: URL(fileURLWithPath: path))
    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = self.view.bounds
    playerLayer.videoGravity = .resizeAspectFill
    self.viewVideo.layer.addSublayer(playerLayer)
    player?.isMuted = true
    player?.play()
  }
    
    @objc func showLoginView() {
        let slideVC = OverLayLoginViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.btnCallback =  { tag, getRoleViewModel,userEmail, firstName in
            switch tag {
            case 1:
                let controller = self.pushViewController(withName: OTPVerificationViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? OTPVerificationViewC
                controller?.email = String.getString(userEmail)
                controller?.userName = String.getString(firstName)
                controller?.pushedFrom = .login
            case 2:
                let slideVC = OverLayForgetVC()
                slideVC.modalPresentationStyle = .custom
                slideVC.transitioningDelegate = self
                slideVC.btnCallBack = { email in
                    let controller = self.pushViewController(withName: OTPVerificationViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? OTPVerificationViewC
                    controller?.email = String.getString(email)
                    controller?.pushedFrom = .forgotPassword
                }
                self.present(slideVC, animated: true, completion: nil)
            case 3:
               // let controller = self.pushViewController(withName: RoleViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? RoleViewC
                //controller?.getRoleViewModel = getRoleViewModel
                let controller = self.pushViewController(withName: SelectRoleViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectRoleViewC
                 controller?.getRoleViewModel = getRoleViewModel
            default:
                print("Handle")
            }
            
        }
        self.present(slideVC, animated: true, completion: nil)
    }
  //MARK:  - WebService Methods -
  
  private func postRequestToGetRoles() -> Void{
    
    defer {
      self.btnLogin.isUserInteractionEnabled = true
      self.btnTermsOfUse.isUserInteractionEnabled = true
    }
    CommonUtil.sharedInstance.postRequestToServer(url: APIUrl.kGetRoles, method: .GET, controller: self, type: 0, param: [:],btnTapped: self.btnSignUp)
  }
}

extension LoginAccountViewC{
  
  override func didUserGetData(from result: Any, type: Int) {
    
    //let controller = pushViewController(withName: RoleViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? RoleViewC
    let controller = pushViewController(withName: SelectRoleViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? SelectRoleViewC
    let dicResponse = kSharedInstance.getDictionary(result)
    let dicData = kSharedInstance.getDictionary(dicResponse[APIConstants.kData])
    controller?.getRoleViewModel = GetRoleViewModel(dicData)
    
  }
}

extension LoginAccountViewC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
