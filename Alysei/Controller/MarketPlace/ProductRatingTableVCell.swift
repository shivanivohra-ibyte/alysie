//
//  ProductRatingTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/2/21.
//

import UIKit

class ProductRatingTableVCell: UITableViewCell {

    @IBOutlet weak var lblTotalReview: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblClientReview: UILabel!
    @IBOutlet weak var lblReviewData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(_ data: RatingReviewModel){
        print("Data -----------------------------------\(String(describing: data.user?.companyName))")
        print("Data----------------------------\(data.review)")
        //self.lblClientName.text = data.user?.companyName
        //self.lblReviewData.text = data.review
    }

}
