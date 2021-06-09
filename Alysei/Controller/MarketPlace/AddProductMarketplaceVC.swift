//
//  AddProductMarketplaceVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/4/21.
//

import UIKit
import TLPhotoPicker
import DropDown

class AddProductMarketplaceVC: AlysieBaseViewC,TLPhotosPickerViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    @IBOutlet weak var view10: UIView!
    @IBOutlet weak var view11: UIView!
    @IBOutlet weak var view12: UIView!
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var collectionViewImage: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var showStoreImage: UIImageView!
    @IBOutlet weak var showStoreName: UILabel!
    @IBOutlet weak var txtProductTitle: UITextField!
    @IBOutlet weak var txtProductDesc: UITextView!
    @IBOutlet weak var txtProductKeyWord: UITextField!
    @IBOutlet weak var txtProductCategory: UITextField!
    @IBOutlet weak var txtProductSubCategory: UITextField!
    @IBOutlet weak var txtProductQuantityAvaliable: UITextField!
    @IBOutlet weak var txtProductBrandLabel: UITextField!
    @IBOutlet weak var txtProductMinOrderQuantity: UITextField!
    @IBOutlet weak var txtProductHandleIns: UITextView!
    @IBOutlet weak var txtProductDispatchIns: UITextView!
    @IBOutlet weak var txtProductSample: UITextField!
    @IBOutlet weak var txtProductPrice: UITextField!

    var uploadImageArray = [UIImage]()
    var selectedAssets = [TLPHAsset]()
    var storeImage = UIImage()
    var storeName: String?
    var arrProductType = [String]()
    var openDropDown: DropDownCheck?
    var productType: [SignUpOptionsDataModel]?
    let dataDropDown = DropDown()
    var productId: Int?
    var subProductId: Int?
    var brandLabelId: Int?
    var marketPlaceStoreId: Int?
    var availableForSample: String?
    var sampleArr = ["Yes","No"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(openProductCategory))
        self.view4.addGestureRecognizer(tap)
        let subTap = UITapGestureRecognizer(target: self, action: #selector(openSubProductCategory))
        self.view5.addGestureRecognizer(subTap)
        let brandTap = UITapGestureRecognizer(target: self, action: #selector(openBrands))
        self.view7.addGestureRecognizer(brandTap)
        let sampleTap = UITapGestureRecognizer(target: self, action: #selector(openSample))
        self.view11.addGestureRecognizer(sampleTap)
        // Do any additional setup after loading the view.
    }
    
    func setDataUI(){
        view1.addBorder()
        view2.addBorder()
        view3.addBorder()
        view4.addBorder()
        view5.addBorder()
        view6.addBorder()
        view7.addBorder()
        view8.addBorder()
        view9.addBorder()
        view10.addBorder()
        view11.addBorder()
        view12.addBorder()
        showStoreImage.image = self.storeImage
        showStoreName.text = self.storeName
        headerView.drawBottomShadow()
        showStoreImage.layer.cornerRadius = self.showStoreImage.frame.height / 2
    }
    private func alertToAddCustomPicker() -> Void {
        let viewCon = TLPhotosPickerViewController()
        viewCon.delegate = self
        viewCon.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
            self?.showExceededMaximumAlert(vc: picker)
        }
        var configure = TLPhotosPickerConfigure()
        configure.allowedVideoRecording = false

        configure.mediaType = .image
        configure.numberOfColumn = 3

        viewCon.configure = configure
        viewCon.selectedAssets = self.selectedAssets
        viewCon.logDelegate = self

        self.present(viewCon, animated: true, completion: nil)
    }
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        // use selected order, fullresolution image
        print("dismiss")
        self.selectedAssets = withTLPHAssets

        print("selectedAssest-----------------\(self.selectedAssets)")
        
        self.collectionViewImage.reloadData()
        self.btnScroll()
       
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
    
    @objc func openProductCategory(){
        openDropDown = .productType
        callProductCategory()
    }
    @objc func openSubProductCategory(){
        openDropDown = .productCategoryType
        callSubProductCategory()
    }
    @objc func openBrands(){
        openDropDown = .brandLabel
        callBrandCategory()
    }
    
    @objc func openSample(){
        openDropDown = .availableForSample
        self.dataDropDown.dataSource = self.sampleArr
        self.opendropDown()
        
    }
    func opendropDown(){
        dataDropDown.show()
        if openDropDown == .productType{
        dataDropDown.anchorView = view4
        }else if openDropDown == .productCategoryType{
            dataDropDown.anchorView = view5
        }else if openDropDown == .brandLabel{
            dataDropDown.anchorView = view7
        }else if openDropDown == .availableForSample{
            dataDropDown.anchorView = view11
        }
        dataDropDown.bottomOffset = CGPoint(x: 0, y: (dataDropDown.anchorView?.plainView.bounds.height)!)
        dataDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if openDropDown == .productType{
            self.txtProductCategory.text = item
                self.productId = productType?[index].marketplaceProductCategoryId
            }else if openDropDown == .productCategoryType{
                self.txtProductSubCategory.text = item
                    self.subProductId = productType?[index].marketplaceProductSubcategoryId
            }else if openDropDown == .brandLabel{
                self.txtProductBrandLabel.text = item
                    self.brandLabelId = productType?[index].marketplaceBrandLabelId
            }else if openDropDown == .availableForSample{
                self.txtProductSample.text = item
            }
           
        }
        dataDropDown.cellHeight = 40
        dataDropDown.backgroundColor = UIColor.white
        dataDropDown.selectionBackgroundColor = UIColor.clear
        dataDropDown.direction = .bottom
    }
    //MARK:- IBAction
    
    @IBAction func btnNextAction(_ sender: UIButton){
        self.addProductApi()
        //_ = pushViewController(withName: MarketPlaceConfirmationVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
//MARK:- Custom Picker
extension AddProductMarketplaceVC: TLPhotosPickerLogDelegate {
    //For Log User Interaction
    func selectedCameraCell(picker: TLPhotosPickerViewController) {
        print("selectedCameraCell")
    }

    func selectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        print("selectedPhoto")
        print(picker.selectedAssets.count)
        //self.collectionViewImage.reloadData()
        // let image = picker.selectedAssets[at]
        //  print(image)
    }
    
    func deselectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
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
extension AddProductMarketplaceVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.selectedAssets.count == 0{
            return 1
        }else{
            print("count-------------\(self.selectedAssets.count)")
            return selectedAssets.count + 1
            //return uploadImageArray.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageMaketPlaceCollectionViewCell", for: indexPath) as? ImageMaketPlaceCollectionViewCell else {return UICollectionViewCell()}
            if selectedAssets.count == 0{
            cell.viewAddImage.isHidden = false
            cell.btnDelete.isHidden = true
        }else {

                    if indexPath.row < selectedAssets.count{
                    cell.viewAddImage.isHidden = true
                    cell.btnDelete.isHidden = false
                        self.uploadImageArray = [UIImage]()
                        for image in 0..<self.selectedAssets.count {
                           
                             let asset = self.selectedAssets[image]
                            let image = asset.fullResolutionImage ?? UIImage()
                            self.uploadImageArray.append(image)
                            
                        }
                        cell.image.image = uploadImageArray[indexPath.row]
                       
                }else{
                   
                cell.viewAddImage.isHidden = false
                cell.btnDelete.isHidden = true

        }
            cell.btnDelete.tag = indexPath.row
            cell.btnDeleteCallback = { tag in
                self.selectedAssets.remove(at: tag)
                //self.uploadImageArray.remove(at: tag)
                self.collectionViewImage.reloadData()
            }
            return cell
        }
       
        return cell
    }
    
    func btnScroll() {
        collectionViewImage.scrollToItem(at: IndexPath(item: self.selectedAssets.count, section: 0), at: UICollectionView.ScrollPosition.right, animated:true)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.selectedAssets.count == 0{
            return CGSize(width: collectionView.bounds.width , height: 200)
        }else{
            return CGSize(width: collectionView.bounds.width / 3, height: 200)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedAssets.count ==  0 {
           // alertToAddImage()
            alertToAddCustomPicker()
        }else if indexPath.row >= self.selectedAssets.count{
            //alertToAddImage()
            alertToAddCustomPicker()
        }
    }
}

extension AddProductMarketplaceVC{
    func callProductCategory(){
        self.arrProductType.removeAll()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kProducttCategory, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.productType = data.map({SignUpOptionsDataModel.init(withDictionary: $0)})
                print("Count ------------------------------\(self.productType?.count ??  0)")
                for product in 0..<(self.productType?.count ?? 0) {
                    self.arrProductType.append(self.productType?[product].name ?? "")
                }
                self.dataDropDown.dataSource = self.arrProductType
                self.opendropDown()
               
            }
        }
       
    }
    func callSubProductCategory(){
        self.arrProductType.removeAll()
        self.productType = [SignUpOptionsDataModel]()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kSubProductCategoryId + "\(self.productId ?? 0)", requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.productType = data.map({SignUpOptionsDataModel.init(withDictionary: $0)})
                print("Count ------------------------------\(self.productType?.count ??  0)")
                for product in 0..<(self.productType?.count ?? 0) {
                    self.arrProductType.append(self.productType?[product].name ?? "")
                }
                self.dataDropDown.dataSource = self.arrProductType
                self.opendropDown()
               
            }
        }
       
    }
    func callBrandCategory(){
        self.arrProductType.removeAll()
        self.productType = [SignUpOptionsDataModel]()
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kBrandLabel, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errorType, statusCode) in
            
            let response = dictResponse as? [String:Any]
            if let data = response?["data"] as? [[String:Any]]{
                self.productType = data.map({SignUpOptionsDataModel.init(withDictionary: $0)})
                print("Count ------------------------------\(self.productType?.count ??  0)")
                for product in 0..<(self.productType?.count ?? 0) {
                    self.arrProductType.append(self.productType?[product].name ?? "")
                }
                self.dataDropDown.dataSource = self.arrProductType
                self.opendropDown()
               
            }
        }
        
    }
    func addProductApi(){
        let params: [String:Any] = [
            APIConstants.kmarketplaceStoreId: "\(self.marketPlaceStoreId ?? 0)",
            APIConstants.kTitle: self.txtProductTitle.text ?? "",
            APIConstants.kDescription: self.txtProductDesc.text ?? "",
            APIConstants.kKeywords: self.txtProductKeyWord.text ?? "",
            APIConstants.kProductCategoryId : "\(self.productId ?? 0)",
            APIConstants.kProductSubCategoryId: "\(self.subProductId ?? 0)",
            APIConstants.kQuantityAvailable: self.txtProductQuantityAvaliable.text ?? "",
            APIConstants.kbrandLabelId: "\(self.brandLabelId ?? 0)",
            APIConstants.kMinOrderQuantity: self.txtProductMinOrderQuantity.text ?? "",
            APIConstants.kHandlingInstruction: self.txtProductHandleIns.text ?? "",
            APIConstants.kDispatchInstruction: self.txtProductDispatchIns.text ?? "",
            APIConstants.kAvailableForSample: self.txtProductSample.text ?? "",
            APIConstants.kProductPrice: self.txtProductPrice.text ?? ""
        ]
        
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray,
                                         APIConstants.kImageName: "gallery_images"]
    
        
        print("ImageParam------------------------------\(imageParam)")
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kSaveProduct, image: imageParam, controller: self, type: 0)
    }
    
    override func didUserGetData(from result: Any, type: Int) {
//        self.showAlert(withMessage: "Post Successfully") {
//        }
        self.uploadImageArray = [UIImage]()
        self.selectedAssets.removeAll()
        self.uploadImageArray.removeAll()
        self.collectionViewImage.reloadData()

        _ = pushViewController(withName: MarketPlaceConfirmationVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)

    }
}

