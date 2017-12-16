//
//  DetailViewCell_G.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/12/02.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//

import UIKit
//import CoreGraphics

class detailViewCell_G: UITableViewCell {

    @IBOutlet weak var varticalLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    
    override func awakeFromNib() {
    super.awakeFromNib()
            
        //textLabelデザイン-----------------------------------------
        varticalLabel?.font = UIFont(name: "Futura", size: 12)
        varticalLabel?.textColor = UIColor.black

        //Viewの背景、囲い線-----------------------------------------
        background?.backgroundColor = UIColor(
              red: 230/255.0
            , green: 230/255.0
            , blue: 230/255.0
            , alpha: 1.0
        )
//        background?.layer.borderWidth = 2.0
//        background?.layer.borderColor = (UIColor(
//            red: 255/255.0
//            , green: 255/255.0
//            , blue: 255/255.0
//            , alpha: 1.0
//            ) as! CGColor
//        )
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
