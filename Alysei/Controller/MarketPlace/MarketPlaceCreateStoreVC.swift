//
//  MarketPlaceCreateStoreVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/3/21.
//

import UIKit
import TLPhotoPicker
import Photos
import DropDown
import YPImagePicker

class MarketPlaceCreateStoreVC: AlysieBaseViewC ,TLPhotosPickerViewControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnCoverCameraImage: UIView!
    @IBOutlet weak var btnProfileCameraImage: UIView!
    @IBOutlet weak var collectionViewImage: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txtStoreName: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtWebsite: UITextField!
    @IBOutlet weak var txtStoreRegion: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtProducerMobileNumber: UITextField!
    @IBOutlet weak var txtProducerEmail: UITextField!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var btnInfoIcon: UIButton!
    
    
    
    var uploadImageArray = [UIImage]()
   // var selectedAssets = [TLPHAsset]()
    var ypImages = [YPMediaItem]()
    var imagesFromSource = [UIImage]()
    var picker = UIImagePickerController()
    var uploadProfilePic = false
    var latitude: Double?
    var longitude:Double?
    var storeImageParams = [[String:Any]]()
    var stateModel: [StateModel]?
    var arrStateName = [String]()
    var dataDropDown = DropDown()
    var marketPlaceId: Int?
    var userEmail: String?
    var userMobileNumber: String?
    var userWebsite: String?
    var userStoreName: String?
    var userAbout: String?
    var userLocation: String?
    var userRegion: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callGetFieldStoreApi()
        setDataUI()
       // picker.
//        let tap = UITapGestureRecognizer(target: self, action: #selector(gotomapView))
//        self.view8.addGestureRecognizer(tap)
//
//
//        let regionTap = UITapGestureRecognizer(target: self, action: #selector(openRegionDropDown))
//        self.view7.addGestureRecognizer(regionTap)
        // Do any additional setup after loading the view.
    }
    
    func setDataUI(){
        self.txtProducerEmail.text =  self.userEmail
        self.txtStoreName.text = self.userStoreName
        self.txtWebsite.text = self.userWebsite
        self.txtProducerMobileNumber.text = self.userMobileNumber
        self.txtLocation.text = self.userLocation
        self.txtDescription.text = self.userAbout
        self.txtStoreRegion.text = self.userRegion
        view1.addBorder()
        view2.addBorder()
        view4.addBorder()
        view5.addBorder()
        view6.addBorder()
        view7.addBorder()
        view8.addBorder()
        imgProfile.layer.cornerRadius = self.imgProfile.frame.height / 2
        btnCoverCameraImage.layer.cornerRadius = self.btnCoverCameraImage.frame.height / 2
        btnProfileCameraImage.layer.cornerRadius = self.btnProfileCameraImage.frame.height / 2
        imgCover.layer.cornerRadius = 15
        headerView.drawBottomShadow()
    }
    private func alertToAddCustomPicker() -> Void {
        //        let viewCon = CustomPhotoPickerViewController()
//        let viewCon = TLPhotosPickerViewController()
//        viewCon.delegate = self
//        viewCon.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
//            self?.showExceededMaximumAlert(vc: picker)
//        }
//        var configure = TLPhotosPickerConfigure()
//        configure.allowedVideoRecording = false
//        
//        configure.mediaType = .image
//        configure.numberOfColumn = 3
//        
//        viewCon.configure = configure
//        viewCon.selectedAssets = self.selectedAssets
//        viewCon.logDelegate = self
//        
//        self.present(viewCon, animated: true, completion: nil)
        
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.maxNumberOfItems = 100000
        config.showsPhotoFilters = false

        config.library.preselectedItems = ypImages
        let picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [unowned picker] items, cancelled in
            self.ypImages = items
            for item in items {
                switch item {
                case .photo(let photo):
                    self.imagesFromSource.append(photo.modifiedImage ?? photo.image)
                    print(photo)
                case .video(let video):
                    print(video)
                }
            }
            self.collectionViewImage.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }

        self.present(picker, animated: true, completion: nil)

    }
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        // use selected order, fullresolution image
        print("dismiss")
