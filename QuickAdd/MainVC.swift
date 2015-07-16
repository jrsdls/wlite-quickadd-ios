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
    
    var lists = [WList]()
    var defaultList: WList!
    
    // TODO: load lists and show to picker when listButton is tapped
    
    // TODO: implement addItem to default list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.backgroundColor = UIColor.appDarkMainColor()
        self.view.backgroundColor = UIColor.appDarkMainColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.appDarkMainColor()]
//        self.navigationController!.navigationBar.barTintColor = UIColor.appMainColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        println("MainVC.isAuthenticated " + (isAuthenticated() ? "yes" : "no"))
        if (!isAuthenticated()) {
            performSegueWithIdentifier("showAuthVC", sender: self)
        }else {
            if textField.canBecomeFirstResponder() {
                textField.becomeFirstResponder()
            }
//            listButton.setTitle("A very very very long list title", forState: .Normal)
            
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                "X-Client-ID": App.clientID,
                "X-Access-Token": App.accessToken!
            ]
            
            // TODO: load Lists if empty
            self.readLists()
        }

    }
    
    // MARK: - Action Methods
    
    @IBAction func listButtonTapped(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rect = CGRect(x: self.view.frame.width - ListPickerVC.width - 5, y: 16, width: ListPickerVC.width, height: ListPickerVC.height)
        pickerVC = nil
        pickerVC = storyboard.instantiateViewControllerWithIdentifier("ListPickerVC") as! ListPickerVC
        pickerVC.lists = lists
        pickerVC.delegate = self
        pickerVC.presentPickerFromRect(rect, inView: self.view, animated: true)
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if defaultList != nil {
            self.createTask(textField.text, forList: defaultList.id)
            textField.text = ""
        }
        return false
    }
    
    // MARK: - ListPickerDelegate Methods
    
    func pickerVC(vc: ListPickerVC, didFinishPickingList list: WList) {
        vc.delegate = nil
        self.pickerVC = nil
        
        self.defaultList = list;
        self.listButton.setTitle(list.title.capitalizedString, forState: .Normal)
    }
    
    func pickerVCDidCancel(vc: ListPickerVC) {
        vc.delegate = nil
        self.pickerVC = nil
    }
    
    // MARK: - Convenience Methods
    
    private func isAuthenticated() -> Bool{
        // TODO: build new common framework release with latest code and use Wlite.isAuthenticated()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.stringForKey("com.wlite.oauth.accessToken") != nil
    }
    
    func readLists() {
        Alamofire
            .request(CListRouter.ReadLists())
            .responseJSON(options: nil, completionHandler: {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                    println("response: \(response)")
                }
                if (JSON != nil) {
//                    println("result: \(JSON!)")
                    self.lists = [WList]()
                    if let rawLists  = JSON as? [[String:AnyObject]] {
                        for rawList in rawLists {
                            var list = WList(id: rawList["id"] as! Int, revision: rawList["revision"] as! Int, title: rawList["title"] as! String)
                            self.lists.append(list)
//                            println(" * \(list.title) | \(list.id)")
                            
                            if list.title == "inbox" {
                                self.defaultList = list
                            }
                        }
                    }
//                    println("result: \(self.lists)")
                }
            })
    }
    
    func createTask(title: String, forList listid:Int){
        let parameters : [ String : AnyObject] = [
            "title": title,
            "list_id": listid
        ]
        Alamofire
            .request(CTaskRouter.CreateTask(parameters))
            .responseJSON(options: nil, completionHandler: {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
                
                if (error != nil) {
                    println("error: \(error)")
                    println("response: \(response)")
                    Drop.down("Error: \(error)", state: .Success)
                }
                if (JSON != nil) {
                    Drop.down("Item successfuly added...", state: .Success)
                }
            })
    }

}
