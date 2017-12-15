//  DetailView.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/11/16.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.

import UIKit
import MapKit
import Foundation
import CoreData


class DetailView:UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    //画面全体のScrollView
    @IBOutlet weak var ditailScrollView: UIScrollView!

    //toDitailセグエ用　plistの配列を保存するメンバ変数
    var getKeyDic = NSDictionary()
    //Favorite（内容を）格納する配列TabelViewを準備
    var contentHotel:[NSDictionary] = []
    var contentCountry:[NSDictionary] = []
    var contentID:[NSDictionary] = []

    
    
    //宿情報タイトル〜住所-----------------------------------------------------------------------------------------
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelComment: UITextView!
    @IBOutlet weak var hotelMap: MKMapView!
    @IBOutlet weak var hotelAddress: UITextView!
    ////詳細情報-------------------------------------------------------------------------------------------------
    @IBOutlet weak var detailedInfoTableView: UITableView!
   // @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    ////予約方法--------------------------------------------------------------------------------------------------
    @IBOutlet weak var reservationTabelView: UITableView!
    
    
    
    //UIScrollView 横スクロールで表示
    @IBOutlet weak var hotelImageScrollView: UIScrollView!
    // Screenの高さ
    var screenHeight:CGFloat!
    // Screenの幅
    var screenWidth:CGFloat!
    
    
    
    //お気に入り追加ボタンを押された時発動　-----------------------------------------------------------------------------
    @IBAction func saveFavorites(_ sender: UIButton) {
        print("お気に入りに保存されました")

        //AppDelegateを使う用意をしておく（インスタンス化）
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //エンティティを操作する為のオブジェクト作成
        let viewContext = appDelegate.persistentContainer.viewContext
        //Favoriteエンティティオブジェクトを作成
        let Favorite = NSEntityDescription.entity(forEntityName: "Favorite", in: viewContext)
        
        //Favoriteエンティティにレコード（行）を挿入する為のオブジェクトを作成
        let newRecord = NSManagedObject(entity: Favorite!, insertInto: viewContext)
        
        //値のセット
        let hotel = getKeyDic["hotelName"] as! String
        let country = getKeyDic["country"] as! String
        let id = getKeyDic["id"] as! Int
        
        newRecord.setValue(hotel, forKey: "hotel")  //hotel列に文字列をセット
        newRecord.setValue(country, forKey: "country")  //country列に文字列をセット
        newRecord.setValue(id, forKey: "id")  //country列に文字列をセット
        print("\(hotel)","\(id)","\(country)")

        //レコード（行）の即時保存
        do{
            try viewContext.save()
        }catch{
            //エラーが出た時に行う処理を書いておく場所
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nibName: ""はswiftのタイトル
        var cellHeight:CGFloat = 30.0
        self.detailedInfoTableView.register(UINib(nibName: "DetailViewCell_G", bundle: nil), forCellReuseIdentifier: "CellTB_D_G")
        self.detailedInfoTableView.estimatedRowHeight = cellHeight
        self.detailedInfoTableView.rowHeight = UITableViewAutomaticDimension
        
        self.detailedInfoTableView.register(UINib(nibName: "DetailViewCell_W", bundle: nil), forCellReuseIdentifier: "CellTB_D_W")
        self.detailedInfoTableView.estimatedRowHeight = cellHeight
        self.detailedInfoTableView.rowHeight = UITableViewAutomaticDimension
        
        self.reservationTabelView.register(UINib(nibName: "DetailViewCell_G", bundle: nil), forCellReuseIdentifier: "CellTB_R_G")
        self.reservationTabelView.estimatedRowHeight = cellHeight
        self.reservationTabelView.rowHeight = UITableViewAutomaticDimension
        
        self.reservationTabelView.register(UINib(nibName: "DetailViewCell_W", bundle: nil), forCellReuseIdentifier: "CellTB_R_W")
        self.reservationTabelView.estimatedRowHeight = cellHeight
        self.reservationTabelView.rowHeight = UITableViewAutomaticDimension
        
        self.reservationTabelView.register(UINib(nibName: "URLCell_W", bundle: nil), forCellReuseIdentifier: "CellTB_R_W_URL")
        self.reservationTabelView.estimatedRowHeight = cellHeight
        self.reservationTabelView.rowHeight = UITableViewAutomaticDimension
        
        //ホテル名
        hotelName.text = getKeyDic["hotelName"] as! String
        //紹介コメント
        hotelComment.text = getKeyDic["comment"] as! String
        hotelComment.sizeToFit()          // 文字数に合わせて縦に伸びます。
        


        //画像スライドショー-----------------------------------------------------------------------------------------------
        
        // Totalのページ数
        let imageNum = getKeyDic["image"] as! Int
        let pageNum:Int  = imageNum

        //スクリーンサイズはmainのサイズを参照
        let screenSize: CGRect = UIScreen.main.bounds
        
        //imageViewスクリーンの幅を指定
        let id = getKeyDic["id"] as! Int

        let imageTop:UIImage = UIImage(named: "\(id)_1")!
        
        //画面サイズから、スクリーンサイズ算出
        let gamenWidth = self.view.frame.size.width
        //let gamenHeight = self.view.frame.size.height
        
        //TODO:オートレイアウトをかけるまでSE以外のサイズはずれる。画面の幅からの逆算の為。
        //imageViewのスクリーンサイズ高さ指定
        screenWidth = gamenWidth - 32
        screenHeight = screenWidth * 204/288

        
        print("pWidth: \(screenWidth)")
        
        for i in 0 ..< pageNum {
            let n:Int = i+1
            
            // 1.UIImageViewのインスタンス
            let image:UIImage = UIImage(named: "\(id)_\(n)")!
            let imageView = UIImageView(image:image)
            
            // 2.画像ごとにそのframeサイズを設定
            //rectにimaeViewの寸法、位置情報を代入
            var rect:CGRect = imageView.frame
            
            //幅はTPOと同じ
            //高さは参照データに合わせ変更
            screenWidth = gamenWidth - 32
            screenHeight = screenWidth * 204/288
            rect.size.width = screenWidth
            rect.size.height = screenHeight
            imageView.frame = rect
            imageView.tag = n
            
            // UIScrollViewのインスタンスに画像を貼付ける
            self.hotelImageScrollView.addSubview(imageView)
            
        }
        setupScrollImages()
        
    }

    // 3.addSubview でUIScrollViewに加える
    func setupScrollImages(){
        
        // Totalのページ数
        let imageNum = getKeyDic["image"] as! Int
        let pageNum:Int  = imageNum
        
        // ダミー画像
        let id = getKeyDic["id"] as! Int
        let imageDummy:UIImage = UIImage(named:"\(id)_1")!
        var imgView = UIImageView(image:imageDummy)
        var subviews:Array = hotelImageScrollView.subviews
        
        // 4.描画開始のカーソルポイントを決める x,y 位置
        var px:CGFloat = 0.0
        let py:CGFloat = 0.0
        
        for i in 0 ..< subviews.count {
            imgView = subviews[i] as! UIImageView
            if (imgView.isKind(of: UIImageView.self) && imgView.tag > 0){
                
                var viewFrame:CGRect = imgView.frame
                viewFrame.origin = CGPoint(x: px, y: py)
                imgView.frame = viewFrame
                
                px += (screenWidth)
                
            }
        }
        // 5.UIScrollViewのコンテンツサイズを画像のtotalサイズに合わせる
        let nWidth:CGFloat = screenWidth * CGFloat(pageNum)
        hotelImageScrollView.contentSize = CGSize(width: nWidth, height: screenHeight)
        
        
        
        //地図---------------------------------------------------------------------
        let latitude = getKeyDic["latitude"] as! String
        let longitude = getKeyDic["longitude"] as! String
        //座標オブジェクト
        //型変換が必要。String型〜Double型へ。atof()でくくると変わる。
        let coodineate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
        //縮尺を設定
        let span = MKCoordinateSpanMake(0.05, 0.05)
        //範囲オブジェクトを作成
        let region = MKCoordinateRegionMake(coodineate, span)
        //地図にセット
        hotelMap.setRegion(region,animated: true)
        // 1.pinオブシェクトを生成（）内は不要
        let myPin = MKPointAnnotation()
        // 2.pinの座標を設定
        myPin.coordinate = coodineate
        // 3.タイトル、サブタイトルを設定（タップした時に出る、吹き出しの情報）
        let myPinHotelName = getKeyDic["hotelName"] as! String
        myPin.title = "\(myPinHotelName)"
        // 4.mapViewにPinを追加
        hotelMap.addAnnotation(myPin)

        
        
        //住所--------------------------------------------------------------------
        hotelAddress.text = getKeyDic["address"] as! String
        hotelAddress.sizeToFit() // 文字数に合わせて縦に伸びます。
    }

    

    //TableView行数の設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return 10
        default:
            return 8
        }
    }
    
    
    //TableView表示する文字列を決定（テーブルビュー２つ）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 1:
            detailedInfoTableView.separatorColor = UIColor.white
            switch indexPath.row {
            case 0:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "宿泊費（詳細情報はHPからご確認ください。）"
                cellW.selectedBackgroundView?.backgroundColor = UIColor.blue
                return cellW
            case 1:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_W", for: indexPath) as! detailViewCell_W
                cellW.varticalLabel.text = getKeyDic["accommodation"] as! String
                self.reservationTabelView.rowHeight = UITableViewAutomaticDimension

                cellW.selectedBackgroundView?.backgroundColor = UIColor.blue
                return cellW
            case 2:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "部屋数"
                cellW.selectedBackgroundView?.backgroundColor = UIColor.blue
                return cellW
            case 3:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_W", for: indexPath) as! detailViewCell_W
                cellW.varticalLabel.text = "全\(getKeyDic["rooms"] as! String)部屋"
                return cellW
            case 4:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "Wi-Fi"
                return cellW
            case 5:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_W", for: indexPath) as! detailViewCell_W
                cellW.varticalLabel.text = getKeyDic["wifi"] as! String
                return cellW
            case 6:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "送迎"
                return cellW
            case 7:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_W", for: indexPath) as! detailViewCell_W
                cellW.varticalLabel.text = getKeyDic["pickup"] as! String
                return cellW
            case 8:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "施設設備"
                return cellW
            default:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_D_W", for: indexPath) as! detailViewCell_W
                cellW.varticalLabel.text = getKeyDic["equipment"] as! String
                return cellW
            }
            
        default:
            reservationTabelView.separatorColor = UIColor.white
            switch indexPath.row {
            case 0:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_R_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "予約方法"
                return cellW
            case 1:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_R_W_URL", for: indexPath) as! urlCell_W
                cellW.urlButtonTitle.setTitle("\(getKeyDic["reservation"] as! String)（詳しくは、HPよりご確認ください。）", for: .normal)
                //セルのURLを記憶
                //cellW.urlButtonTitle.tag = getKeyDic["id"] as! Int
                cellW.urlButtonTitle.tag = 2222
                return cellW
            case 2:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_R_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "TEL"
                return cellW
            case 3:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_R_W", for: indexPath) as! detailViewCell_W
                cellW.varticalLabel.text = getKeyDic["tel"] as! String
                return cellW
            case 4:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_R_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "E-Mail"
                return cellW
            case 5:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_R_W", for: indexPath) as! detailViewCell_W
                cellW.varticalLabel.text = getKeyDic["email"] as! String
                cellW.textLabel?.textColor = UIColor.black
                return cellW
            case 6:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_R_G", for: indexPath) as! detailViewCell_G
                cellW.varticalLabel.text = "公式HP"
                return cellW
            default:
                let cellW = tableView.dequeueReusableCell(withIdentifier: "CellTB_R_W_URL", for: indexPath) as! urlCell_W
                cellW.urlButtonTitle.setTitle("\(getKeyDic["hotelName"] as! String)の公式HPはこちら", for: .normal)
                //getKeyDic["url"] as! String
                return cellW
            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableHeight.constant = detailedInfoTableView.contentSize.height
//    }

    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.deselectRow(at: indexPath, animated: true)
        return indexPath
    }

    
    
    //TODO:色が変わらない。セルがタップされたらURLに飛ぶ（セル内にURL情報）ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
