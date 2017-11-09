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
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.font = bodyFont
        serialLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFont(forTextStyle: .caption1)
        valueLabel.font = caption1Font
    }
}
