//
//  CommentCaseViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 22/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let cellID = "CommentCaseTableViewCellID"

class CommentCaseViewController: UIViewController {
    
    //MARK:- 定义属性
    var orderModel = OrderModel()
    private lazy var commentVM : CommentViewModel = CommentViewModel()
    private lazy var orderVM : OrderViewModel = OrderViewModel()
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var comments: UITextView!
    //添加手势
    @IBOutlet weak var addImage: UIImageView!
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.separatorStyle = .none
//        tableView.backgroundColor = UIColor.groupTableViewBackground
//        let nib = UINib(nibName: "CommentCaseTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: cellID)
        storeName.text = orderModel.storeName
        var goodsNameStr : String = ""
        for goods in orderModel.goodsList {
            let name = goods.goodsName
            goodsNameStr += name
        }
        goodsName.text = goodsNameStr
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func CommitComment(_ sender: Any) {
        //提交后台
        //1.toDict
        let dict = toDict()
        //2.提交数据
        commentVM.submitData(dict: dict) { (flag) in
            if flag{
                print("评论成功")
                self.orderModel.commentFlag = 1
                self.orderVM.updateFlag(orderId: self.orderModel.orderId, finishedCallback: { (flag) in
                    if flag {
                        print("修改成功")
                    }
                    else{
                        print("修改失败")
                    }
                })
                self.navigationController?.popViewController(animated: true)
                UIAlertController.showStatus(message: "评论成功")
            }
            else{
                print("评论失败")
                UIAlertController.showStatus(message: "评论失败，请重试")
            }
        }
    }
    
    private func toDict() -> [String : NSObject]{
        var dict = [String : NSObject]()
        
        dict["storeId"] = orderModel.storeId as NSObject
        dict["storeName"] = orderModel.storeName as NSObject
        dict["goodsName"] = goodsName.text! as NSObject
        dict["comments"] = comments.text as NSObject
        dict["userId"] = USERID as NSObject
        dict["userName"] = USERNAME as NSObject
        let currentDate = NSDate.getCurrentTime()
        dict["commitTime"] = String(describing: NSDate(timeIntervalSince1970: Double(currentDate))) as NSObject
        
        return dict
    }
    
    
}

//extension CommentCaseViewController:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 210
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CommentCaseTableViewCell
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "您的评价将匿名发送给商家"
//    }
//}

