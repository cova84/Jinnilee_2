//
//  TestCell.swift
//  varticalCustomCell
//
//  Created by Eriko Ichinohe on 2017/12/04.
//  Copyright © 2017年 Eriko Ichinohe. All rights reserved.
//

import UIKit

class testCell: UITableViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var varticalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
