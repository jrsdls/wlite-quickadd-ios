//
//  AddVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 8/4/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit

class AddVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifiers = ["titleCellIdentifier","listCellIdentifier", "dueDateCellIdentifier", "reminderCellIdentifier"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIdentifiers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifiers[indexPath.row], forIndexPath: indexPath) as! UITableViewCell
        
//        let imageView = cell.contentView.subviews.first as! UIImageView
//        imageView.image = UIImage(named: "folder-50")
        
//        cell.preservesSuperviewLayoutMargins = false
//        cell.layoutMargins = UIEdgeInsetsZero
//        cell.separatorInset = UIEdgeInsetsZero
        return cell
    }

}
