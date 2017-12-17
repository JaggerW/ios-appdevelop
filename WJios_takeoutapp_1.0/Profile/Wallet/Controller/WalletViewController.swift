//
//  WalletViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 12/12/2017.
//  Copyright © 2017 WangJie. All rights reserved.
//

import UIKit

class WalletViewController: UITableViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    var num:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.backgroundColor = UIColor.lightGray
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            let storyboard = UIStoryboard(name: "Wallet", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DealDetailStoryBoard") as! DealDetailViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
   
}

//MARK:- 设置ui
extension WalletViewController{
    private func setupUI(){
        balanceLabel.text = num
    }
}
