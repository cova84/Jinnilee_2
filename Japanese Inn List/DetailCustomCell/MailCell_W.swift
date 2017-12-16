//
//  MailCell_W.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/12/02.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//
//
import UIKit
import MessageUI

class mailCell_W: UITableViewCell, MFMailComposeViewControllerDelegate {


    @IBOutlet weak var background: UIView!
    @IBOutlet weak var buttonTitle: UIButton!
    //TableViewからurlを受け取るプロパティを作る。
    var mail:String = ""
    
    //リンク先のURL準備
    @IBAction func button(_ sender: UIButton) {
        let mailOpne = "mailto:\(self.mail)?subject=&body=メールでのご予約の際は、必ず、必要な予約に情報を確認してから、ご入力をお願い致します。\n\n\n\n------------------------------------------------\n世界の日本人宿一覧アプリ【Jinnilee】を利用し、\nお問い合わせをしております。\nアプリケーションについてのご意見・要望は、\n下記のHPへアクセスしコメントをお願い致します。\nhttps://life-of.net/2017/12/17/世界日本人宿まとめ一覧アプリjinnilee/ \n------------------------------------------------".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = NSURL(string: mailOpne!)
        UIApplication.shared.openURL(url as! URL)
    }
    

    
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients(["\(mail)"]) // 宛先アドレス
//            mail.setSubject("お問い合わせ") // 件名
//            mail.setMessageBody("ここに本文が入ります。", isHTML: false) // 本文
//            present(mail, animated: true, completion: nil)
//        } else {
//            print("送信できません")
//        }
//    }
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        switch result {
//        case .cancelled:
//            print("キャンセル")
//        case .saved:
//            print("下書き保存")
//        case .sent:
//            print("送信成功")
//        default:
//            print("送信失敗")
//        }
//        dismiss(animated: true, completion: nil)
//    }
        


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
