//
//  StoreRatingReviewTableVCell.swift
//  Alysei
//
//  Created by SHALINI YADAV on 8/9/21.
//

import UIKit

class StoreRatingReviewTableVCell: UITableViewCell {
    @IBOutlet weak var lblTotalReview: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblClientReview: UILabel!
    @IBOutlet weak var lblReviewData: UILabel!
    
    @IBOutlet weak var viewComment: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(_ data: RatingReviewModel){
        print("Data -----------------------------------\(String(describing: data.user?.company_name))")
        print("Data----------------------------\(data.review ?? "")")
        self.lblClientName.text = data.user?.company_name
        self.lblClientReview.text = data.review
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: data.created_at ?? "") {
            print(dateFormatterPrint.string(from: date))
            self.lblReviewData.text = "\(dateFormatterPrint.string(from: date))"
        } else {
           print("There was an error decoding the string")
        }
    }
}
