//
//  MainVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 6/16/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import Alamofire
import Wlite
import SwiftyDrop

class MainVC: UIViewController, UITextFieldDelegate, ListPickerDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var listButton: UIButton!
    
    var pickerVC : ListPickerVC!
    
    var lists = [MOList]()
    var defaultList : MOList? {
        get {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if (userDefaults.objectForKey("com.wlite.oauth.defaultList.title") != nil) {
                let id = userDefaults.integerForKey("com.wlite.oauth.defaultList.id")
                return db.fetchList(id)
            }
            else {
                return nil
            }
        }
        set {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setInteger(Int(newValue!.id), forKey: "com.wlite.oauth.defaultList.id")
            userDefaults.setObject(newValue!.title, forKey: "com.wlite.oauth.defaultList.title")
        }
    }
    
    var db:LocalStore!
    var api:API!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.backgroundColor = UIColor.appDarkMainColor()
        self.view.backgroundColor = UIColor.appDarkMainColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.appDarkMainColor()]
        
        db = LocalStore(context: App.delegate.managedObjectContext!)
        
        // load lists
        self.loadListsFromLocalStore()
        
        // retrieve default list
        if let list = self.defaultList {
            self.listButton.setTitle(list.title.capitalizedString, forState: .Normal)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (App.wlite.accessToken == nil) {
            performSegueWithIdentifier("showAuthVC", sender: self)
        }else {
            api = App.wlite.api
            
            if textField.canBecomeFirstResponder() {
                textField.becomeFirstResponder()
            }
            
            api.list.fetchLoggedInUserLists { (lists, error) -> Void in
                if let werror = error {
                    if (werror.isAuthenticationError) {
                        self.performSegueWithIdentifier("showAuthVC", sender: self)
                    }
                    else {
                        println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
                    }
                }
                else if let wlists = lists{
                    // update local database
                    var molists = [MOList]()
                    for list:List in wlists {
                        let molist = self.db.createOrUpdateList(list)
                        molists.append(molist)
                    }
                    
                    // reload lists
                    self.loadListsFromLocalStore()
                }
            }
        }

    }
    
    // MARK: - Action Methods
    
    @IBAction func listButtonTapped(sender: UIButton) {
        if (self.lists.count > 0) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rect = CGRect(x: self.view.frame.width - ListPickerVC.width - 5, y: 16, width: ListPickerVC.width, height: ListPickerVC.height)
            pickerVC = nil
            pickerVC = storyboard.instantiateViewControllerWithIdentifier("ListPickerVC") as! ListPickerVC
            pickerVC.lists = self.lists
            pickerVC.delegate = self
            pickerVC.presentPickerFromRect(rect, inView: self.view, animated: true)
        }
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let defaultList = self.defaultList {
            let list = List(id: 104379923)
            let newtask = Task(title: "blah")
            App.wlite.api.task.createTask(newtask, forList: list) { (task, error) -> Void in
                if let werror = error {
                    println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
                }
                else {
                    println("new task: \(newtask.id) | \(newtask.title)")
                    
                    Drop.down("Item successfuly added...", state: .Success)
                    textField.text = ""
                    
                    // update local database
                    self.defaultList?.lastUsedDate = NSDate()
                    self.db.updateList(self.defaultList!)
                    self.db.save()
                    
                    // reload lists
                    self.loadListsFromLocalStore()

                }
            }
        }
        return false
    }
    
    // MARK: - ListPickerDelegate Methods
    
    func pickerVC(vc: ListPickerVC, didFinishPickingList list: MOList) {
        vc.delegate = nil
        self.pickerVC = nil
        
        self.updateDefaultList(list)
        self.defaultList = list
    }
    
    func pickerVCDidCancel(vc: ListPickerVC) {
        vc.delegate = nil
        self.pickerVC = nil
    }
    
    // MARK: - Convenience Methods
    
    private func loadListsFromLocalStore() {
        // update list picker lists
        lists = db.fetchAllLists()
        self.sortLists()
        
        // update default list if necessary
        if self.defaultList == nil  {
            for list in lists {
                if (list.listType == ListType.Inbox.rawValue) {
                    self.updateDefaultList(list)
                }
            }
        }
    }
    
    private func updateDefaultList(list:MOList) {
        self.defaultList = list
        self.listButton.setTitle(list.title.capitalizedString, forState: .Normal)
    }
    
    private func sortLists() {
        self.lists.sort({ (list1:MOList, list2:MOList) -> Bool in
            return list1.title < list2.title
        })
        self.lists.sort({ (list1:MOList, list2:MOList) -> Bool in
            return list1.lastUsedDateSortValue > list2.lastUsedDateSortValue
        })
    }

}