//        if withTLPHAssets.count >= 10 {
//            self.showExceededMaximumAlert(vc: picker)
//            return
//        }else{
            //self.selectedAssets = withTLPHAssets
            
            //print("selectedAssest-----------------\(self.selectedAssets)")
            
            self.collectionViewImage.reloadData()
            self.btnScroll()
        //}
        
        
        //iCloud or video
        //        getAsyncCopyTemporaryFile()
    }
    
    func photoPickerDidCancel() {
        // cancel
        print("cancel")
    }
    func showExceededMaximumAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "", message: "Exceed Maximum Number Of Selection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
//    @objc func gotomapView(){
//        let controller = pushViewController(withName: MapViewC.id(), fromStoryboard: StoryBoardConstants.kLogin) as? MapViewC
//        controller?.dismiss = { [weak self] (mapAddressModel , lat ,long) in
//
//            if mapAddressModel.address1 == "" {
//                self?.txtLocation.text = "\(mapAddressModel.address2), \(mapAddressModel.mapAddress)".capitalized
//            }else if mapAddressModel.address2 == ""{
//                self?.txtLocation.text = "\(mapAddressModel.address1), \(mapAddressModel.mapAddress)".capitalized
//            }else{
//            self?.txtLocation.text = "\(mapAddressModel.address1), \(mapAddressModel.address2), \(mapAddressModel.mapAddress)".capitalized
//            }
//            self?.longitude = long
//            self?.latitude = lat
//        }
//    }
//
//    @objc func openRegionDropDown(){
//        self.callStateApi()
//    }
//
//    func opendropDown(){
//        dataDropDown.show()
//        dataDropDown.anchorView = view7
//        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
//        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            self.txtStoreRegion.text = item
//
//        }
//        dataDropDown.cellHeight = 50
//        dataDropDown.backgroundColor = UIColor.white
//        dataDropDown.selectionBackgroundColor = UIColor.clear
//        dataDropDown.direction = .bottom
//    }
    //MARK:- IBAction
    
    @IBAction func btnNextAction(_ sender: UIButton){
        
        if self.validateAllfields(){
            callCreateStoreApi()
        }
        
    //    let controller = self.pushViewController(withName: AddProductMarketplaceVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddProductMarketplaceVC
    }
    
    private func validateAllfields() -> Bool {
        guard self.txtWebsite.text?.isValid(.url) == true else {
            showAlert(withMessage: "Please enter a valid website url.")
            return false
        }
        return true
    }
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUploadProfilePic(_ sender: UIButton){
        uploadProfilePic = true
        alertToAddImage()
    }
    
    @IBAction func btnUploadCoverPic(_ sender: UIButton){
        uploadProfilePic = false
        alertToAddImage()
    }
    
    @IBAction func btnWebsiteInfo(_ sender: UIButton){
        showAlert(withMessage: "Please enter valid website url, For example: www.website.com")
    }
    private func alertToAddImage() -> Void {
        
        let alert:UIAlertController = UIAlertController(title: AlertMessage.kSourceType, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: AlertMessage.kTakePhoto,
                                         style: UIAlertAction.Style.default) { (action) in
            self.showImagePicker(withSourceType: .camera, mediaType: .image)
            
        }
        
        let galleryAction = UIAlertAction(title: AlertMessage.kChooseLibrary,
                                          style: UIAlertAction.Style.default) { (action) in
            self.showImagePicker(withSourceType: .photoLibrary, mediaType: .image)
        }
        
        let cancelAction = UIAlertAction(title: AlertMessage.kCancel,
                                         style: UIAlertAction.Style.cancel) { (action) in
            print("\(AlertMessage.kCancel) tapped")
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
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
}
extension MarketPlaceCreateStoreVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        print(selectedImage.description)
        self.dismiss(animated: true) {
            if self.uploadProfilePic == true{
                self.imgProfile.image = selectedImage
            }else{
                self.imgCover.image = selectedImage
            }
        }
        
    }
}
//MARK:- Custom Picker
extension MarketPlaceCreateStoreVC: TLPhotosPickerLogDelegate {
    //For Log User Interaction
    func selectedCameraCell(picker
                                : TLPhotosPickerViewController) {
        print("selectedCameraCe ll")
    }
    
