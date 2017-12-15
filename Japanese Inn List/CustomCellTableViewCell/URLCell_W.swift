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
    @IBOutlet weak var urlButtonTitle: UIButton!
    @IBAction func urlButton(_ sender: UIButton) {
        
        let url = URL(string: "https://life-of.net")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        //タグで情報を受け取る
        print("tag受け取り\(tag)")
        
        //Viewの背景、囲い線-----------------------------------------
        background?.backgroundColor = UIColor(
              red: 255/255.0
            , green: 255/255.0
            , blue: 5/255.0
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
        
//        //plistの読み込み02--------------------------------------------------------
//        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
//        let path = Bundle.main.path(forResource: "hotel_list_Detail", ofType: "plist")
//        //ファイルの内容を読み込んでディクショナリー型に格納
//        let dic = NSDictionary(contentsOfFile: path!)
//        let dic001 = dic!["self.tag"]! as! NSDictionary
    }


//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
