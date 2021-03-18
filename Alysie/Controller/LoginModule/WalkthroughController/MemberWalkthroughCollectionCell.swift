//
//  MemberWalkthroughCollectionCell.swift
//  Alysie
//
//  Created by CodeAegis on 02/02/21.
//

import UIKit

protocol NextButtonDelegate {
  
  func tapNext(_ cell: MemberWalkthroughCollectionCell,currentModel: GetWalkThroughDataModel,btn: UIButton) -> Void
}

class MemberWalkthroughCollectionCell: UICollectionViewCell {
  
  //MARK: - IBOutlet -
  
  @IBOutlet weak var imgViewBackground: UIImageView!
  @IBOutlet weak var lblDescription: UILabel!
  @IBOutlet weak var btnNext: UIButtonExtended!
  @IBOutlet weak var paging: UIPageControl!
  @IBOutlet weak var btnSkip: UIButton!
  @IBOutlet weak var lblTitle: UILabel!
  
  //MARK: - Properties -
  
  var delegate: NextButtonDelegate?
  var getWalkThroughDataModel: GetWalkThroughDataModel!
  
  override func awakeFromNib() {
    
    
  }
  
  //MARK: - IBAction -
  
  @IBAction func tapNext(_ sender: UIButton) {
    
    self.delegate?.tapNext(self, currentModel: self.getWalkThroughDataModel, btn: self.btnNext)
  }
  
  @IBAction func tapSkip(_ sender: UIButton) {
    
    self.delegate?.tapNext(self, currentModel: self.getWalkThroughDataModel, btn: self.btnSkip)
  }
  
  //MARK: - Public Methods -
  
  public func configureData(withGetWalkThroughDataModel model: GetWalkThroughDataModel,indexPath: IndexPath, viewModel: GetWalkThroughViewModel) -> Void{
    
    switch indexPath.item {
    case 0:
      self.btnSkip.isHidden = false
      self.btnNext.setTitle(AppConstants.GetStarted, for: .normal)
    default:
      if indexPath.item == viewModel.arrWalkThroughs.count - 1{
        self.btnNext.setTitle(AppConstants.Finish, for: .normal)
        self.btnSkip.isHidden = true
      }
      else{
        self.btnSkip.isHidden = false
        self.btnNext.setTitle(AppConstants.Next, for: .normal)
      }
    }
    self.getWalkThroughDataModel = model
    self.lblTitle.text = model.title
    self.lblDescription.text = model.walkthroughDescription
    self.paging.currentPage = indexPath.item
  }
}