    func selectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        print("selectedPhoto")
        print(picker.selectedAssets.count)
        
        //self.collectionViewImage.reloadData()
        // let image = picker.selectedAssets[at]
        //  print(image)
    }
    
    func deselectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        picker.isAccessibilityElement = true
        print("deselectedPhoto")
        // self.collectionViewImage.reloadData()
    }
    
    func selectedAlbum(picker: TLPhotosPickerViewController, title: String, at: Int) {
        print("selectedAlbum")
    }
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        self.showExceededMaximumAlert(vc: picker)
    }
    
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        picker.dismiss(animated: true) {
            let alert = UIAlertController(title: "", message: "Denied albums permissions granted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        let alert = UIAlertController(title: "", message: "Denied camera permissions granted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        picker.present(alert, animated: true, completion: nil)
    }
    
    func showUnsatisifiedSizeAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Oups!", message: "The required size is: 300 x 300", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

extension MarketPlaceCreateStoreVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if self.selectedAssets.count == 0{
//            return 1
//        }else{
//            print("count-------------\(self.selectedAssets.count)")
//            return selectedAssets.count + 1
//            //return uploadImageArray.count + 1
//        }
        if self.imagesFromSource.count == 0 {
            return 1
        }else{
            print("count-------------\(self.imagesFromSource.count)")
            return imagesFromSource.count + 1
            //return uploadImageArray.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageMaketPlaceCollectionViewCell", for: indexPath) as? ImageMaketPlaceCollectionViewCell else {return UICollectionViewCell()}
      //  if selectedAssets.count == 0{
        if imagesFromSource.count == 0{
            cell.viewAddImage.isHidden = false
            cell.btnDelete.isHidden = true
        }else {
            
           // if indexPath.row < selectedAssets.count{
            if indexPath.row < imagesFromSource.count{
                cell.viewAddImage.isHidden = true
                cell.btnDelete.isHidden = false
                self.uploadImageArray = [UIImage]()
//                for image in 0..<self.selectedAssets.count {
//
//                    let asset = self.selectedAssets[image]
//                    let image = asset.fullResolutionImage ?? UIImage()
//                    //self.imageLabel.text = "Photos 0/10 Choose your stores main photo first. Add more photos of your store max 10 allowed."
//                    self.uploadImageArray.append(image)
//
//
//                }
                for image in 0..<self.imagesFromSource.count {
                
                let asset = self.imagesFromSource[image]
//                            let image = asset.fullResolutionImage ?? UIImage()
               self.uploadImageArray.append(asset)
               
           }
                cell.image.image = uploadImageArray[indexPath.row]
                
            }else{
                
                cell.viewAddImage.isHidden = false
                cell.btnDelete.isHidden = true
                
            }
            cell.btnDelete.tag = indexPath.row
            cell.btnDeleteCallback = { tag in
                //self.selectedAssets.remove(at: tag)
                //self.uploadImageArray.remove(at: tag)
                self.imagesFromSource.remove(at: tag)
                self.collectionViewImage.reloadData()
            }
            return cell
        }
        
        return cell
    }
    
    func btnScroll() {
        collectionViewImage.scrollToItem(at: IndexPath(item: self.imagesFromSource.count, section: 0), at: UICollectionView.ScrollPosition.right, animated:true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if self.selectedAssets.count == 0{
//            return CGSize(width: collectionView.bounds.width , height: 200)
//        }else{
//            return CGSize(width: collectionView.bounds.width / 3, height: 200)
//        }
        if self.imagesFromSource.count == 0{
            return CGSize(width: collectionView.bounds.width , height: 200)
        }else{
            return CGSize(width: collectionView.bounds.width / 3, height: 200)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if self.selectedAssets.count ==  0 {
//            // alertToAddImage()
//            alertToAddCustomPicker()
//        }else if indexPath.row >= self.selectedAssets.count{
//            //alertToAddImage()
//            alertToAddCustomPicker()
//        }
        
        if self.imagesFromSource.count ==  0 {
           // alertToAddImage()
            alertToAddCustomPicker()
        }else if indexPath.row >= self.imagesFromSource.count{
            //alertToAddImage()
            alertToAddCustomPicker()
        }
    }
}
extension UIView{
    func addBorder(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
    }
}

class ImageMaketPlaceCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewAddImage: UIView!
    
    var btnDeleteCallback:((Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewAddImage.layer.borderWidth = 0.5
        viewAddImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag)
    }
}

extension MarketPlaceCreateStoreVC {
    func callCreateStoreApi(){
        let params: [String:Any] = [ APIConstants.kName: self.txtStoreName.text ?? "",
                                     APIConstants.kDescription: self.txtDescription.text ?? "",
                                    // APIConstants.kProducerName: self.txtProducerName.text ?? "",
                                     APIConstants.kWebsite: self.txtWebsite.text ?? "",
                                     APIConstants.kStoreRegion: self.txtStoreRegion.text ?? "",
                                     APIConstants.kLocation: self.txtLocation.text ?? "",
                                     "lattitude": "\(self.latitude ?? 0.0)",
                                     APIConstants.kLongitude : "\(self.longitude ?? 0.0)",
                                     APIConstants.kPhone : "\(self.userMobileNumber ?? "")"
                                     
        ]
        
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray,
                                         APIConstants.kImageName: "gallery_images"]
        
        let coverPic: [String:Any] = [APIConstants.kImage : self.imgCover.image ?? UIImage(),
                                      APIConstants.kImageName: "banner_id" ]
        let profilePic: [String:Any] = [APIConstants.kImage : self.imgProfile.image ?? UIImage(),
                                        APIConstants.kImageName: "logo_id" ]
        
        storeImageParams.append(imageParam)
        storeImageParams.append(coverPic)
        storeImageParams.append(profilePic)
        
        CommonUtil.sharedInstance.postToServerRequestMultiPart(APIUrl.kCreateStore, params: params, imageParams: storeImageParams, controller: self) { (dictResponse) in
            
            if let response = dictResponse["data"] as? [String:Any]{
                self.marketPlaceId = (response["marketplace_store_id"] as? Int? ?? 0) ?? 0
            }
            
            let controller = self.pushViewController(withName: AddProductMarketplaceVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace) as? AddProductMarketplaceVC
            controller?.storeImage = self.imgProfile.image ?? UIImage()
            controller?.storeName = self.txtStoreName.text
            controller?.marketPlaceStoreId = self.marketPlaceId
        }
        
    }
//    func callStateApi() {
//        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetCountryStates, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
//
//            let response = dictResponse as? [String:Any]
//            if let data = response?["data"] as? [[String:Any]]{
//                self.stateModel = data.map({StateModel.init(with: $0)})
//                for state in 0..<(self.stateModel?.count ?? 0) {
//                    self.arrStateName.append(self.stateModel?[state].name ?? "")
//                }
//            }
//            self.dataDropDown.dataSource = self.arrStateName
//            self.opendropDown()
//
//        }
//    }
    
    func  callGetFieldStoreApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetStoreFilledValue, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [String:Any]{
                self.userEmail = data["email"]  as? String
                self.userWebsite = data["website"] as? String
                self.userMobileNumber = data["phone"] as? String
                self.userStoreName = data["company_name"] as? String
                self.userLocation = data["address"] as? String
                self.userAbout = data["about"] as? String
                let region = data["state"] as? [String:Any]
                self.userRegion = region?["name"] as? String
 
                self.setDataUI()
            }
            
        }
    }
    
    
}
