//
//  ItemCell.swift
//  Homepwner
//
//  Created by 张鑫 on 2017/11/9.
//  Copyright © 2017年 张鑫. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet  var nameLabel: UILabel!
    @IBOutlet  var serialLabel: UILabel!
    @IBOutlet  var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
