//
//  SelectedHubsTableCell.swift
//  Alysie
//
//  Created by CodeAegis on 27/01/21.
//

import UIKit

protocol TappedHubs {
  
  func tapOnHub() -> Void
}

class SelectedHubsTableCell: UITableViewCell {
  
  @IBOutlet weak var collectionViewSelectedHubs: UICollectionView!
  
  var delegate: TappedHubs?
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    collectionViewSelectedHubs.delegate = self
    collectionViewSelectedHubs.dataSource = self
  }
  
  public func getSelectedHubsCollectionCell(_ indexPath: IndexPath) -> UICollectionViewCell{
    
    let selectedHubsCollectionCell = collectionViewSelectedHubs.dequeueReusableCell(withReuseIdentifier: SelectedHubsCollectionCell.identifier(), for: indexPath) as! SelectedHubsCollectionCell
    return selectedHubsCollectionCell
  }
}


//MARK: - CollectionView Methods -

extension SelectedHubsTableCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 3
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    return self.getSelectedHubsCollectionCell(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        
    self.delegate?.tapOnHub()
    //_ = pushViewController(withName: HubsViewC.id(), fromStoryboard: StoryBoardConstants.kHome)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (kScreenWidth - 75.0)/3
    return CGSize(width: width, height: width + 32.0)
  }
    
}
