//
//  CompanyViewC.swift
//  Alysie
//
//  Created by Alendra Kumar on 19/01/21.
//

import UIKit

class CompanyViewC: AlysieBaseViewC {
    
    //MARK: - IBOutlet -
    
    @IBOutlet weak var tblViewCompany: UITableView!
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var lblVatTitle: UILabel!
    @IBOutlet weak var txtVat: UITextField!
    @IBOutlet weak var lblFDATitle: UILabel!
    @IBOutlet weak var txtFDA: UITextField!

    
    var titleArray = ["VAT","FDA Number"]
    var cetificateTitle = ["Photo of Label","FCE-SID Certification","Phytosanitary Certificate","Packaging od USA","Food Safety Plan","Animal Health or ASL Certificate"]
    var certificatDesc = ["Upload an image your product's label","Upload an image of your FCE-SID certification","Upload an image of your Phytosanitary Certificate","Upload an image or PDF of your packaging for USA","Upload an image or PDF of your food safety plan","Upload an image or PDF of your Animal Health or ASL Certificate"]
    var getCompanyFields: CompanyCertificates?
    var picker = UIImagePickerController()
    var photoOfLabelImage : UIImage?
    var fceSidImage : UIImage?
    var phytoImage : UIImage?
    var packaginImage : UIImage?
    var foodSafetyImage : UIImage?
    var animalImage : UIImage?
    var getUploadImageIndex: Int?
    var arrUploadImageIndex =  [Int]()
    var vatNo: String?
    var FdaNo: String?
    var selectedUserOptionId: String?
    
    
    //MARK: - ViewLifeCycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callGetCertificatesApi()
        
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        self.viewNavigation.drawBottomShadow()
    }
    
    //MARK: - IBAction -
    
    @IBAction func tapClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        selectedUserOptionId = ""
        self.callSaveDocumentApi()
//        DispatchQueue.main.asyncAfter(deadline: . now() + 0.5) {
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    @IBAction func btnVatDesc(_ sender: UIButton){
        self.showAlert(withMessage: "Provide your value-added tax ID")
    }
    @IBAction func btnFdaDesc(_ sender: UIButton){
        self.showAlert(withMessage: "Provide your Food and Drug Administration identification")
    }
    //MARK: - Private Methods -
    func initialSetUp(){
        self.lblVatTitle.text = titleArray[0]
        self.txtVat.text = getCompanyFields?.userData?.vatNo
        self.lblFDATitle.text = titleArray[1]
        self.txtFDA.text = getCompanyFields?.userData?.fdaNo
    }

//    private func getCompanyFirstTableCell(_ indexPath: IndexPath) -> UITableViewCell{
//
//        let companyFirstTableCell = tblViewCompany.dequeueReusableCell(withIdentifier: CompanyFirstTableCell.identifier(), for: indexPath) as! CompanyFirstTableCell
//        let obj = getCompanyFields?.userData
//        companyFirstTableCell.configCell(titleArray[indexPath.row], obj, indexPath.row)
//        companyFirstTableCell.btnCallback = {
//            if indexPath.row == 0{
//                self.showAlert(withMessage: "Provide your value-added tax ID")
//            }else{
//                self.showAlert(withMessage: "Provide your Food and Drug Administration identification")
//            }
//        }
//        return companyFirstTableCell
//    }
    
    private func getCompanySecondTableCell(_ indexPath: IndexPath) -> UITableViewCell{
        
        let companySecondTableCell = tblViewCompany.dequeueReusableCell(withIdentifier: CompanySecondTableCell.identifier(), for: indexPath) as! CompanySecondTableCell
        let obj = getCompanyFields?.dataCertificates?[indexPath.section] ?? DataCertificates.init(with: [:])
        companySecondTableCell.configCell(cetificateTitle[indexPath.row],certificatDesc[indexPath.row] ,indexPath.section ,indexPath.row, obj)
        companySecondTableCell.btnUploadChange.tag = indexPath.row
        companySecondTableCell.btnUploadCallBack = { index in
            self.getUploadImageIndex = index
            self.selectedUserOptionId = self.getCompanyFields?.dataCertificates?[indexPath.section].userFieldOptionId
            self.alertToAddImage()
        }
        
        return companySecondTableCell
    }
}

//MARK: - TableView Methods -

