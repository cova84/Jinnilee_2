//
//  URLCell_W.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/12/02.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//

import UIKit
//import CoreGraphics

class urlCell_W: UITableViewCell {


    @IBOutlet weak var background: UIView!
    @IBOutlet weak var buttonTitle: UIButton!
    //TableViewからurlを受け取るプロパティを作る。
    var url:String = ""
    
    @IBAction func button(_ sender: UIButton) {
        let url = URL(string: self.url)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    override func awakeFromNib() {
    super.awakeFromNib()
        //Viewの背景、囲い線-----------------------------------------
        background?.backgroundColor = UIColor(
              red: 248/255.0
            , green: 248/255.0
            , blue: 248/255.0
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
