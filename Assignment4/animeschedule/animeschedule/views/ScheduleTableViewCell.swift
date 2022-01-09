//
//  ScheduleTableViewCell.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-30.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var showDay: UILabel!
    @IBOutlet weak var showTitle: UITextView!
    @IBOutlet weak var showImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
