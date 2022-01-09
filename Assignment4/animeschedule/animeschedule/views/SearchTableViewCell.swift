//
//  SearchTableViewCell.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-29.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var airing: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
