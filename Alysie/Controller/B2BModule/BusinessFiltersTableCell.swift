//
//  BusinessFiltersTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 25/01/21.
//

import UIKit

class BusinessFiltersTableCell: UITableViewCell {
 
  //MARK: - IBOutlet -
  
  @IBOutlet weak var collectionViewFilters: UICollectionView!
  @IBOutlet weak var lblFilterHeading: UILabel!
  
  //MARK: - Properties -
  
  var businessDataModel: BusinessDataModel!
  var selectedIndex: [Int] = []
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    self.collectionViewFilters.delegate = self
    self.collectionViewFilters.dataSource = self
  }
  
  //MARK: - Private Methods -
  
  private func getBusinessFiltersCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let businessFiltersCollectionCell = collectionViewFilters.dequeueReusableCell(withReuseIdentifier: BusinessFiltersCollectionCell.identifier(), for: indexPath) as! BusinessFiltersCollectionCell
    businessFiltersCollectionCell.configureData(withBusinessDataModel: self.businessDataModel, indexPath: indexPath, selectedIndex: self.selectedIndex)
    return businessFiltersCollectionCell
  }
  
  //MARK: - Public Methods -
  
  public func configureData(withBusinessDataModel model: BusinessDataModel) -> Void{
    
    self.selectedIndex.removeAll()
    self.businessDataModel = model
    self.lblFilterHeading.isHidden = (model.arrFilters == StaticArrayData.kRestaurantFilter) ? false : true
    self.collectionViewFilters.reloadData()
  }
}

//MARK: - CollectionView Methods -

extension BusinessFiltersTableCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return self.businessDataModel.arrFilters.count
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getBusinessFiltersCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
    self.selectedIndex.append(indexPath.item)
    self.collectionViewFilters.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: (kScreenWidth - 30.0)/3, height: 40.0)
  }
    
}
