//
//  MainVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 6/16/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import Alamofire
import Common
import SwiftyDrop

class MainVC: UIViewController, UITextFieldDelegate, ListPickerDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var listButton: UIButton!
    
    var pickerVC : ListPickerVC!
    
    var lists = [List]()
    var defaultList: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.backgroundColor = UIColor.appDarkMainColor()
        self.view.backgroundColor = UIColor.appDarkMainColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.appDarkMainColor()]
//        self.navigationController!.navigationBar.barTintColor = UIColor.appMainColor()
        
        if let defaultList = App.defaultList {
            self.updateDefaultList(defaultList)
        }
        
        // load lists
        self.loadListsFromLocalStore()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        println("MainVC.isAuthenticated " + (App.accessToken != nil ? "yes" : "no"))
        if (App.accessToken == nil) {
            performSegueWithIdentifier("showAuthVC", sender: self)
        }else {
            if textField.canBecomeFirstResponder() {
                textField.becomeFirstResponder()
            }
            
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                "X-Client-ID": App.clientID,
                "X-Access-Token": App.accessToken!
            ]
            
            CloudStore.fetchLists {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                }
                if (JSON != nil) {
                    if let rawLists  = JSON as? [[String:AnyObject]] {
                        
                        // update local database
                        LocalStore.lists = listsFromRawLists(rawLists)
                        
                        // reload lists
                        self.loadListsFromLocalStore()
                    }
                    else if let rawObject = JSON as? [String:AnyObject]{
                        if let jsonError = rawObject["error"] as? [String:AnyObject]{
                            let werror = WError(rawError: jsonError)
                            if werror.isAuthenticationError {
                                App.accessToken = nil
                                self.performSegueWithIdentifier("showAuthVC", sender: self)
                            }
                        }
                    }
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
            CloudStore.createTask(WTask(title: textField.text, listId: defaultList.id), completionHandler: {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                
                if (error != nil) {
                    println("error: \(error)")
                    println("response: \(response)")
                    Drop.down("Error: \(error)", state: .Error)
                }
                if (JSON != nil) {
                    Drop.down("Item successfuly added...", state: .Success)
                    textField.text = ""
                    
                    // update local database
                    self.defaultList?.lastUsedDate = NSDate()
                    LocalStore.updateList(self.defaultList!)
                    
                    // reload lists
                    self.loadListsFromLocalStore()
                }
            })
        }
        return false
    }
    
    // MARK: - ListPickerDelegate Methods
    
    func pickerVC(vc: ListPickerVC, didFinishPickingList list: List) {
        vc.delegate = nil
        self.pickerVC = nil
        
        self.updateDefaultList(list)
        App.defaultList = list
    }
    
    func pickerVCDidCancel(vc: ListPickerVC) {
        vc.delegate = nil
        self.pickerVC = nil
    }
    
    // MARK: - Convenience Methods
    
    private func loadListsFromLocalStore() {
        LocalStore.asynchronousFetchLists { (result, error) -> Void in
            if (error != nil) {
                println("error: \(error)")
            }
            if (result != nil) {
                if let molists = result!.finalResult {
                    // update list picker lists
                    self.lists = listsFromMOLists(molists as! [MOList])
                    self.sortLists()
                    
                    // update default list if necessary
                    if self.defaultList == nil  {
                        for list in self.lists {
                            if (list.listType == .Inbox) {
                                self.updateDefaultList(list)
                                App.defaultList = list
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func updateDefaultList(list:List) {
        self.defaultList = list
        self.listButton.setTitle(list.title.capitalizedString, forState: .Normal)
    }
    
    private func sortLists() {
        self.lists.sort({ (list1:List, list2:List) -> Bool in
            return list1.title < list2.title
        })
        self.lists.sort({ (list1:List, list2:List) -> Bool in
            return list1.lastUsedDateSortValue > list2.lastUsedDateSortValue
        })
    }

}
