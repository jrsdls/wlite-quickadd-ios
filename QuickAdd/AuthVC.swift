//
//  AuthVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 6/16/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import Common

class AuthVC: UIViewController {
    
    @IBOutlet weak var authenticateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        println("AuthVC did load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods
    
    @IBAction func authenticateButtonTapped(sender: AnyObject) {
        // TODO: do authentication here
        println("AuthVC authenticateButtonTapped")
        
        let callbackURL = "https://dl.dropboxusercontent.com/u/33491043/sites/wlite/quickadd/success.html"
        Wlite.authorizeWithCallbackURL(callbackURL, successHandler: { (token) -> Void in
            println("authorization successful: \(token)")
            
            // TODO: close auth page (this page)
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
                println("AuthVC dismissed ...");
            });
            
            
            //            self.readUser()
            //            self.readFolders()
            //            self.readFolderRevisions()
            //            self.readFolder("946735")
            //            self.readLists()
            //            self.createList("Bucket")
            //            self.readList("86173208")
            //            self.createTask("Test task, hola mundo!", forList: 164291775);
            //            self.readTasks("86173208")
            
            }) { (error) -> Void in
                println("authorization failed: \(error)")
        };
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
