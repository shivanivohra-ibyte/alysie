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
    @IBOutlet weak var lblProducerName:UILabel!
    @IBOutlet weak var imgProducer: UIImageView!
    var pushCallBack: ((Int) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgProducer.layer.cornerRadius = 25
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
    
    @IBAction func btnViewProfile(_ sender: UIButton){
        self.pushCallBack?(sender.tag)
    }
    @IBAction func btnViewAllReview(_ sender: UIButton){
        self.pushCallBack?(sender.tag)
       
    }
}