//    //セルがタップされたら発動
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch tableView.tag {
//        case 1:
//            return
//        default:
//            //タップ時に色が変わらない
//           // tableView.deselectRow(at: indexPath, animated: true)
//            print("\(indexPath.row)行目をタップしました。")
//            //指定のリンク先へ飛ぶ
//            let resUrl = getKeyDic["reservation_URL"] as! String
//            let url = URL(string: "resUrl")!
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url)
//            }
//            return
//        }
//    }

    
    
    
    //TODO:オートレイアウト　謎のエラー？？？
//    //オートレイアウトの設定。下の順番で発動
//    //1.estimatedHeightForRowAtIndexPath セルの大体の位置を決める
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = generateCell(tableView, indexPath: indexPath)
//        return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//    }
//
//    //2.heightForRowAtIndexPathで、初めて、ちゃんとした正確なセルのフレームをセット
//    //estimatedHeightForRowAtIndexPathで得た前情報とheightForRowAtIndexPathで得た値が離れている場合,エラーの危険性あり。（ものすごくずれる。上で返す値は、出来る限り０に近くする。）
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//        return generateCell(tableView, indexPath: indexPath)
//    }
//
//    //3.heightForRowAtIndexPath
//    //cellにデータを詰めるのはcellForRowAtIndexPath
//    //前段階で同じ型のセルに同じデータを当てはめて,高さを計算する必要あり。
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    func generateCell(tableView: UITableView, indexPath: NSIndexPath) -> VariableTableViewCell {
//        let cell: detailViewCell_W = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as! detailViewCell_W
//        let entity: Entity = array[indexPath.row]
//        cell.setValue(entity)
//        cell.contentView.layoutIfNeeded()
//
//        return cell
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

