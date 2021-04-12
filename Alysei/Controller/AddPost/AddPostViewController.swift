//
//  AddPostViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 12/04/21.
//

import UIKit

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var btnPostPrivacy: UIButton!
    @IBOutlet weak var txtPost: UITextView!
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var viewHeaderShadow: UIView!
    @IBOutlet weak var collectionViewImage: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
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
    }
    @IBAction func btnCamera(_ sender: UIButton){
        self.showImagePicker(withSourceType: .camera, mediaType: .image)

    }
    @IBAction func btnGallery(_ sender: UIButton){
        self.showImagePicker(withSourceType: .photoLibrary, mediaType: .image)
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

//MARK: - ImagePickerViewDelegate Methods -

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        self.dismiss(animated: true) {
            self.uploadImageArray.append(selectedImage)
            self.collectionViewHeight.constant = 150
            self.collectionViewImage.isHidden = false
            self.collectionViewImage.reloadData()
            print("UploadImage------------------------------------\(self.uploadImageArray)")
        }
    }
}

//MARK: UICollectionViewDataSource,UICollectionViewDelegate

extension AddPostViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uploadImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as?ImageCollectionViewCell else {return UICollectionViewCell()}
        cell.image.image = uploadImageArray[indexPath.row]
        return cell
    }
    
    
}

class ImageCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var image: UIImageView!
}
