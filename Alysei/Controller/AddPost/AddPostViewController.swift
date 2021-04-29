//
//  AddPostViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 12/04/21.
//

import UIKit

class AddPostViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var btnPostPrivacy: UIButton!
    @IBOutlet weak var txtPost: UITextView!
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var viewHeaderShadow: UIView!
    @IBOutlet weak var collectionViewImage: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postPrivacyTableView: UITableView!
    @IBOutlet weak var imgPrivacy: UIImageView!
    var privacyArray = ["Public","Followers","Just Me"]
    var privacyImageArray = ["Public","Friends","OnlyMe"]
    
    
    var picker = UIImagePickerController()
    var uploadImageArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        self.viewHeaderShadow.addShadow()
        // Do any additional setup after loading the view.
    }
    func setUI(){
        btnCamera.layer.borderWidth = 0.5
        btnCamera.layer.borderColor = UIColor.lightGray.cgColor
        btnGallery.layer.borderWidth = 0.5
        btnGallery.layer.borderColor = UIColor.lightGray.cgColor
        collectionViewHeight.constant = 0
        collectionViewImage.isHidden = true
        postPrivacyTableView.isHidden = true
        txtPost.delegate = self
        txtPost.text = "Enter your text here......"
        txtPost.layer.borderWidth = 0.5
        txtPost.layer.borderColor = UIColor.lightGray.cgColor
        txtPost.textColor = UIColor.lightGray
        let roleID = UserRoles(rawValue:Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)  ) ?? .voyagers
        var name = ""
        switch roleID {
        case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
            name = "\(kSharedUserDefaults.loggedInUserModal.companyName ?? "")"
    //                case .voiceExperts, .voyagers:
        case .restaurant :
            name = "\(kSharedUserDefaults.loggedInUserModal.restaurantName ?? "")"
        default:
            name = "\(kSharedUserDefaults.loggedInUserModal.firstName ?? "") \(kSharedUserDefaults.loggedInUserModal.lastName ?? "")"
        }
        userName.text = name
        if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
            self.userImage.image = profilePhoto
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.masksToBounds = true
            switch roleID {
            case .distributer1, .distributer2, .distributer3:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.distributer1.rawValue).cgColor
            case .producer:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.producer.rawValue).cgColor
            case .travelAgencies:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.travelAgencies.rawValue).cgColor
            case .voiceExperts:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voiceExperts.rawValue).cgColor
            case .voyagers:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voyagers.rawValue).cgColor
            case .restaurant :
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.restaurant.rawValue).cgColor
            default:
                self.userImage.layer.borderColor = UIColor.white.cgColor
            }
        }else{
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBAction func btnCamera(_ sender: UIButton){
        self.showImagePicker(withSourceType: .camera, mediaType: .image)

    }
    @IBAction func btnGallery(_ sender: UIButton){
        self.showImagePicker(withSourceType: .photoLibrary, mediaType: .image)
    }
    @IBAction func postAction(_ sender: UIButton){
        addPostApi()
        
        
       // showAlert(withMessage: "Post Successfully")
    }
    
    @IBAction func changePrivacyAction(_ sender: UIButton){
        postPrivacyTableView.isHidden = false
    }
    private func showImagePicker(withSourceType type: UIImagePickerController.SourceType,mediaType: MediaType) -> Void {

        if UIImagePickerController.isSourceTypeAvailable(type) {

            self.picker.mediaTypes = mediaType.CameraMediaType
            self.picker.allowsEditing = true
            self.picker.sourceType = type
            self.present(self.picker,animated: true,completion: {
                self.picker.delegate = self
            })
            self.picker.delegate = self }
        else{
            self.showAlert(withMessage: "This feature is not available.")
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your text here......"
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: - ImagePickerViewDelegate Methods -

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        self.dismiss(animated: true) {
            self.uploadImageArray.append(selectedImage)
            self.collectionViewHeight.constant = 200
            self.collectionViewImage.isHidden = false
            self.collectionViewImage.reloadData()
            //print("UploadImage------------------------------------\(self.uploadImageArray)")
        }
        
    }
}

//MARK: UICollectionViewDataSource,UICollectionViewDelegate

extension AddPostViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uploadImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}
       cell.image.image = uploadImageArray[indexPath.row]
        cell.btnDelete.tag = indexPath.row
        cell.btnDeleteCallback = { tag in
            self.uploadImageArray.remove(at: tag)
//            if self.uploadImageArray.count == 0 {
//                self.collectionViewHeight.constant = 0
//                self.collectionViewImage.isHidden = true
//            }
            self.collectionViewImage.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: 200)
    }
}
//MARK: UITableView
extension AddPostViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postPrivacyTableView.dequeueReusableCell(withIdentifier: "PostPrivacyTableViewCell", for: indexPath) as? PostPrivacyTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.labelPrivacy.text = privacyArray[indexPath.row]
        cell.imgPrivacy.image = UIImage(named: privacyImageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postPrivacyTableView.isHidden = true
        btnPostPrivacy.setTitle(privacyArray[indexPath.row], for: .normal)
        imgPrivacy.image = UIImage(named: privacyImageArray[indexPath.row])
    }
}
extension AddPostViewController {
    func addPostApi(){
        let params: [String:Any] = [
            "action_type": "post",
            "body": txtPost.text ?? "",
            "privacy": btnPostPrivacy.title(for: .normal)
            
        ]
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray as Any,
        APIConstants.kImageName: "attachments"
]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: APIUrl.kPost, requestMethod: .post, requestImages: [imageParam], requestVideos: [:], requestData: params) { (dictResponse, error, errorType, statusCode) in
            //self.showAlert(withMessage: "Data Uploaded Successfully")
            self.showAlert(withMessage: "Post Successfully")
            self.txtPost.text = ""
            self.collectionViewImage.isHidden = true
            self.collectionViewHeight.constant = 0
            self.uploadImageArray = [UIImage]()
            self.btnPostPrivacy.setTitle("Public", for: .normal)
            self.imgPrivacy.image = UIImage(named: "Public")
        }
    }
}
class ImageCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    var btnDeleteCallback:((Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag)
    }
}

class PostPrivacyTableViewCell: UITableViewCell{
    @IBOutlet weak var labelPrivacy: UILabel!
    @IBOutlet weak var imgPrivacy: UIImageView!
}


