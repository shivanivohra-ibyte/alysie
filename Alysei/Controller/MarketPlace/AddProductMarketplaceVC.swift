//
//  AddProductMarketplaceVC.swift
//  Alysei
//
//  Created by SHALINI YADAV on 6/4/21.
//

import UIKit
import TLPhotoPicker

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

    var uploadImageArray = [UIImage]()
    var selectedAssets = [TLPHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        headerView.drawBottomShadow()
        // Do any additional setup after loading the view.
    }
    private func alertToAddCustomPicker() -> Void {
        let viewCon = CustomPhotoPickerViewController()
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
    //MARK:- IBAction
    
    @IBAction func btnNextAction(_ sender: UIButton){
        _ = pushViewController(withName: MarketPlaceConfirmationVC.id(), fromStoryboard: StoryBoardConstants.kMarketplace)
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
