//
//  customProductCell.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-22.
//

import UIKit

class CustomProductCell: UITableViewCell {

    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var productQty: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
