//
//  SetUpTableViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 15/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class SetUpTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            let vc = UIStoryboard(name: "User", bundle: nil).instantiateInitialViewController() as! UserTableViewController
            self.navigationItem.backBarButtonItem?.title = "账户与安全"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
