//
//  DealDetailViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 13/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

private let dealDetailTableViewCellID = "dealDetailTableViewCellID"

class DealDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//MARK:- 设置UI
extension DealDetailViewController{
    private func setupUI(){
        //设置tableview
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        //注册cell
        let nib = UINib(nibName: "DealDetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: dealDetailTableViewCellID)
    }
}


//MARK:- 遵守tableview的delegate和DataSource
extension DealDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dealDetailTableViewCellID, for: indexPath) as! DealDetailTableViewCell
        return cell
    }
}





