extension CompanyViewC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getCompanyFields?.dataCertificates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //switch section {
       // case 0:
       //     return 2
        //default:
            return cetificateTitle.count
       // }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // switch indexPath.section {
        //case 0:
          //  return self.getCompanyFirstTableCell(indexPath)
        //default:
            return self.getCompanySecondTableCell(indexPath)
        //}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 95.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getCompanyFields?.dataCertificates?[section].option ?? ""
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
    }
}
extension CompanyViewC {
    func callGetCertificatesApi(){
        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kGetCertificates, requestMethod: .GET, requestParameters: [:], withProgressHUD: true) { (dictResponse, error, errortype, statusCode) in
            let response = kSharedInstance.getDictionary(dictResponse)
            if let data = response["data"] as? [String:Any]{
                self.getCompanyFields = CompanyCertificates.init(with: data)
            }
            self.initialSetUp()
            self.tblViewCompany.reloadData()
        }
    }
    
    func callSaveDocumentApi(){
        let params: [String:Any] = [ APIConstants.userFieldOptionId : selectedUserOptionId ?? "",
                                     APIConstants.vatNo : txtVat.text ?? "",
                                     APIConstants.fdaNo: txtFDA.text ?? "",
        ]
       
        let imageParamSid:[String:Any] = [APIConstants.kImage: fceSidImage ,
                                              APIConstants.kImageName: APIConstants.fceSidCertification
        ]
        let imageParamPhyto: [String:Any] = [
            APIConstants.kImage : phytoImage,
            APIConstants.kImageName: APIConstants.phytosanitaryCertificate
        ]
        let imageParamPackaging: [String:Any] = [
            APIConstants.kImage : packaginImage,
            APIConstants.kImageName: APIConstants.packagingForUsa
        ]
        let imageParamfoodSafetyPlan: [String:Any] = [
            APIConstants.kImage : foodSafetyImage,
            APIConstants.kImageName: APIConstants.foodSafetyPlan
        ]
        let imageParamanimalHelath: [String:Any] = [
            APIConstants.kImage : animalImage,
            APIConstants.kImageName: APIConstants.animalHelathAslCertificate
        ]
        let imageParamPhotoOfLabel: [String:Any] = [
            APIConstants.kImage : photoOfLabelImage,
            APIConstants.kImageName: APIConstants.photoOfLabel
        ]
        var imageParam = [[String:Any]]()
        imageParam.append(imageParamSid)
        imageParam.append(imageParamPhyto)
        imageParam.append(imageParamPackaging)
        imageParam.append(imageParamfoodSafetyPlan)
        imageParam.append(imageParamanimalHelath)
        imageParam.append(imageParamPhotoOfLabel)

        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: APIUrl.kUploadCertificate, requestMethod: .post, requestImages: imageParam, requestVideos: [:], requestData: params) { (dictResponse, error, errorType, statusCode) in
            self.showAlert(withMessage: "Document Uploaded Successfully")
            self.photoOfLabelImage = UIImage()
            self.fceSidImage = UIImage()
            self.phytoImage = UIImage()
            self.packaginImage = UIImage()
            self.foodSafetyImage = UIImage()
            self.animalImage = UIImage()
            self.callGetCertificatesApi()
            self.tblViewCompany.reloadData()
        }
    }
}

//MARK: - ImagePickerViewDelegate Methods -

extension CompanyViewC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.dismiss(animated: true) {
            // self.imgViewProfile.image = selectedImage
           // self.postImage = selectedImage
           
            if self.getUploadImageIndex == 0 {
                self.photoOfLabelImage = selectedImage
            }else if self.getUploadImageIndex == 1{
                self.fceSidImage = selectedImage
            }else if self.getUploadImageIndex == 2{
                self.phytoImage = selectedImage
            }
            else if self.getUploadImageIndex == 3{
                self.packaginImage = selectedImage
            }
            else if self.getUploadImageIndex == 4{
                self.foodSafetyImage = selectedImage
            }
            else if self.getUploadImageIndex == 5{
                self.animalImage = selectedImage
            }
            self.arrUploadImageIndex.append(self.getUploadImageIndex ?? -1)
            self.callSaveDocumentApi()
           
            
        }
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
        
        if UIImagePickerController.isSourceTypeAvailable(type){
            
            self.picker.mediaTypes = mediaType.CameraMediaType
            self.picker.allowsEditing = false
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


//extension CompanyViewC {
//    func callGetCertificatesApi(){
//        let url = URL(string: APIUrl.kGetCertificates)!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        WebServices.shared.request(urlRequest) { (data, response, error) in
//            guard let data = data else {
//                return
//            }
//            do {
//                let responseModel = try JSONDecoder().decode(Dummy.JSON.Response.self, from: data)
//                print(responseModel)
//            } catch {
//                print(error)
//            }
//            print("Success")
//        }
//    }
//}
